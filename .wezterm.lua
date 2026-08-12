local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'Maple Mono NF'
config.font_size = 11.0
config.color_scheme = 'Monokai Pro (Gogh)'

return config
