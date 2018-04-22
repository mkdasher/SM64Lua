Memory = {
	Mario = {
	
	},
	Camera = {
	
	},
	Version = 1
}

GameVersion = {
	U = 1,
	J = 2
}

function Memory.Refresh()
	Memory.CheckVersion()
	if Memory.Version == GameVersion.U then
		Memory.Camera.Angle = memory.readword(0x00B3C714)
		Memory.Mario.FacingYaw = memory.readword(0x00B3B19E)
		Memory.Mario.IntendedYaw = memory.readword(0x00B3B194)
	else
		Memory.Camera.Angle = memory.readword(0x00B3B3A4)
		Memory.Mario.FacingYaw = memory.readword(0x00B39E2E)
		Memory.Mario.IntendedYaw = memory.readword(0x00B39E24)
	end
end

function Memory.CheckVersion()
	-- Checks Addr 0x80322B24:
		-- If U: 8F A6 00 1C 	LW a2 <- [sp+0x001C]		(OS func)
		-- If J: 46 00 60 04	SQRT.s f00.s = sqrt(f12.s) 	(sqrtf func)
	
	if memory.readdword(0x00B22B24) == 1174429700 then -- J version
		Memory.Version = GameVersion.J
	else -- U version
		Memory.Version = GameVersion.U
	end
end
 