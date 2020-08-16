Memory = {
	Mario = {
	
	},
	Camera = {
	
	},
	Version = 1,
	
	PreviousPos = {
		X = 0,
		Z = 0
	}
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
		Memory.Mario.HSpeed = memory.readdword(0x00B3B1C4)
		Memory.Mario.VSpeed = memory.readdword(0x00B3B1BC)
		Memory.Mario.XSlidingSpeed = memory.readdword(0x00B3B1C8)
		Memory.Mario.ZSlidingSpeed = memory.readdword(0x00B3B1CC)
		Memory.Mario.XSlideSpeed = memory.readdword(0x00B3B1C8)
		Memory.Mario.ZSlideSpeed = memory.readdword(0x00B3B1CC)
		Memory.Mario.X = memory.readdword(0x00B3B1AC)
		Memory.Mario.Y = memory.readdword(0x00B3B1B0)
		Memory.Mario.Z = memory.readdword(0x00B3B1B4)
		Memory.Mario.Action = memory.readdword(0x00B3B17C)
		Memory.Mario.FSpeed = memory.readfloat(0x00B3B1C4)
		Memory.Mario.Buffered = memory.readbyte(0x00B67054)
		Memory.Mario.GlobalTimer = memory.readdword(0x00B2D5D4)
	else
		Memory.Camera.Angle = memory.readword(0x00B3B3A4)
		Memory.Mario.FacingYaw = memory.readword(0x00B39E2E)
		Memory.Mario.IntendedYaw = memory.readword(0x00B39E24)
		Memory.Mario.HSpeed = memory.readdword(0x00B39E54)
		Memory.Mario.VSpeed = memory.readdword(0x00B39E4C)
		Memory.Mario.XSlideSpeed = memory.readdword(0x00B39E58)
		Memory.Mario.ZSlideSpeed = memory.readdword(0x00B39E5C)
		Memory.Mario.X = memory.readdword(0x00B39E3C)
		Memory.Mario.Y = memory.readdword(0x00B39E40)
		Memory.Mario.Z = memory.readdword(0x00B39E44)
		Memory.Mario.Action = memory.readdword(0x00B39E0C)
		Memory.Mario.FSpeed = memory.readfloat(0x00B39E54)
		Memory.Mario.Buffered = memory.readbyte(0x00B65CE4)
		Memory.Mario.GlobalTimer = memory.readdword(0x00B2C264)
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
 
function Memory.UpdatePrevPos()
	Memory.PreviousPos.X = Memory.Mario.X
	Memory.PreviousPos.Z = Memory.Mario.Z
end