Settings = {
	goalAngle = 0,
	goalMag = 127,
	ShowEffectiveAngles = false
}

Settings.Themes = {
	Light = {
		Text = "#000000",
		Background = "#CCCCFF",
		Button = {
			--Text = "#000000", -- optional, defaults to Theme.Text
			InvertedText = "#FFFFFF",
			Outline = "#888888",
			-- making the bottom portion of the button slightly darker
			-- makes it subtly look like a button
			Top = "#F2F2F2",
			Bottom = "#E8E8E8",
			Pressed = {
				Top = "#FF0000",
				Bottom = "#EE0000"
			}
		},
		Joystick = {
			Circle = "#FFFFFF",
			Background = "#DDDDDD", -- shade outside circle
			MagBoundary = "#DDDDFF",
			Crosshair = "#000000",
			Stick = "#0000FF",
			Dot = "#FF0000", -- end of the joystick
		},
		InputField = { -- where you enter the facing angle or mag
			--EditingText = "#000000", -- optional, defaults to Theme.Text
			Editing = "#FFFF00",
			Enabled = "#FFFFFF",
			Disabled = "#AAAAAA",
			OutsideOutline = "#000000", -- outermost
			Outline = "#888888" -- inner (creates depth)
		}
	},
	Dark = {
		Text = "#FFFFFF",
		Background = "#222222",
		Button = {
			Text = "#000000",
			InvertedText = "#FFFFFF",
			Outline = "#888888",
			Top = "#F2F2F2",
			Bottom = "#EDEDED",
			Pressed = {
				Top = "#FF0000",
				Bottom = "#EE0000"
			}
		},
		Joystick = {
			Circle = "#444444",
			Background = "#222222",
			MagBoundary = "#666666",
			Crosshair = "#FFFFFF",
			Stick = "#00FF08",
			Dot = "#FF0000",
		},
		InputField = {
			EditingText = "#000000",
			Editing = "#FFDD00",
			Enabled = "#666666",
			Disabled = "#444444",
			OutsideOutline = "#000000",
			Outline = "#888888"
		}
	}
}

Settings.Theme = Settings.Themes.Light -- default

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
		blinkTimer = 0,
		blinkRate = 25, -- lower number = blink faster
		showUnderscore = true,

		MATCH_ANGLE = 1,
		MAGNITUDE = 2
	}
}
