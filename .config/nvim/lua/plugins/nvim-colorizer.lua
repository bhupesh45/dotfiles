return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" }, -- Load on existing AND new files
	opts = {
		filetypes = { "*" }, -- Enable for all filetypes
		user_default_options = {
			names = false, -- Disable "blue", "red" text matching (reduces noise in code)
			RGB = true, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = true, -- 0xAARRGGBB hex codes (Common in Linux configs)

			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

			-- Tailwind Support (The main reason to use the catgoose fork)
			tailwind = true,
			-- tailwind_opts = { update_names = true }, -- Enable if using custom tailwind config

			-- Visuals
			mode = "virtualtext", -- Keep your preferred mode
			virtualtext = "■", -- A solid block usually looks cleaner than the hollow square
			virtualtext_inline = true,
			always_update = true,
		},
	},
}
