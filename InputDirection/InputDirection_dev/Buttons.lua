ButtonType = {
	button = 0,
		-- text : button text
		-- box : total size of the button
	textArea = 1
}

Buttons = {
	--[[{
		type = ButtonType.button,
		text = "ignore Y",
		box = {
			Drawing.Screen.Width + 140,
			460,
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
		text = ".99",
		box = {
			Drawing.Screen.Width + 195,
			10,
			35,
			20
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
		text = "Always",
		box = {
			Drawing.Screen.Width + 136,
			10,
			59,
			20
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
		text = "Left",
		box = {
			Drawing.Screen.Width + 140,
			45,
			40,
			20
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
		text = "Right",
		box = {
			Drawing.Screen.Width + 180,
			45,
			50,
			20
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
		text = "DYaw",
		box = {
			Drawing.Screen.Width + 145,
			80,
			75,
			20
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
		text = "  get dist moved",
		box = {
			Drawing.Screen.Width + 15,
			460,
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
			Drawing.Screen.Width + 15,
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
			Drawing.Screen.Width + 15,
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
			Drawing.Screen.Width + 15,
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
			Drawing.Screen.Width + 15,
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
	},]]
	{
		type = ButtonType.textArea,
		inputSize = 5,
		box = {Drawing.Screen.Width+100,100,0,0},
		--[[	Drawing.Screen.Width + 145,
			112,
			80,
			25
		},]]
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
			oldkey = math.floor(Settings.goalAngle / math.pow(10, self.inputSize - Settings.Layout.TextArea.selectedChar)) % 10
			Settings.goalAngle = Settings.goalAngle + (key - oldkey) * math.pow(10, self.inputSize - Settings.Layout.TextArea.selectedChar)
			Settings.Layout.TextArea.selectedChar = Settings.Layout.TextArea.selectedChar + 1
			if Settings.Layout.TextArea.selectedChar > self.inputSize then
				Settings.Layout.TextArea.selectedItem = 0
			end
		end,
	}
}
