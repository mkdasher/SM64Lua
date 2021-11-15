Input = {
	mousetab = {},
	mousetab_prev = {}
}

local ARROWS = {"left", "right", "up", "down"}

function Input.update()
	changes = false
	Input.mousetab = input.get(1)
	if Input.mousetab["leftclick"] and not Input.mousetab_prev["leftclick"] then
		local xmouse = Input.mousetab["xmouse"]
		local ymouse = Input.mousetab["ymouse"]
		changes = Input.check(xmouse, ymouse)
	end
	for i = 0, 9, 1 do
		if Input.mousetab["" .. i] and not Input.mousetab_prev["" .. i] then
			changes = Input.numberCheck(i) or changes
		elseif Input.mousetab["numpad" .. i] and not Input.mousetab_prev["numpad" .. i] then
			changes = Input.numberCheck(i) or changes
		end
	end
	for i = 1, 4 do
		if Input.mousetab[ARROWS[i]] and not Input.mousetab_prev[ARROWS[i]] then
			Input.arrowCheck(ARROWS[i])
		end
	end
	Input.mousetab_prev = Input.mousetab
	return changes
end

function Input.check(xmouse, ymouse)
	changes = false
	for i = 1, table.getn(Buttons), 1 do
		if Buttons[i].enabled() then
			if Buttons[i].type == ButtonType.button then
				if Input.isInRange(xmouse, ymouse, Buttons[i].box[1], Buttons[i].box[2], Buttons[i].box[3], Buttons[i].box[4]) then
					changes = true
					Buttons[i]:onclick()
					Settings.Layout.TextArea.selectedItem = 0
				end
			elseif Buttons[i].type == ButtonType.textArea then
				if Input.isInRange(xmouse, ymouse, Buttons[i].box[1], Buttons[i].box[2], Buttons[i].box[3], Buttons[i].box[4]) then
					changes = true
					Buttons[i]:onclick(Input.xSection(xmouse, Buttons[i].box[1], Buttons[i].box[3], Buttons[i].inputSize))
				end
			end
		end
	end
	return changes
end

function Input.numberCheck(num)
	changes = false
	for i = 1, table.getn(Buttons), 1 do
		if Buttons[i].enabled() then
			if Buttons[i].type == ButtonType.textArea then
				if Buttons[i].editing() then
					changes = true
					Buttons[i]:onkeypress(num)
				end
			end
		end
	end	
	return changes
end

function Input.isInRange(xmouse,ymouse,x,y,xregion,yregion)
	if xmouse >= x and xmouse <= x + xregion then
		if ymouse >= y and ymouse <= y + yregion then
			return true
		end
	end
	return false
end

function Input.xSection(xmouse, x, width, sections)
	return sections * (xmouse - x) // width + 1
end

function Input.arrowCheck(key)
	changes = false
	for i = 1, table.getn(Buttons), 1 do
		if Buttons[i].enabled() and Buttons[i].type == ButtonType.textArea and Buttons[i].editing() then
			Buttons[i]:onarrowpress(key)
		end
	end
end

local function handleScroll(hwnd, msg_id, wparam, lparam)
	if msg_id == 522 then -- WM_MOUSEWHEEL
		-- high word (most significant 16 bits) is scroll rotation in multiples of WHEEL_DELTA (120)
		local scroll = (wparam & 0xFFFF0000) >> 16
		if scroll == 120 then
			Input.arrowCheck("up")
		elseif scroll == 65416 then -- 65536 - 120
			Input.arrowCheck("down")
		end
	end
end

emu.atwindowmessage(handleScroll)
