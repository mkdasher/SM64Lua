-- Input Direction Lua Script v3.5
-- Author: MKDasher
-- Hacker: Eddio0141
-- Special thanks to Pannenkoek2012 and Peter Fedak for angle calculation support.
-- Also thanks to MKDasher to making the code very clean
-- Other contributors:
--	Madghostek, Xander, galoomba, ShadoXFM, Lemon, Manama

PATH = debug.getinfo(1).source:sub(2):match("(.*\\)") .. "\\InputDirection_dev\\"

dofile (PATH .. "Drawing.lua")
Drawing.resizeScreen()

dofile (PATH .. "Memory.lua")
dofile (PATH .. "Settings.lua")
dofile (PATH .. "Joypad.lua")
dofile (PATH .. "Angles.lua")
dofile (PATH .. "Engine.lua")
dofile (PATH .. "Buttons.lua")
dofile (PATH .. "Input.lua")
dofile (PATH .. "Program.lua")
dofile (PATH .. "MoreMaths.lua")
dofile (PATH .. "Actions.lua")
dofile (PATH .. "Swimming.lua")

Settings.Theme = Settings.Themes.Dark -- Settings.Themes.Dark for dark mode
Settings.ShowEffectiveAngles = false -- show angles floored to the nearest multiple of 16
Drawing.useImage = false -- place an image named background.png inside the folder where Drawing.lua is and set this to true for an image background

Program.initFrame()
Memory.UpdatePrevPos()
function main()
	Program.initFrame()
	Program.main()
	Swimming.swim("A")
	Joypad.send()
end

function drawing()
	Drawing.paint()
end

function update()
	if Input.update() then
		Drawing.paint()
	end
end

function close()
	Drawing.UnResizeScreen()
end

emu.atinput(main)
emu.atvi(drawing,false)
emu.atinterval(update, false)
emu.atstop(close)
if emu.atloadstate then
	emu.atloadstate(drawing, false)
	emu.atreset(Drawing.resizeScreen,false)
else
	print("update ur mupen")
end
