local apps = require("apps")
local mod = "SUPER" -- Sets "Windows" key as main modifier

--------------------
---- FULLSCREEN ----
--------------------

hl.bind(mod .. " + F", hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "toggle" }))
hl.bind(mod .. " + grave", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

--------------------
---- SCREENSHOT ----
--------------------

hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot/screenshot.sh full"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot/screenshot.sh area"))

--------------
---- LOCK ----
--------------

hl.bind(mod .. " + L", hl.dsp.exec_cmd("hyprlock"))

--------------
---- ZOOM ----
--------------

-- Storing complex bash commands in local variables for cleaner bindings
local zoom_in_cmd =
	"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
local zoom_out_cmd =
	"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
local zoom_reset_cmd = "hyprctl -q keyword cursor:zoom_factor 1"

-- Mouse Scroll Zoom
hl.bind(mod .. " + mouse_down", hl.dsp.exec_cmd(zoom_in_cmd))
hl.bind(mod .. " + mouse_up", hl.dsp.exec_cmd(zoom_out_cmd))

-- Keyboard Zoom (repeating = true replaces 'binde')
hl.bind(mod .. " + equal", hl.dsp.exec_cmd(zoom_in_cmd), { repeating = true })
hl.bind(mod .. " + minus", hl.dsp.exec_cmd(zoom_out_cmd), { repeating = true })
hl.bind(mod .. " + KP_ADD", hl.dsp.exec_cmd(zoom_in_cmd), { repeating = true })
hl.bind(mod .. " + KP_SUBTRACT", hl.dsp.exec_cmd(zoom_out_cmd), { repeating = true })

-- Reset Zoom
hl.bind(mod .. " + SHIFT + mouse_up", hl.dsp.exec_cmd(zoom_reset_cmd))
hl.bind(mod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd(zoom_reset_cmd))
hl.bind(mod .. " + SHIFT + minus", hl.dsp.exec_cmd(zoom_reset_cmd))
hl.bind(mod .. " + SHIFT + KP_SUBTRACT", hl.dsp.exec_cmd(zoom_reset_cmd))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.exec_cmd(zoom_reset_cmd))

-----------------
--- ALT / TAB ---
-----------------

hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ prev = true }))

-- Core Commands
hl.bind(mod .. " + return", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mod .. " + E", hl.dsp.exec_cmd(apps.fileManager))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(apps.menu))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
-- hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + P", hl.dsp.exec_cmd("vicinae vicinae://launch/power"))

-- Move focus
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch/Move Workspaces [1-0]
for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspace
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll Workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window manipulations
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media Control (Playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Hardware / OSD controls
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +2"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -2"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness +5"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -5"))
