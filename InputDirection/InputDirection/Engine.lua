Engine = {

}

function Engine.getEffectiveAngle(angle)
	return angle - (angle % 16)
end

function Engine.inputsForAngle()
	goal = Engine.getEffectiveAngle(Settings.goalAngle)
	if (Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW) then
		goal = Engine.getEffectiveAngle(Memory.Mario.FacingYaw)
	end
	goal = goal - 65536
	while (Engine.getEffectiveAngle(Memory.Camera.Angle) > goal) do
		goal = goal + 65536
	end
	-- Set up binary search
	minang = 1
	maxang = Angles.COUNT
	midang = math.floor((minang + maxang) / 2)
	-- Binary search
	while (minang <= maxang) do
		if (Engine.getEffectiveAngle(Angles.ANGLE[midang].angle + Memory.Camera.Angle) < goal) then
			minang = midang + 1
		elseif (Engine.getEffectiveAngle(Angles.ANGLE[midang].angle + Memory.Camera.Angle) == goal) then
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
		if math.abs(Engine.getEffectiveAngle(Angles.ANGLE[1].angle + Memory.Camera.Angle) - (goal - 65536)) > math.abs(Engine.getEffectiveAngle(Angles.ANGLE[Angles.COUNT].angle + Memory.Camera.Angle) - goal) then
			minang = Angles.COUNT
		end
	end
	return {
		angle = (Angles.ANGLE[minang].angle + Memory.Camera.Angle) % 65536,
		X = Angles.ANGLE[minang].X,
		Y = Angles.ANGLE[minang].Y
	}	
end