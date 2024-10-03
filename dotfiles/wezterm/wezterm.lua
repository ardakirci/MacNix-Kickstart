-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()


-- This is where you actually apply your config choices
config.quit_when_all_windows_are_closed = false
-- For example, changing the color scheme:
config.use_fancy_tab_bar = false

config.enable_kitty_keyboard = true
--config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = true
config.front_end = "WebGpu"
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
config.native_macos_fullscreen_mode = true
config.color_scheme = "Catppuccin Macchiato"
config.font_size = 17
config.font = wezterm.font {
  family = 'Liga SFMono Nerd Font',
}
config.keys = {
-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
      key="LeftArrow",
      mods="OPT",
      action=wezterm.action{SendString="\x1bb"}
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
      key="RightArrow",
      mods="OPT",
      action=wezterm.action{SendString="\x1bf"}
    },
      -- splitting
  {
    mods   = "LEADER",
    key    = "-",
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    mods   = "LEADER",
    key    = "=",
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
{
    mods = 'LEADER',
    key = 'm',
    action = wezterm.action.TogglePaneZoomState
  },
{
    mods = 'LEADER',
    key = '0',
    action = wezterm.action.PaneSelect {
      mode = 'SwapWithActive',
    },
  },

{
    key = 'H',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'J',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Down', 5 },
  },
  { key = 'K', mods = 'LEADER', action = act.AdjustPaneSize { 'Up', 5 } },
  {
    key = 'L',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
   {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },

  }



config.unix_domains = {
  {
    name = 'default',
  },
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
config.default_gui_startup_args = { 'connect', 'default' }

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1500 }



-- smart split nvim plugin config



-- and finally, return the configuration to wezterm
return config
