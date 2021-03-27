Drawing = {
	WIDTH_OFFSET = 222,
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

function Drawing.paint()
	wgui.setbrush("#CCCCFF")
	wgui.setpen("#CCCCFF")
	wgui.rect(Drawing.Screen.Width, 0, Drawing.Screen.Width + Drawing.WIDTH_OFFSET, Drawing.Screen.Height - 20)
	for i = 1, table.getn(Buttons), 1 do
		if Buttons[i].type == ButtonType.button then
			Drawing.drawButton(Buttons[i].box[1], Buttons[i].box[2], Buttons[i].box[3], Buttons[i].box[4], Buttons[i].text, Buttons[i].pressed())
		elseif Buttons[i].type == ButtonType.textArea then
			local value = Buttons[i].value()
			Drawing.drawTextArea(Buttons[i].box[1], Buttons[i].box[2], Buttons[i].box[3], Buttons[i].box[4], value and string.format("%0".. tostring(Buttons[i].inputSize) .."d", value) or string.rep('-', Buttons[i].inputSize), Buttons[i].enabled(), Buttons[i].editing())
		end
	end
	Drawing.drawAnalogStick(Drawing.Screen.Width + Drawing.WIDTH_OFFSET / 3, 210)
	wgui.setcolor("black")
	wgui.setfont(10,"Arial","")
	wgui.text(Drawing.Screen.Width + 149, 146, "Magnitude")
	Memory.Refresh()
	Drawing.drawAngles(Drawing.Screen.Width + 16, 280)
	Drawing.drawMiscData(Drawing.Screen.Width + 16, 340)
end

function Drawing.drawAngles(x, y)
	if Settings.ShowEffectiveAngles then
		wgui.text(x, y, "Yaw (Facing): " .. Engine.getEffectiveAngle(Memory.Mario.FacingYaw))
		wgui.text(x, y + 15, "Yaw (Intended): " .. Engine.getEffectiveAngle(Memory.Mario.IntendedYaw))
		wgui.text(x, y + 30, "Opposite (Facing): " ..  (Engine.getEffectiveAngle(Memory.Mario.FacingYaw) + 32768) % 65536)
		wgui.text(x, y + 45, "Opposite (Intended): " ..  (Engine.getEffectiveAngle(Memory.Mario.IntendedYaw) + 32768) % 65536)
	else
		wgui.text(x, y, "Yaw (Facing): " .. Memory.Mario.FacingYaw)
		wgui.text(x, y + 15, "Yaw (Intended): " .. Memory.Mario.IntendedYaw)
		wgui.text(x, y + 30, "Opposite (Facing): " ..  (Memory.Mario.FacingYaw + 32768) % 65536)
		wgui.text(x, y + 45, "Opposite (Intended): " ..  (Memory.Mario.IntendedYaw + 32768) % 65536)
	end
end

function Drawing.drawButton(x, y, width, length, text, pressed)
	if (pressed) then wgui.setcolor("white") else wgui.setcolor("black") end
	wgui.setfont(10,"Arial","")
	wgui.setbrush("#888888")
	wgui.setpen("#888888")
	wgui.rect(x + 1, y + 1, x + width + 1, y + length + 1)
	if (pressed) then wgui.setbrush("#FF0000") else wgui.setbrush("#F2F2F2") end
	if (pressed) then wgui.setpen("#EE8888") else wgui.setpen("#888888") end
	wgui.rect(x, y, x + width, y + length)
	if (pressed) then wgui.setbrush("#EE0000") else wgui.setbrush("#E8E8E8") end
	if (pressed) then wgui.setpen("#EE0000") else wgui.setpen("#E8E8E8") end
	wgui.rect(x+1, y+1 + length/2, x-1 + width, y-1 + length)
	wgui.text(x + width/1.5 - 4.5 * string.len(text), y + length/2 - 7.5, text)
end

function Drawing.drawTextArea(x, y, width, length, text, enabled, editing)
	wgui.setcolor("black")
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
	wgui.rect(x-64,y-64,x+64,y+64)
	wgui.setbrush("#FFFFFF")
	wgui.ellipse(x-64,y-64,x+64,y+64)
	if Settings.goalMag and Settings.goalMag < 127 then
		wgui.setbrush("#DDDDFF")
		local r = Settings.goalMag + 6
		wgui.ellipse(x-r/2,y-r/2,x+r/2,y+r/2)
	end
	wgui.line(x-64, y, x+64, y)
	wgui.line(x, y-64, x, y+64)
	wgui.setpen("#0000FF")
	wgui.line(x, y, x + Joypad.input.X/2,y - Joypad.input.Y/2)
	wgui.setpen("#FF0000")
	wgui.setbrush("#FF0000")
	wgui.ellipse(x-4 + Joypad.input.X/2,y-4 - Joypad.input.Y/2,x+4 + Joypad.input.X/2,y+4 - Joypad.input.Y/2)
	wgui.setcolor("black")
	wgui.setfont(10,"Courier","")
	wgui.text(x + 90 - 2.5 * (string.len(Joypad.input.Y == 0 and "0" or -Joypad.input.Y)), y + 4, "y:" .. (Joypad.input.Y == 0 and "0" or -Joypad.input.Y))
	wgui.text(x + 90 - 2.5 * (string.len(Joypad.input.X)), y - 14, "x:" .. Joypad.input.X)
end

function Drawing.drawMiscData(x, y)
	speed = 0
	if Memory.Mario.HSpeed ~= 0 then
		speed = MoreMaths.DecodeDecToFloat(Memory.Mario.HSpeed)
	end
	wgui.text(x, y, "H Spd: " .. MoreMaths.Round(speed, 5))

	wgui.text(x, y + 45, "Spd Efficiency: " .. Engine.GetSpeedEfficiency() .. "%")

	speed = 0
	if Memory.Mario.VSpeed > 0 then
		speed = MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.VSpeed), 6)
	end
	wgui.text(x, y + 60, "Y Spd: " .. speed)

	wgui.text(x, y + 15, "H Sliding Spd: " .. MoreMaths.Round(Engine.GetHSlidingSpeed(), 6))

	wgui.text(x, y + 75, "Mario X: " .. MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.X), 2), 6)
	wgui.text(x, y + 90, "Mario Y: " .. MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.Y), 2), 6)
	wgui.text(x, y + 105, "Mario Z: " .. MoreMaths.Round(MoreMaths.DecodeDecToFloat(Memory.Mario.Z), 2), 6)

	wgui.text(x, y + 30, "XZ Movement: " .. MoreMaths.Round(Engine.GetDistMoved(), 6))

	wgui.text(x, y + 120, "Action: " .. Engine.GetCurrentAction())

	distmoved = Engine.GetTotalDistMoved()
	if (Settings.Layout.Button.dist_button.enabled == false) then
		distmoved = Settings.Layout.Button.dist_button.dist_moved_save
	end
	wgui.text(x, y + 135, "Moved Dist: " .. distmoved)
end
