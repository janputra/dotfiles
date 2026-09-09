local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'Maple Mono NF'
config.font_size = 11.0

-- Define your choice of themes for dark and light modes
local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Frappe' -- Change to your favorite dark theme
  else
    return 'Catppuccin Latte'    -- Change to your favorite light theme
  end
end

-- Set the initial color scheme based on current system appearance
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.use_fancy_tab_bar = false
return config
