ButtonType = {
	button = 0,
		-- text : button text
		-- box : total size of the button
	textArea = 1
}

Buttons = {
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.IGNORE_Y],
		box = {
			Drawing.Screen.Width + 130,
			490,
			75,
			20
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.dist_button.ignore_y == true
		end,
		onclick = function(self)
			if (Settings.Layout.Button.dist_button.ignore_y == true) then
				Settings.Layout.Button.dist_button.ignore_y = false
			else
				Settings.Layout.Button.dist_button.ignore_y = true
			end
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.POINT_99],
		box = {
			Drawing.Screen.Width + 185,
			5,
			32,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.strain_button.target_strain == true
		end,
		onclick = function(self)
			if (Settings.Layout.Button.strain_button.target_strain == true) then
				Settings.Layout.Button.strain_button.target_strain = false
				Settings.Layout.Button.strain_button.always = false
			else
				Settings.Layout.Button.strain_button.target_strain = true
			end
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.ALWAYS_99],
		box = {
			Drawing.Screen.Width + 129,
			5,
			56,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.strain_button.always == true
		end,
		onclick = function(self)
			if (Settings.Layout.Button.strain_button.always == true) then
				Settings.Layout.Button.strain_button.always = false
			elseif (Settings.Layout.Button.strain_button.target_strain == true) then
				Settings.Layout.Button.strain_button.always = true
			end
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.LEFT_99],
		box = {
			Drawing.Screen.Width + 130,
			31,
			40,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.strain_button.left == true
		end,
		onclick = function(self)
			if (Settings.Layout.Button.strain_button.left == true and Settings.Layout.Button.strain_button.right == true) then
				Settings.Layout.Button.strain_button.left = false
			else
				Settings.Layout.Button.strain_button.left = true
			end
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.RIGHT_99],
		box = {
			Drawing.Screen.Width + 170,
			31,
			47,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.strain_button.right == true
		end,
		onclick = function(self)
			if (Settings.Layout.Button.strain_button.right == true and Settings.Layout.Button.strain_button.left == true) then
				Settings.Layout.Button.strain_button.right = false
			else
				Settings.Layout.Button.strain_button.right = true
			end
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.DYAW],
		box = {
			Drawing.Screen.Width + 130,
			57,
			87,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.strain_button.dyaw == true
		end,
		onclick = function(self)
			if (Settings.Layout.Button.strain_button.dyaw == true) then
				Settings.Layout.Button.strain_button.dyaw = false
			else
				Settings.Layout.Button.strain_button.dyaw = true
			end
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.DIST_MOVED],
		box = {
			Drawing.Screen.Width + 5,
			490,
			120,
			20
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.dist_button.enabled == true
		end,
		onclick = function(self)
			if (Settings.Layout.Button.dist_button.enabled == false) then
				Settings.Layout.Button.dist_button.enabled = true
				Settings.Layout.Button.dist_button.axis.x = MoreMaths.DecodeDecToFloat(Memory.Mario.X)
				Settings.Layout.Button.dist_button.axis.y = MoreMaths.DecodeDecToFloat(Memory.Mario.Y)
				Settings.Layout.Button.dist_button.axis.z = MoreMaths.DecodeDecToFloat(Memory.Mario.Z)
			else
				Settings.Layout.Button.dist_button.enabled = false
				Settings.Layout.Button.dist_button.dist_moved_save = Engine.GetTotalDistMoved()
			end
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.DISABLED],
		box = {
			Drawing.Screen.Width + 5,
			5,
			120,
			30
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.selectedItem == Settings.Layout.Button.DISABLED
		end,
		onclick = function(self)
			Settings.Layout.Button.selectedItem = Settings.Layout.Button.DISABLED
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.MATCH_YAW],
		box = {
			Drawing.Screen.Width + 5,
			40,
			120,
			30
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_YAW
		end,
		onclick = function(self)
			Settings.Layout.Button.selectedItem = Settings.Layout.Button.MATCH_YAW
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.REVERSE_ANGLE],
		box = {
			Drawing.Screen.Width + 5,
			75,
			120,
			30
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.selectedItem == Settings.Layout.Button.REVERSE_ANGLE
		end,
		onclick = function(self)
			Settings.Layout.Button.selectedItem = Settings.Layout.Button.REVERSE_ANGLE
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.MATCH_ANGLE],
		box = {
			Drawing.Screen.Width + 5,
			110,
			120,
			30
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_ANGLE
		end,
		onclick = function(self)
			Settings.Layout.Button.selectedItem = Settings.Layout.Button.MATCH_ANGLE
		end
	},
	{
		type = ButtonType.textArea,
		inputSize = 5,
		box = {
			Drawing.Screen.Width + 131,
			110,
			85,
			30
		},
		value = function()
			return Settings.goalAngle
		end,
		enabled = function()
			return Settings.Layout.Button.selectedItem == Settings.Layout.Button.MATCH_ANGLE
		end,
		editing = function()
			return Settings.Layout.TextArea.selectedItem == Settings.Layout.TextArea.MATCH_ANGLE
		end,
		onclick = function(self)
			Settings.Layout.TextArea.selectedItem = Settings.Layout.TextArea.MATCH_ANGLE
			Settings.Layout.TextArea.selectedChar = 1
		end,
		onkeypress = function(self, key)
			local oldkey = math.floor(Settings.goalAngle / math.pow(10, self.inputSize - Settings.Layout.TextArea.selectedChar)) % 10
			Settings.goalAngle = Settings.goalAngle + (key - oldkey) * math.pow(10, self.inputSize - Settings.Layout.TextArea.selectedChar)
			Settings.Layout.TextArea.selectedChar = Settings.Layout.TextArea.selectedChar + 1
			if Settings.Layout.TextArea.selectedChar > self.inputSize then
				Settings.Layout.TextArea.selectedItem = 0
			end
		end,
	},
	{
		type = ButtonType.textArea,
		inputSize = 3,
		box = {
			Drawing.Screen.Width + 154,
			165,
			50,
			25
		},
		value = function()
			return Settings.goalMag
		end,
		enabled = function()
			return true
		end,
		editing = function()
			return Settings.Layout.TextArea.selectedItem == Settings.Layout.TextArea.MAGNITUDE
		end,
		onclick = function(self)
			Settings.Layout.TextArea.selectedItem = Settings.Layout.TextArea.MAGNITUDE
			Settings.Layout.TextArea.selectedChar = 1
		end,
		onkeypress = function(self, key)
			local goalMag = Settings.goalMag or 0
			local oldkey = math.floor(goalMag / math.pow(10, self.inputSize - Settings.Layout.TextArea.selectedChar)) % 10
			goalMag = goalMag + (key - oldkey) * math.pow(10, self.inputSize - Settings.Layout.TextArea.selectedChar)
			Settings.Layout.TextArea.selectedChar = Settings.Layout.TextArea.selectedChar + 1
			if Settings.Layout.TextArea.selectedChar > self.inputSize then
				Settings.Layout.TextArea.selectedItem = 0
				if goalMag >= 127 then
					goalMag = nil
				end
			end
			Settings.goalMag = goalMag
		end
  },
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.MAG48],
		box = {
			Drawing.Screen.Width + 142,
			235,
			75,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return false
		end,
		onclick = function(self)
			Settings.goalMag = 48
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.RESET_MAG],
		box = {
			Drawing.Screen.Width + 142,
			261,
			75,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return false
		end,
		onclick = function(self)
			Settings.goalMag = nil
		end
	},
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.SWIM],
		box = {
			Drawing.Screen.Width + 130,
			83,
			87,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Settings.Layout.Button.swimming == true
		end,
		onclick = function(self)
			if (Settings.Layout.Button.swimming == true) then
				Settings.Layout.Button.swimming = false
			else
				Settings.Layout.Button.swimming = true
			end
		end
	}
}
