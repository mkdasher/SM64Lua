Program = {

}

function Program.initFrame()
	Memory.UpdatePrevPos()
	Memory.Refresh()
	Joypad.init()
end

function Program.main()
	if Settings.Layout.Button.selectedItem ~= Settings.Layout.Button.DISABLED then
		result = Engine.inputsForAngle()
		Joypad.set('X', result.X)
		Joypad.set('Y', result.Y)
	end
end