local mod = "SUPER" -- Sets "Windows" key as main modifier

--------------------
---- FULLSCREEN ----
--------------------

-- hl.bind(mod .. " + F", hl.dsp.fullscreenstate("3"))
-- hl.bind(mod .. " + grave", hl.dsp.fullscreen())

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

-- hl.bind("ALT + Tab", hl.dsp.cyclenext("skipvisible"))
-- hl.bind("ALT + SHIFT + Tab", hl.dsp.cyclenext("prev skipvisible"))
