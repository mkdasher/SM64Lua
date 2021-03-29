# SM64 Input Direction Lua

The all-in-one lua script that lets you precisely control your inputs - regardless of camera angles! Simply download these files and [mupen64-rr-lua](https://github.com/mkdasher/mupen64-rr-lua-/releases), then run `InputDirection_dev.lua` to get started.

![MatchYawDemo](https://cdn.discordapp.com/attachments/196442189604192256/825890165691121704/MatchYawDemo.gif)

- Match Yaw
  - holds the joystick input that most closely corresponds to Mario's facing angle
- Reverse Angle
  - same as `Match Yaw` but for the opposite direction
- Match Angle
  - holds the joystick in the direction of the specified angle
- .99
  - hold a joystick angle that makes Mario's speed go to 31.99 or 47.99 speed for 1 frame (when possible)
- Always
  - constantly `.99` strain
- Dyaw
  - makes `Match Yaw` hold an offset from Mario's facing angle
- Left/Right
  - determines the direction of the `.99` strain and `Dyaw`
- Swim
  - repeatedly presses A or B to swim optimally
  - to change which button is pressed, replace the string inside the main script
- Magnitude Control
  - set a maximum magnitude to input
  - `Speedkick` is a shortcut for a magnitude of 48
  - `Reset Mag` removes the the cap
- Get Dist Moved
  - once enabled, saves Mario's position and displays the distance from that point
  - `Ignore Y` ignores the vertical distance

As an example: if Mario is facing angle 54600 and `Match Angle` set to 2000, with `Dyaw` and `Right` selected, it will hold the input coresponding to angle 52600.

You can add your own colour schemes, or adjust the existing ones in `Settings.lua`. To switch to dark mode, put `Settings.Theme = Settings.Themes.Dark` inside the main script.

![DarkTheme](https://cdn.discordapp.com/attachments/196442189604192256/825851592141307955/InputLuaDarkTheme.png)

