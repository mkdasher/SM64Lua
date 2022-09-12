Settings = {
	goalAngle = 0,
	goalMag = 127,
	ShowEffectiveAngles = false
}

--[[
{} means the hotkey is disabled.
To bind to key combinations list them. Ex: {"control", "M"}
Numbers will always edit value fields, and arrow keys
arrow keys will always change selected digits in value fields.
For a list of valid keys (case-sensitive) see:
  https://docs.google.com/document/d/1SWd-oAFBKsGmwUs0qGiOrk3zfX9wYHhi3x5aKPQS_o0/edit#bookmark=id.jcojkq7g066s
]]--
Settings.Hotkeys = {
	["dist moved"] = {},
	["ignore y"] = {},

	[".99"] = {},
	["always .99"] = {},
	[".99 left"] = {},
	[".99 right"] = {},

	["disabled"] = {},
	["match yaw"] = {},
	["reverse angle"] = {},

	["match angle"] = {},
	["match angle value"] = {},
	["dyaw"] = {},
	
	["arcotan strain"] = {},
	["reverse arcotan strain"] = {},
	
	["increment arcotan ratio"] = {},
	["decrement arcotan ratio"] = {},
	
	["increment arcotan displacement"] = {},
	["decrement arcotan displacement"] = {},
	
	["increment arcotan length"] = {},
	["decrement arcotan length"] = {},
	
	["increment arcotan start frame"] = {},
	["decrement arcotan start frame"] = {},
	
	["increment arcotan step"] = {},
	["decrement arcotan step"] = {},

	["magnitude value"] = {},
	["speedkick magnitude"] = {},
	["reset magnitude"] = {},
	["high magnitude"] = {},

	["swim"] = {}
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
	Dark = { -- Theme by ShadoXFM
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
	},
	IcyBlue = { -- Theme by Manama
		Text = "#000000",
		Background = "#757a9c",
		Button = {
			InvertedText = "#FFFFFF",
			Outline = "#000000",
			Top = "#b4bae0",
			Bottom = "#959cc2",
			Pressed = {
				Top = "#6984FF",
				Bottom = "#576ED9"
			}
		},
		Joystick = {
			Circle = "#888EB5",
			Background = "#6B6F8C",
			MagBoundary = "#DDDDFF",
			Crosshair = "#0fffff",
			Stick = "#FFFFFF",
			Dot = "#FFFFFF",
		},
		InputField = {
			Editing = "#BDC5FF",
			Enabled = "#FFFFFF",
			Disabled = "#FFFFFF",
			OutsideOutline = "#000000",
			Outline = "#888888"
		}
	},
	CustomDark = { -- Theme by tjk
		Text = "#FFFFFF",
		ReadWriteText = "#05DDE2",
		Background = "#222222",
		Button = {
			Text = "#000000",
			InvertedText = "#FFFFFF",
			Outline = "#888888",
			Top = "#F2F2F2",
			Bottom = "#EDEDED",
			Pressed = {
				Top = "#05DDE2",
				Bottom = "#00D4D8"
			}
		},
		Joystick = {
			Circle = "#444444",
			Background = "#222222",
			MagBoundary = "#666666",
			Crosshair = "#FFFFFF",
			Stick = "#dedcdc",
			Dot = "#05DDE2",
		},
		InputField = {
			EditingText = "#000000",
			Editing = "#FFDD00",
			Enabled = "#666666",
			Disabled = "#444444",
			OutsideOutline = "#000000",
			Outline = "#888888"
		}
	},
	MidnightPurple = { -- Theme by tjk
		Text = "#FFFFFF",
		ReadWriteText = "#ed02e9", -- should be a bit brighter than Button.Pressed.Top
		Background = "#361e35",
		Button = {
			Text = "#000000",
			InvertedText = "#FFFFFF",
			Outline = "#888888",
			Top = "#a892a8",
			Bottom = "#9c869b",
			Pressed = {
				Top = "#a803a6",
				Bottom = "#9e009b"
			}
		},
		Joystick = {
			Circle = "#444444",
			Background = "#222222",
			MagBoundary = "#666666",
			Crosshair = "#FFFFFF",
			Stick = "#c2a43a",
			Dot = "#ebe8eb",
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
			'Swim ',
			'ignore Y',
			'.99',
			'Always ',
			'Left',
			'Right',
			'Dyaw ',
			'  get dist moved',
			'AtanStrain',
			'+',
			'-',
			'+',
			'-',
			'+',
			'-',
			'+',
			'-',
			'+',
			'-',
			'I',
			'High Mag '
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
		ARCTANSTRAIN = 15,
		INCARCR = 16,
		DECARCR = 17,
		INCARCD = 18,
		DECARCD = 19,
		INCARCN = 20,
		DECARCN = 21,
		INCARCS = 22,
		DECARCS = 23,
		INCARCE = 24,
		DECARCE = 25,
		REVERSE_ARCTAN = 26,
		HIGH_MAG = 27,

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
			dyaw = false,
			arctan = false,
			controls = false,
			reverse_arc = false,
			arctanstart = 0,
			arctanr = 1.0,
			arctand = 0.0,
			arctann = 10,
			arctanexp = 0,
			highmag = false
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
