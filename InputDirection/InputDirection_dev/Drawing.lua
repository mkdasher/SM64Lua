local BACKGROUND_COLOUR = "#222222"
local TEXT_COLOUR = "#FF0000"

Drawing = {
	WIDTH_OFFSET = 233,
	Screen = {
		Height = 0,
		Width = 0
	}
}

function Drawing.resizeScreen()
	screen = wgui.info()
	Drawing.Screen.Height = screen.height
	width10 = screen.width % 10
	if width10 == 0 or width10 == 4 or width10 == 8 then
		Drawing.Screen.Width = screen.width
		wgui.resize(screen.width + Drawing.WIDTH_OFFSET, screen.height)
	else
		Drawing.Screen.Width = screen.width - Drawing.WIDTH_OFFSET
	end
end

local function largeBrush(text)
	wgui.setfont(16,"Arial","")
	return text
end

local function mediumBrush(text)
	wgui.setfont(14,"Arial","")
	return text
end

local function smallBrush(text)
	wgui.setfont(12,"Arial","")
	return text
end

function Drawing.paint()
	wgui.setbrush(BACKGROUND_COLOUR)
	wgui.setpen(BACKGROUND_COLOUR)
	wgui.rect(Drawing.Screen.Width, 0, Drawing.Screen.Width + Drawing.WIDTH_OFFSET, Drawing.Screen.Height - 20)
	wgui.setcolor(BACKGROUND_COLOUR)
	wgui.setfont(16,"Arial","")
	for i = 1, table.getn(Buttons), 1 do
		if Buttons[i].type == ButtonType.button then
			Drawing.drawButton(Buttons[i].box[1], Buttons[i].box[2], Buttons[i].box[3], Buttons[i].box[4], Buttons[i].text, Buttons[i].pressed())
		elseif Buttons[i].type == ButtonType.textArea then
			Drawing.drawTextArea(Buttons[i].box[1], Buttons[i].box[2], Buttons[i].box[3], Buttons[i].box[4], string.format("%0".. Buttons[i].inputSize .."d", Buttons[i].value()), Buttons[i].enabled(), Buttons[i].editing())
		end
	end
	Drawing.drawAnalogStick(Drawing.Screen.Width + Drawing.WIDTH_OFFSET / 3 + 13, 90) --, 210) x+r-64
	Memory.Refresh()
	Drawing.drawInputButtons(Drawing.Screen.Width + Drawing.WIDTH_OFFSET / 3 + 13, 90-320) -- y-h from drawStick
	Drawing.drawMiscData(Drawing.Screen.Width + 13, 155+90) -- plus height of input display
end

function Drawing.drawButton(x, y, width, length, text, pressed)
	if (pressed) then wgui.setcolor("white") else wgui.setcolor("black") end
	wgui.setfont(10,"Courier","")
	wgui.setbrush("#888888")
	wgui.setpen("#888888")
	wgui.rect(x + 1, y + 1, x + width + 1, y + length + 1)
	if (pressed) then wgui.setbrush("#FF0000") else wgui.setbrush("#F2F2F2") end
	if (pressed) then wgui.setpen("#EE8888") else wgui.setpen("#888888") end
	wgui.rect(x, y, x + width, y + length)
	if (pressed) then wgui.setbrush("#EE0000") else wgui.setbrush("#E8E8E8") end
	if (pressed) then wgui.setpen("#EE0000") else wgui.setpen("#E8E8E8") end
	wgui.rect(x+1, y+1 + length/2, x-1 + width, y-1 + length)
	wgui.text(x + width/2 - 4.5 * string.len(text), y + length/2 - 7, text)
end

function Drawing.drawTextArea(x, y, width, length, text, enabled, editing)
	wgui.setcolor(TEXT_COLOUR)--("red")
	wgui.setfont(16,"Courier","b")
	if (editing) then wgui.setbrush("#FFFF00") elseif (enabled) then wgui.setbrush("#FFFFFF") else wgui.setbrush("#AAAAAA") end
	wgui.setpen("#000000")
	wgui.rect(x + 1, y + 1, x + width + 1, y + length + 1)
	wgui.setpen("#888888")
	wgui.line(x+2,y+2,x+2,y+length)
	wgui.line(x+2,y+2,x+width,y+2)
	if (editing) then
		selectedChar = Settings.Layout.TextArea.selectedChar
		text = string.sub(text,1, selectedChar - 1) .. "_" .. string.sub(text, selectedChar + 1, string.len(text))
	end
	wgui.text(x + width/2 - 6.5 * string.len(text), y + length/2 - 8, text)
end

function Drawing.drawAnalogStick(x, y)
	wgui.setpen("#000000")
	wgui.setbrush("#DDDDDD")
	local r = 80 -- radius
	local m = 128 -- max input
	wgui.rect(x-r,y-r,x+r,y+r)
	wgui.setbrush("#FFFFFF")
	wgui.ellipse(x-r,y-r,x+r,y+r)
	wgui.line(x-r, y, x+r, y)
	wgui.line(x, y-r, x, y+r)
	wgui.setpen("#0000FF")
	wgui.line(x, y, x + Joypad.input.X*r/m, y - Joypad.input.Y*r/m)
	wgui.setpen("#FF0000")
	wgui.setbrush("#FF0000")
	wgui.ellipse(x-4 + Joypad.input.X*r/m, y-4 - Joypad.input.Y*r/m, x+4 + Joypad.input.X*r/m, y+4 - Joypad.input.Y*r/m)
	wgui.setfont(14,"Arial","")
	wgui.text(x + r + 2, y - 25, "x: " .. Joypad.input.X)
	if Joypad.input.Y == 0 then
		wgui.text(x + r + 2, y, "y: 0")
	else
		wgui.text(x + r + 2, y, "y: " .. -Joypad.input.Y)
	end
end

-- pass wgui.rect or wgui.ellipse to the shape param
local function drawInputButton(pressed, highlightedColour, text, shape, x, y, w, h, textoffset_x, textoffset_y)
	if (pressed) then
		wgui.setbrush(highlightedColour)
		wgui.setcolor(BACKGROUND_COLOUR)
	else
		wgui.setbrush(BACKGROUND_COLOUR)
		wgui.setcolor(TEXT_COLOUR)
	end
	wgui.setpen(TEXT_COLOUR)
	shape(x, y, x + w, y + h)
	if textoffset_x == nil then textoffset_x = 6 end
	if textoffset_y == nil then textoffset_y = 8 end
	wgui.text(x + w / 2 - textoffset_x, y + h / 2 - textoffset_y, text)
end

-- in the future: make these a ratio instead of hardcoded numbers
-- adapted from ShadoXFM's code
function Drawing.drawInputButtons(x, y)
	wgui.setpen("#FFFFFF")
	wgui.setfont(13,"Arial","b")
	drawInputButton(Joypad.input.A, "#CCCCFF", "A", wgui.ellipse, x+4, y+470, 29, 29)
	drawInputButton(Joypad.input.B, "#CCFFCC", "B", wgui.ellipse, x-15, y+441, 29, 29)
	drawInputButton(Joypad.input.start, "#FFCCCC", "S", wgui.ellipse, x-47, y+470, 29, 29)
	drawInputButton(Joypad.input.R, "#DDDDDD", "R", wgui.rect, x+20, y+410, 72, 21)
	drawInputButton(Joypad.input.L, "#DDDDDD", "L", wgui.rect, x-69, y+410, 72, 21)
	drawInputButton(Joypad.input.Z, "#DDDDDD", "Z", wgui.rect, x-78, y+440, 21, 59)
	wgui.setcolor("white")
	wgui.text(x+62, y+459, "C")
	wgui.setfont(13,"Marlett","") -- arrows for C buttons
	drawInputButton(Joypad.input.Cleft, "#FFFFCC", "3", wgui.ellipse, x+38, y+457, 21, 21, 8, 7)
	drawInputButton(Joypad.input.Cright, "#FFFFCC", "4", wgui.ellipse, x+77, y+457, 21, 21, 9, 7)
	drawInputButton(Joypad.input.Cup, "#FFFFCC", "5", wgui.ellipse, x+57, y+438, 21, 21, 8, 8)
	drawInputButton(Joypad.input.Cdown, "#FFFFCC", "6", wgui.ellipse, x+57, y+478, 21, 21, 8, 8)
	wgui.setcolor(TEXT_COLOUR)
end

function Drawing.drawMiscData(x, y_0, display_input_text)

	speed = 0
	if Memory.Mario.VSpeed > 0 then
		speed = MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.VSpeed), 6)
	end

	local elements = {
		function(y) return wgui.text(x, y, largeBrush("Frame: " .. emu.samplecount())) end,
		function(y) return wgui.text(x, y, largeBrush("Yaw (Facing): " .. Memory.Mario.FacingYaw)) end,
		function(y) return wgui.text(x, y, smallBrush("Yaw (Intended): " .. Memory.Mario.IntendedYaw)) end,
		function(y) return wgui.text(x, y, largeBrush("H Spd: " .. MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.HSpeed), 5))) end,
		function(y) return wgui.text(x, y, smallBrush("H Sliding Spd: " .. MoreMaths.Round(Engine.GetHSlidingSpeed(), 6))) end,
		function(y) return wgui.text(x, y, "XZ Movement: " .. MoreMaths.Round(Engine.GetDistMoved(), 6)) end,
		function(y) return wgui.text(x, y, string.format("Spd Efficiency: %.2f%%", Engine.GetSpeedEfficiency())) end,
		function(y) return wgui.text(x, y, largeBrush("Y Spd: " .. speed)) end,
		function(y) return wgui.text(x, y, smallBrush("Mario X: " .. MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.X))), 6) end,
		function(y) return wgui.text(x, y, "Mario Y: " .. MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.Y)), 6) end,
		function(y) return wgui.text(x, y, "Mario Z: " .. MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.Z)), 6) end,
		function(y) return wgui.text(x, y, mediumBrush("Action: " .. Engine.GetCurrentAction())) end
	}

	local spacing = {30, 32, 25, 32, 25, 20, 20, 32, 25, 20, 20, 32}

	local y = y_0
	for i = 1, table.getn(elements) do
		y = y + spacing[i]
		elements[i](y)
	end

end
