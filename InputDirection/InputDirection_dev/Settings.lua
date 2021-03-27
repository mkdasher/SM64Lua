Settings = {
	goalAngle = 0,
	ShowEffectiveAngles = false
}

Settings.Layout = {
	Button = {
		items = { -- spaces are used to adjust text placement
			'Disabled  ',
			'Match Yaw  ',
			'Match Angle ',
			'Reverse Angle',
			'    Speedkick',
			'Reset Mag ',
			'Swim   ',
			'ignore Y',
			'.99',
			'Always ',
			'Left',
			'Right',
			'Dyaw   ',
			'  get dist moved'
		},
		selectedItem = 1,

		DISABLED = 1,
		MATCH_YAW = 2,
		MATCH_ANGLE = 3,
		REVERSE_ANGLE = 4,
		MAG48 = 5,
		RESET_MAG = 6,
		SWIM = 7,
		IGNORE_Y = 8,
		POINT_99 = 9,
		ALWAYS_99 = 10,
		LEFT_99 = 11,
		RIGHT_99 = 12,
		DYAW = 13,
		DIST_MOVED = 14,

		dist_button = {
			enabled = false,
			dist_moved_save = 0,
			ignore_y = false,
			axis = {
				x = 0,
				y = 0,
				z = 0
			}
		},
		strain_button = {
			always = false,
			target_strain = true,
			left = true,
			right = false,
			dyaw = false
		},
		swimming = false
	},
	TextArea = {
		items = {'Match Angle', 'Magnitude'},
		selectedItem = 0,
		selectedChar = 1,

		MATCH_ANGLE = 1,
		MAGNITUDE = 2
	}
}
