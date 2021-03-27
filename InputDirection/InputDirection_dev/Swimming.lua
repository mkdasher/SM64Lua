-- This code has been adapted from an old script
-- Original Author unknown
Swimming = {}
local SWIMMING_ANIMATION_2 = 0x300024D1
local WATER_ACTION_END = 0x300022C2
local WATER_IDLE = 0x380022C0

function Swimming.swim(button)
	if not Settings.Layout.Button.swimming then return end

	if Memory.Mario.Action == SWIMMING_ANIMATION_2
		or Memory.Mario.Action == WATER_ACTION_END
		or Memory.Mario.Action == WATER_IDLE then
		j = joypad.get(1)
		if button == "B" or button == "b" then
			j.B = 1
		elseif button == "A" or button == "a" then
			j.A = 1
		end
		joypad.set(1, j)
	end
end
