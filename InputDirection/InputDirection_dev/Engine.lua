Engine = {

}

function Engine.getEffectiveAngle(angle)
	return angle - (angle % 16)
end
function Engine.getDyaw(angle)
	if Settings.Layout.Button.strain_button.left == true and Settings.Layout.Button.strain_button.right == false then
		return cFacingYaw + angle
	elseif Settings.Layout.Button.strain_button.left == false and Settings.Layout.Button.strain_button.right == true then
		return cFacingYaw - angle
	elseif Settings.Layout.Button.strain_button.left == false and Settings.Layout.Button.strain_button.right == false then
		return cFacingYaw + angle*(math.pow(-1,Memory.Mario.GlobalTimer % 2))
	else
		return angle
	end
end
function Engine.getDyawsign()
	if Settings.Layout.Button.strain_button.left == true and Settings.Layout.Button.strain_button.right == false then
		return 1
	elseif Settings.Layout.Button.strain_button.left == false and Settings.Layout.Button.strain_button.right == true then
		return -1
	elseif Settings.Layout.Button.strain_button.left == false and Settings.Layout.Button.strain_button.right == false then
		return math.pow(-1,Memory.Mario.GlobalTimer % 2)
	else
		return 0
	end
end
ENABLE_REVERSE_ANGLE_ON_WALLKICK = 1
actionflag = 0
speedsign = 0
targetspeed = 0.0
function Engine.getgoal(targetspd) -- getting angle for target speed
	if (targetspd > 0) then
		return math.floor(math.acos((targetspd+0.35-Memory.Mario.FSpeed)/1.5)*32768/math.pi)
	end
	return math.floor(math.acos((targetspd-0.35-Memory.Mario.FSpeed)/1.5)*32768/math.pi)
end
function Engine.getArctanAngle(r, d, n, s)
	-- r is ratio, d is displacement (offset), n is number of frames and  s is starting frame
	if emu.atloadstate then s = s - 1 end
	if (s < Memory.Mario.GlobalTimer and s > Memory.Mario.GlobalTimer - n - 1) then
		yaw = 0
		if (Memory.Mario.Action == 0x000008A7 or Memory.Mario.Action == 0x010208B6 or Memory.Mario.Action == 0x010208B0 or Memory.Mario.Action == 0x08100340 or Memory.Mario.Action == 0x00100343 and ENABLE_REVERSE_ANGLE_ON_WALLKICK == 1) then
			yaw = 32768
		end
		if Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_ANGLE then
			yaw = (cFacingYaw + yaw) % 65536
			if(math.abs(yaw-goal) > 16384 and math.abs(yaw-goal) <= 49152) then
				r = -math.abs(math.tan(math.pi/2-(Engine.getEffectiveAngle(yaw)-goal)*math.pi/32768))
			else
				r = math.abs(math.tan(math.pi/2-(Engine.getEffectiveAngle(yaw)-goal)*math.pi/32768))
			end
		end
		if (Settings.Layout.Button.strain_button.reverse_arc == false) then
			dyaw = math.floor((math.pi/2-math.atan(0.15*(r*math.max(1,(n+1-Memory.Mario.GlobalTimer+s))+d/math.min(1,n+1-Memory.Mario.GlobalTimer+s))))*32768/math.pi)
			if(Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_ANGLE) then
				if((yaw-goal+32768)%65536-32768 > 0 and (yaw-goal+32768)%65536-32768 < 32768) then
					return yaw - dyaw
				end
				return yaw + dyaw
			end
			return (Engine.getDyaw(dyaw) + yaw) % 65536
		end
		dyaw = math.floor((math.pi/2-math.atan(0.15*(r*math.max(1,(Memory.Mario.GlobalTimer-s))+d/math.min(1,Memory.Mario.GlobalTimer-s))))*32768/math.pi)
		if(Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_ANGLE) then
			if((yaw-goal+32768)%65536-32768 > 0 and (yaw-goal+32768)%65536-32768 < 32768) then
				return yaw - dyaw
			end
			return yaw + dyaw
		end
		return (Engine.getDyaw(dyaw) + yaw) % 65536
	end
	return goal
end

function Engine.inputsForAngle()
	goal = Settings.goalAngle
	-- sets goal pitch for swimming
	if Memory.Mario.Action % 0x200 >= 0x0C0 and Memory.Mario.Action % 0x200 <= 0x0EF and Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_ANGLE then
		local targetPitch = goal
		local sign = 1
		-- shortcut for negative pitch
		if targetPitch >= 80000 then
			targetPitch = -(targetPitch - 80000)
		end
		if targetPitch > 32767 then
			targetPitch = targetPitch - 65536
		end
		if targetPitch < 0 then
			targetPitch = -targetPitch
			sign = -sign
		end
		if targetPitch > 16128 then
			-- invalid target pitch
			return {
				angle = 0,
				X = 0,
				Y = 0
			}
		end
		local baseStickY = targetPitch / 252
		if baseStickY == math.floor(baseStickY) then
			if baseStickY ~= 0 then
				baseStickY = baseStickY + 6
			end
			return {
				angle = targetPitch % 65536,
				X = 0,
				Y = math.floor(baseStickY) * -sign
			}
		end

		local bestX = 0
		local bestY = 0
		local closestDiff = 65536
		for newY = math.floor(baseStickY), 120 do
			if newY ~= 1 then
				local newX = newY * math.sqrt((16128 / targetPitch)^2 - 1)
				if newX > 121 then break end
				local higherPitch = math.floor(252 * newY * math.min(64 / math.sqrt(math.floor(newX)^2 + newY^2), 1))
				local lowerPitch = math.floor(252 * newY * math.min(64 / math.sqrt(math.ceil(newX)^2 + newY^2), 1))
				local diff = math.abs(higherPitch - targetPitch)
				if diff < closestDiff and math.floor(newX) ~= 1 then
					bestX = math.floor(newX)
					bestY = newY
					if diff == 0 then break end
					closestDiff = diff
				end
				diff = math.abs(lowerPitch - targetPitch)
				if diff < closestDiff and math.ceil(newX) ~= 1 then
					bestX = math.ceil(newX)
					bestY = newY
					if diff == 0 then break end
					closestDiff = diff
				end
			end
		end
		
		if bestX ~= 0 then
			bestX = bestX + 6
		end
		if bestY ~= 0 then
			bestY = bestY + 6
		end
		
		return {
			angle = targetPitch % 65536,
			X = bestX * (Memory.Mario.GlobalTimer % 2 * 2 - 1),
			Y = bestY * -sign
		}	
	end
	
	cFacingYaw = Memory.Mario.FacingYaw
	if(Memory.Camera.Flags % 4 < 2 and Memory.Mario.PressedButtons % 16 > 7 and Memory.Mario.HeldButtons < 128 and joypad.get(1).A == true and (Memory.Mario.Animation == 127 or Memory.Mario.Animation == 128)) then
		cFacingYaw = Memory.Mario.GfxAngle
	end
	if (Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW) then
		goal = cFacingYaw
		if ((Memory.Mario.Action == 0x000008A7 or Memory.Mario.Action == 0x010208B6 or Memory.Mario.Action == 0x010208B0 or Memory.Mario.Action == 0x08100340 or Memory.Mario.Action == 0x00100343) and ENABLE_REVERSE_ANGLE_ON_WALLKICK == 1) then
			goal = (goal + 32768) % 65536
		end
	end
	if (Settings.Layout.Button.selectedItem == Settings.Layout.Button.REVERSE_ANGLE) then
		goal = (cFacingYaw + 32768) % 65536
		if ((Memory.Mario.Action == 0x000008A7 or Memory.Mario.Action == 0x010208B6 or Memory.Mario.Action == 0x010208B0 or Memory.Mario.Action == 0x08100340 or Memory.Mario.Action == 0x00100343) and ENABLE_REVERSE_ANGLE_ON_WALLKICK == 1) then
			goal = cFacingYaw
		end
	end
	    -- Set up target speed
		if (Settings.Layout.Button.strain_button.target_strain == true) then
			ENABLE_TARGET_SPEED = 1
		else
			ENABLE_TARGET_SPEED = 0
		end
		if (Settings.Layout.Button.strain_button.always == true) then
			offset = 3
		else
			offset = 0
		end
	if (ENABLE_TARGET_SPEED == 1) then
		if Memory.Mario.Action == 0x04000440 or Memory.Mario.Action == 0x0400044A or Memory.Mario.Action == 0x08000239 or Memory.Mario.Action == 0x0C000232 or Memory.Mario.Action == 0x04000442 or Memory.Mario.Action == 0x04000443 or Memory.Mario.Action == 0x010208B7 or Memory.Mario.Action == 0x04000445 or Memory.Mario.Action == 0x00840454 or Memory.Mario.Action == 0x00840452 or (Memory.Mario.Action > 0x0400046F and Memory.Mario.Action < 0x04000474) or (Memory.Mario.Action > 0x00000473 and Memory.Mario.Action < 0x00000478) then
			actionflag=1
		else
			actionflag=0
		end
		if ( Memory.Mario.FSpeed > 937/30 and Memory.Mario.FSpeed < 31.9 + offset*3000000 and (Memory.Mario.Action == 0x04808459 or Memory.Mario.Action == 0x00000479) and Memory.Mario.HeldButtons < 128 and joypad.get(1).A == true and Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW)  then
			targetspeed = 48 - Memory.Mario.FSpeed/2
			speedsign = 1
			if ( Memory.Mario.FSpeed > 32 ) then
				goal = Engine.getDyaw(13927)
			else
				goal = Engine.getDyaw(Engine.getgoal(targetspeed))
			end
		elseif ( Memory.Mario.FSpeed >= 10 and offset ~= 0 and Memory.Mario.FSpeed < 34.85 and Memory.Mario.Action == 0x04808459 and (Memory.Mario.HeldButtons > 127 or joypad.get(1).A == false) and  Memory.Mario.HeldButtons % 128 < 64 and joypad.get(1).B == true and Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW)  then
			targetspeed = 32
			speedsign = 1
			if(Memory.Mario.FSpeed > 32) then
				if (Memory.Mario.FSpeed > 33.85) then targetspeed = targetspeed + 1 end
				goal = Engine.getDyaw(Engine.getgoal(targetspeed))
			else
				goal = Engine.getDyaw(13927)
			end
		elseif ( Memory.Mario.FSpeed > -337/30 - offset/1.5 and Memory.Mario.FSpeed < -9.9 and Memory.Mario.Action == 0x00000479 and Settings.Layout.Button.selectedItem == Settings.Layout.Button.REVERSE_ANGLE) then
			targetspeed = -16 - Memory.Mario.FSpeed/2
			if ( Memory.Mario.FSpeed < -11.9 ) then targetspeed = targetspeed - 2 end
			speedsign = -1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
		elseif ( Memory.Mario.FSpeed > 46.85 and Memory.Mario.FSpeed < 47.85 + offset and  Memory.Mario.Action == 0x03000888 and Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW) then
			targetspeed = 48
			if ( Memory.Mario.FSpeed > 49.85 ) then targetspeed = targetspeed + 1 end
			speedsign = 1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
		elseif ( Memory.Mario.FSpeed > 30.85 and Memory.Mario.FSpeed < 31.85 + offset and (actionflag == 0 or (Memory.Mario.Action == 0x04000472 and Memory.Mario.HatState % 16 > 7 and Memory.Mario.HeldButtons < 128 and joypad.get(1).A == true)) and Memory.Mario.Action ~= 0x03000888 and Memory.Mario.Action ~= 0x00000479 and Memory.Mario.Action ~= 0x04808459 and Memory.Mario.Action ~= 0x00880456 and (Memory.Mario.HeldButtons % 128 > 63 or joypad.get(1).B == false) and Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW ) then
			targetspeed = 32
			if ( Memory.Mario.FSpeed > 33.85 ) then targetspeed = targetspeed + 1 end
			speedsign = 1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
			if (Memory.Mario.Action == 0x000008A7 or Memory.Mario.Action == 0x010208B6 or Memory.Mario.Action == 0x010208B0 or Memory.Mario.Action == 0x08100340 or Memory.Mario.Action == 0x00100343 and ENABLE_REVERSE_ANGLE_ON_WALLKICK == 1) then
				goal = (goal + 32768) % 65536
			end
		elseif ( Memory.Mario.FSpeed > 15.85 and Memory.Mario.FSpeed < 16.85 + offset and (((Memory.Mario.Action == 0x01000882 or Memory.Mario.Action == 0x030008AF or Memory.Mario.Action == 0x03000886 or Memory.Mario.Action == 0x03000894 or Memory.Mario.Action == 0x01000887 or Memory.Mario.Action == 0x0100088C) or (Memory.Mario.Action == 0x04000472 and Memory.Mario.HatState % 16 > 7)) and Memory.Mario.HeldButtons % 128 < 64 and joypad.get(1).B == true) and Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW ) then
			targetspeed = 32 - 15
			if ( Memory.Mario.FSpeed > 18.85 ) then targetspeed = targetspeed + 1 end
			speedsign = 1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
			if (Memory.Mario.Action == 0x000008A7 or Memory.Mario.Action == 0x010208B6 or Memory.Mario.Action == 0x010208B0 or Memory.Mario.Action == 0x08100340 or Memory.Mario.Action == 0x00100343 and ENABLE_REVERSE_ANGLE_ON_WALLKICK == 1) then
				goal = (goal + 32768) % 65536
			end
		elseif ( Memory.Mario.FSpeed > -32 and Memory.Mario.FSpeed < 32 and ((Memory.Mario.Action >= 0x0C008220 and Memory.Mario.Action < 0x0C008224) or Memory.Mario.Action == 0x0400047A or Memory.Mario.Action == 0x0800022F) and Settings.Layout.Button.selectedItem == Settings.Layout.Button.REVERSE_ANGLE ) then
			speedsign = -1
			goal = Engine.getDyaw(18840)
		elseif ( Memory.Mario.FSpeed > -16.85 - offset and Memory.Mario.FSpeed < -14.85 and Memory.Mario.Action ~= 0x00000479 and ((actionflag == 0 and (Memory.Mario.Action ~= 0x01000882 and Memory.Mario.Action ~= 0x030008AF and Memory.Mario.Action ~= 0x03000886 and Memory.Mario.Action ~= 0x03000894 and Memory.Mario.Action ~= 0x01000887 and Memory.Mario.Action ~= 0x0100088C or Memory.Mario.HeldButtons % 128 > 63 or joypad.get(1).B == false)) or (Memory.Mario.Action == 0x04000472 and Memory.Mario.HeldButtons < 128 and joypad.get(1).A == true and (Memory.Mario.HeldButtons % 128 > 63 or joypad.get(1).B == false) and Memory.Mario.HatState % 16 > 7)) and Settings.Layout.Button.selectedItem == Settings.Layout.Button.REVERSE_ANGLE ) then
			targetspeed = -16
			if ( Memory.Mario.FSpeed < -17.85 ) then targetspeed = targetspeed - 2 end
			speedsign = -1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
		elseif ( Memory.Mario.FSpeed > -31.85 - offset and Memory.Mario.FSpeed < -29.85 and Memory.Mario.Action ~= 0x00000479 and (((Memory.Mario.Action == 0x01000882 or Memory.Mario.Action == 0x030008AF or Memory.Mario.Action == 0x03000886 or Memory.Mario.Action == 0x03000894 or Memory.Mario.Action == 0x01000887 or Memory.Mario.Action == 0x0100088C) or (Memory.Mario.Action == 0x04000472 and Memory.Mario.HatState % 16 > 7)) and Memory.Mario.HeldButtons % 128 < 64 and joypad.get(1).B == true) and Settings.Layout.Button.selectedItem == Settings.Layout.Button.REVERSE_ANGLE ) then
			targetspeed = -16 - 15
			if ( Memory.Mario.FSpeed < -32.85 ) then targetspeed = targetspeed - 2 end
			speedsign = -1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
		elseif ( Memory.Mario.FSpeed > -21.0625 - offset/0.8 and Memory.Mario.FSpeed < -18.5625 and Memory.Mario.Action ~= 0x00000479 and (Memory.Mario.Action ~= 0x04000472 or Memory.Mario.HatState % 16 < 8) and (actionflag == 1 or Memory.Mario.Action == 0x04808459) and Memory.Mario.HeldButtons < 128 and joypad.get(1).A == true  and Settings.Layout.Button.selectedItem == Settings.Layout.Button.REVERSE_ANGLE ) then
			targetspeed = -16 + Memory.Mario.FSpeed/5
			if ( Memory.Mario.FSpeed < -22.3125 ) then targetspeed = targetspeed - 2 end
			speedsign = -1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
		elseif ( Memory.Mario.FSpeed > 38.5625 and Memory.Mario.FSpeed < 39.8125 + offset/0.8 and Memory.Mario.Action ~= 0x00000479 and Memory.Mario.Action ~= 0x03000888 and (Memory.Mario.Action ~= 0x04000472 or Memory.Mario.HatState % 16 < 8) and actionflag == 1 and Memory.Mario.HeldButtons < 128 and joypad.get(1).A == true and (Memory.Mario.HeldButtons % 128 > 63 or joypad.get(1).B == false) and Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW) then
			targetspeed = 32 + Memory.Mario.FSpeed/5
			if ( Memory.Mario.FSpeed > 42.3125 ) then targetspeed = targetspeed + 1 end
			speedsign = 1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
		elseif ( Memory.Mario.FSpeed > 20 and Memory.Mario.FSpeed < 21.0625 + offset/0.8 and Memory.Mario.Action == 0x04000472 and Memory.Mario.HatState % 16 < 8 and Memory.Mario.HeldButtons < 128 and joypad.get(1).A == true and Memory.Mario.HeldButtons % 128 < 64 and joypad.get(1).B == true and Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW ) then
			targetspeed = 32 - 15 + Memory.Mario.FSpeed/5
			if ( Memory.Mario.FSpeed > 23.5625) then targetspeed = targetspeed + 1 end
			speedsign = 1
			goal = Engine.getDyaw(Engine.getgoal(targetspeed))
		else
			speedsign = 0
		end
		goal = goal + 32 * speedsign * Engine.getDyawsign()
	end
	if (Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_ANGLE and Settings.Layout.Button.strain_button.dyaw == true) then
		goal = Engine.getDyaw(goal)
		if (Memory.Mario.Action == 0x000008A7 or Memory.Mario.Action == 0x010208B6 or Memory.Mario.Action == 0x010208B0 or Memory.Mario.Action == 0x08100340 or Memory.Mario.Action == 0x00100343 and ENABLE_REVERSE_ANGLE_ON_WALLKICK == 1) then
			goal = (goal + 32768) % 65536
		end
	end
	--if (Settings.Layout.Button.strain_button.arctan == true and Settings.Layout.Button.strain_button.arctanstart < Memory.Mario.GlobalTimer and Settings.Layout.Button.strain_button.arctanstart > Memory.Mario.GlobalTimer - Settings.Layout.Button.strain_button.arctann - 1) then
	if (Settings.Layout.Button.strain_button.arctan == true) then
		goal = goal % 65536
		goal = Engine.getArctanAngle(Settings.Layout.Button.strain_button.arctanr, Settings.Layout.Button.strain_button.arctand, Settings.Layout.Button.strain_button.arctann, Settings.Layout.Button.strain_button.arctanstart)
	end
	-- if(Settings.Layout.Button.selectedItem ~= Settings.Layout.Button.MATCH_ANGLE or Settings.Layout.Button.strain_button.dyaw == true or Settings.Layout.Button.strain_button.arctan == true) then
		-- goal = goal + Memory.Mario.FacingYaw % 16
	-- end
	goal = goal - 65536
	while (Memory.Camera.Angle > goal) do
		goal = goal + 65536
	end
	-- Set up binary search
	minang = 1
	maxang = Angles.COUNT
	midang = math.floor((minang + maxang) / 2)
	-- Binary search
	while (minang <= maxang) do
		if (Engine.getEffectiveAngle(Angles.ANGLE[midang].angle + Memory.Camera.Angle - cFacingYaw) + cFacingYaw < goal) then
			minang = midang + 1
		elseif (Engine.getEffectiveAngle(Angles.ANGLE[midang].angle + Memory.Camera.Angle - cFacingYaw) + cFacingYaw == goal) then
			minang = midang
			maxang = midang - 1
		else
			maxang = midang - 1
		end
		midang = math.floor((minang + maxang) / 2)
	end
	-- If binary search fails, optimal angle is between Angles.Count and 1. Checks which one is closer.
	if minang > Angles.COUNT then
		minang = 1
		if math.abs(Engine.getEffectiveAngle(Angles.ANGLE[1].angle + Memory.Camera.Angle - cFacingYaw) + cFacingYaw - (goal - 65536)) > math.abs(Engine.getEffectiveAngle(Angles.ANGLE[Angles.COUNT].angle + Memory.Camera.Angle - cFacingYaw) + cFacingYaw - goal) then
			minang = Angles.COUNT
		end
	end
	--[[local errt = -1
	local maxspeed = 32
	local mspeed = Memory.Mario.FSpeed
	local speeds = 1
	local angleindex = minang
	if(Memory.Mario.FSpeed <= 0) then
		speeds = -1
	end
	if(Memory.Mario.Action == 0x03000888) then
		maxspeed = maxspeed + 16
	end
	if(TARGET_STATE == 1) then
		mspeed = 48
		maxspeed = 48
	elseif(TARGET_STATE == 2) then
		mspeed = mspeed * 1.5
		maxspeed = 48
	elseif(TARGET_STATE == 3) then
		mspeed = -16
		maxspeed = 48
	elseif(TARGET_STATE == 4) then
		mspeed = mspeed * 0.8
	end
	if(ENABLE_TARGET_SPEED == 1 and speedsign ~= 0) then
		for i = -16,16 do
			local this_errt = math.cos(Engine.getEffectiveAngle(Angles.ANGLE[(minang+i)%Angles.COUNT].angle - Memory.Mario.FacingYaw + Memory.Camera.Angle)*math.pi/32768)*1.5+mspeed-0.35*speeds
			if(this_errt > maxspeed - 0.0001) then
				this_errt = this_errt - 1
			elseif(this_errt < -16) then
				this_errt = this_errt + 2
			end
			this_errt = this_errt * speedsign
			if(this_errt > errt) then
				errt = this_errt
				angleindex = (minang+i)%Angles.COUNT
			end
		end
		print(errt)
		minang = angleindex
	end--]]
	--[[if ((math.cos((Engine.getEffectiveAngle(Angles.ANGLE[minang].angle - Memory.Mario.FacingYaw))*math.pi/32768)*1.5 + Memory.Mario.FSpeed - 0.35) > targetspeed and speedsign == 1) then
		minang = minang + 1
	elseif ((math.cos((Engine.getEffectiveAngle(Angles.ANGLE[minang].angle - Memory.Mario.FacingYaw))*math.pi/32768)*1.5 + Memory.Mario.FSpeed + 0.35) < -16 and speedsign == -1 ) then
			minang = minang - 1
	end--]]
	--[[if (Angles.ANGLE[minang].angle + Memory.Camera.Angle) % 65536 < goal and speedsign == 1 then
		minang = minang + 1
		if minang > Angles.COUNT then
			minang = 1
		end
	elseif (Angles.ANGLE[minang].angle + Memory.Camera.Angle) % 65536 > goal and  speedsign == -1 then
		minang = minang - 1
		if minang < 1 then
			minang = Angles.COUNT 
		end
	end--]]
	return {
		angle = (Angles.ANGLE[minang].angle + Memory.Camera.Angle) % 65536,
		X = Angles.ANGLE[minang].X,
		Y = Angles.ANGLE[minang].Y
	}	
end

function Engine.GetQFs(Mariospeed)
	-- print(math.sqrt(math.abs(math.abs(MoreMaths.hexToFloat(string.format("%x", Memory.PreviousPos.X))) - math.abs(MoreMaths.hexToFloat(string.format("%x", Memory.Mario.X)))) ^ 2 + math.abs(math.abs(MoreMaths.hexToFloat(string.format("%x", Memory.PreviousPos.Z))) - math.abs(MoreMaths.hexToFloat(string.format("%x", Memory.Mario.Z)))) ^ 2))
	-- return math.floor(4 * (math.sqrt(math.abs(math.abs(MoreMaths.hexToFloat(string.format("%x", Memory.PreviousPos.X))) - math.abs(MoreMaths.hexToFloat(string.format("%x", Memory.Mario.X)))) ^ 2 + math.abs(math.abs(MoreMaths.hexToFloat(string.format("%x", Memory.PreviousPos.Z))) - math.abs(MoreMaths.hexToFloat(string.format("%x", Memory.Mario.Z)))) ^ 2)) / math.abs(Mariospeed))
end

function Engine.GetSpeedEfficiency()
	if Memory.Mario.XSlideSpeed + Memory.Mario.ZSlideSpeed > 0 then
		return MoreMaths.Round(Engine.GetDistMoved() / math.abs(math.sqrt(MoreMaths.DecodeDecToFloat(Memory.Mario.XSlideSpeed) ^ 2 + MoreMaths.DecodeDecToFloat(Memory.Mario.ZSlideSpeed) ^ 2)) * 100, 5)
	else
		return 0
	end
end

function Engine.GetDistMoved()
	return math.sqrt((MoreMaths.DecodeDecToFloat(Memory.PreviousPos.X) - MoreMaths.DecodeDecToFloat(Memory.Mario.X)) ^ 2 + (MoreMaths.DecodeDecToFloat(Memory.PreviousPos.Z) - MoreMaths.DecodeDecToFloat(Memory.Mario.Z)) ^ 2)
end

function Engine.GetCurrentAction()
	for i = 1, Actions.COUNT, 1
	do
		if Actions.ACTION[i].value == Memory.Mario.Action then
			return Actions.ACTION[i].name
		end
	end
	return "INVALID ACTION"
end

function Engine.GetTotalDistMoved()
	eckswhy = (Settings.Layout.Button.dist_button.axis.x - MoreMaths.DecodeDecToFloat(Memory.Mario.X)) ^ 2 + (Settings.Layout.Button.dist_button.axis.z - MoreMaths.DecodeDecToFloat(Memory.Mario.Z)) ^ 2
	if (Settings.Layout.Button.dist_button.ignore_y == false) then
		eckswhy = eckswhy + (Settings.Layout.Button.dist_button.axis.y - MoreMaths.DecodeDecToFloat(Memory.Mario.Y)) ^ 2
	end
	return math.sqrt(eckswhy)
end

function Engine.GetHSlidingSpeed()
	return math.sqrt(MoreMaths.DecodeDecToFloat(Memory.Mario.XSlideSpeed) ^ 2 + MoreMaths.DecodeDecToFloat(Memory.Mario.ZSlideSpeed) ^ 2)
end

local function magnitude(x, y)
	return math.sqrt(math.max(0, math.abs(x)-6)^2 + math.max(0, math.abs(y)-6)^2)
end
local function clamp(min, n, max)
	if n < min then return min end
	if n > max then return max end
	return n
end
local function effectiveAngle(x,y)
	if math.abs(x) < 8 then
		x = 0
	elseif x > 0 then
		x = x - 6
	else
		x = x + 6
	end
	if math.abs(y) < 8 then
		y = 0
	elseif y > 0 then
		y = y - 6
	else
		y = y + 6
	end
	return math.atan2(-y, x)
end

function Engine.scaleInputsForMagnitude(result, goal_mag, use_high_mag)
	if goal_mag >= 127 then return end

	local start_x, start_y = result.X, result.Y
	local current_mag = magnitude(start_x, start_y)
	local ideal_x, ideal_y = start_x * goal_mag/current_mag, start_y * goal_mag/current_mag
	--print(magnitude(ideal_x, ideal_y))
	--print(goal_mag)
	
	--local x0, y0 = math.floor(ideal_x), math.floor(ideal_y)
	--local x0, y0 = 0, 0
	
	local x0, y0 = 0, 0
	if start_x == 0 then
		y0 = goal_mag + 6
	elseif start_y == 0 then
		x0 = goal_mag + 6
	else
		-- https://www.wolframalpha.com/input/?i=solve+%7Bsqrt%28%28x0-6%29%C2%B2+%2B+%28y0-6%29%5E2%29+%3D+k%3B+atan2%28y%2Cx%29+%3D+atan2%28y0%2Cx0%29+%7D+for+x0+and+y0
		local k = goal_mag
		local x,y = math.abs(start_x), math.abs(start_y)
		local x2,y2 = x*x, y*y
		local crazy = math.sqrt((4*(k^2 - 72)*y2)/(x2 + y2) + (y2*(-12*x - 12*y)^2)/(x2 + y2)^2)
		--print(crazy)
		x0 = math.floor(math.abs(x*crazy/(2*y) + (6*x2)/(x2 + y2) + (6*x*y)/(x2 + y2)))
		y0 = math.floor(math.abs(0.5*crazy + (6*y2)/(x2 + y2) + (6*x*y)/(x2 + y2)))
	end
	if start_x < 0 then
		x0 = -x0
	end
	if start_y < 0 then
		y0 = -y0
	end
	if x0 ~= x0 then x0 = 0 end -- NaN?
	if y0 ~= y0 then y0 = 0 end

	-- search neighbourhood for input with greatest component in goal direction
	local closest_x, closest_y = x0, y0
	local err = -1
	local goal_angle = effectiveAngle(start_x,start_y)
	for i = -32,32 do
		for j = -32,32 do
			local x, y = clamp(-127, x0+i, 127), clamp(-127, y0+j, 127)
			--print(string.format("%d,%d", x, y))
			local mag = magnitude(x, y)
			if (mag <= goal_mag) and (mag*mag >= err) then
				local angle = effectiveAngle(x,y)
				--print(string.format("%d:%d: %f (%f)", x,y,angle,goal_angle))
				--local this_err = math.cos(angle - goal_angle)*mag
				local this_err = math.cos(angle - goal_angle)
				if(use_high_mag == true) then this_err = this_err*mag*mag end
				--print(string.format("%d,%d: %f, %d; %f, %f; %f, %s", x, y, mag, goal_mag, angle, goal_angle, this_err, tostring(err)))
				if this_err > err then
					err = this_err
					closest_x, closest_y = x, y
				end
			end
		end
	end

	closest_x = clamp(-127, closest_x, 127)
	closest_y = clamp(-127, closest_y, 127)
	if math.abs(closest_x) < 8 then closest_x = 0 end
	if math.abs(closest_y) < 8 then closest_y = 0 end

	result.X, result.Y = closest_x, closest_y 
end
