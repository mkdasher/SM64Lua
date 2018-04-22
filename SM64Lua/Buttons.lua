ButtonType = {
	button = 0,
		-- text : button text
		-- box : total size of the button
	textArea = 1
}

Buttons = {
	{
		type = ButtonType.button,
		text = Settings.Layout.Button.items[Settings.Layout.Button.DISABLED],
		box = {
			Drawing.Screen.Width + 15,
			50,
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
			90,
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
		text = Settings.Layout.Button.items[Settings.Layout.Button.MATCH_ANGLE],
		box = {
			Drawing.Screen.Width + 15,
			130,
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
			Drawing.Screen.Width + 145,
			132,
			80,
			25
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
			oldkey = math.floor(Settings.goalAngle / math.pow(10, self.inputSize - Settings.Layout.TextArea.selectedChar)) % 10
			Settings.goalAngle = Settings.goalAngle + (key - oldkey) * math.pow(10, self.inputSize - Settings.Layout.TextArea.selectedChar)
			Settings.Layout.TextArea.selectedChar = Settings.Layout.TextArea.selectedChar + 1
			if Settings.Layout.TextArea.selectedChar > self.inputSize then
				Settings.Layout.TextArea.selectedItem = 0
			end
		end,
	}
}