-- windowrules.lua
-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Windowrules Configuration                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

------------------------------
---- WINDOWS AND WORKSPACES ----
------------------------------

hl.window_rule({ match = { class = "^(org.gnome.NautilusPreviewer)$" }, float = true })
hl.window_rule({ match = { class = "^(neovide)$", title = "^(Neovide)$" }, opacity = 0.9 })

-- Ignore maximize requests from apps
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland
hl.window_rule({
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Workspace Configs
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f", gaps_out = 0, gaps_in = 0 })

-- Window rules for specific workspaces
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f" }, border_size = 0, rounding = 0 })

-- Swaync & Vicinae Layer Rules
hl.layer_rule({
	match = { namespace = "swaync-control-center" },
	blur = true,
	ignore_alpha = 0,
	animation = "slide right",
})
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "vicinae" }, blur = true, ignore_alpha = 0, no_anim = true })

--------------------------------
---- FLOAT NECESSARY WINDOWS ---
--------------------------------

hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)" }, float = true, persistent_size = true })
hl.window_rule({ match = { title = "^(Picture in picture)$", class = "^()$" }, float = true })
hl.window_rule({ match = { title = "^(Save File)$", class = "^()$" }, float = true, persistent_size = true })
hl.window_rule({ match = { title = "^(Open File)$", class = "^()$" }, float = true, persistent_size = true })
hl.window_rule({ match = { class = "^(LibreWolf)$", title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true, persistent_size = true })
hl.window_rule({
	match = { class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland)(.*)$" },
	float = true,
	persistent_size = true,
})
hl.window_rule({
	match = {
		class = "^(polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1)(.*)$",
	},
	float = true,
})
hl.window_rule({ match = { class = "^(CachyOSHello)$" }, float = true })
hl.window_rule({ match = { class = "^(zenity)$" }, float = true })
hl.window_rule({ match = { title = "^(Steam - Self Updater)$", class = "^()$" }, float = true })

-----------------------
---- OPACITY RULES ----
-----------------------

hl.window_rule({ match = { class = "^(thunar|nemo)$" }, opacity = 0.92 })
hl.window_rule({ match = { class = "^(kitty)$" }, opacity = 0.9 })
hl.window_rule({ match = { class = "^(discord|armcord|webcord)$" }, opacity = 0.96 })
hl.window_rule({ match = { title = "^(QQ|Telegram)$" }, opacity = 0.95 })
hl.window_rule({ match = { title = "^(NetEase Cloud Music Gtk4)$" }, opacity = 0.95 })

------------------------------
---- GENERAL WINDOW RULES ----
------------------------------

hl.window_rule({ match = { title = "^(danmufloat)$" }, pin = true })
hl.window_rule({ match = { title = "^(danmufloat|termfloat)$" }, rounding = 5 })
hl.window_rule({ match = { class = "^(kitty|Alacritty)$" }, animation = "slide right" })
hl.window_rule({ match = { class = "^(org.mozilla.firefox)$" }, no_blur = true })

-- Tiling windows on workspaces 1-10
hl.window_rule({ match = { float = false, workspace = "f[1-10]" }, border_size = 3, rounding = 4 })

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Workspaces & Layers Rules                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- Workspaces Rules
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "fs[false]", gaps_out = 0, gaps_in = 0 })

-- Combined border and rounding rules for specific workspaces
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 0, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "fs[false]" }, border_size = 0, rounding = 0 })

-- Layers Rules
hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "slide top" })
hl.layer_rule({ match = { namespace = "waybar" }, animation = "slide down" })
hl.layer_rule({ match = { namespace = "wallpaper" }, animation = "fade 50%" })
