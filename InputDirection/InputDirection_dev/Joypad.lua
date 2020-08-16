Joypad = {
	input = {
	
	}
}

function Joypad.init()
	Joypad.input = joypad.get(1)
end

function Joypad.send()
	joypad.set(1, Joypad.input)
end

function Joypad.set(key, value)
	Joypad.input[key] = value
end