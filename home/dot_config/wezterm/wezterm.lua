local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

-- Enable kitty keyboard protocol so Shift+Enter works correctly with Claude Code
config.enable_kitty_keyboard = true

-- Pane appearance settings
config.inactive_pane_hsb = {
  saturation = 0.8, -- Default: 0.9
  brightness = 0.5, -- Default: 0.8
}

-- Mouse bindings
config.mouse_bindings = {
  -- Disable the default click behavior
  {
    event = { Up = { streak = 1, button = "Left"} },
    mods = "NONE",
    action = wezterm.action.CompleteSelection 'PrimarySelection',
  },
  -- Taken from https://wezterm.org/recipes/hyperlinks.html#optional-configuration
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = act.OpenLinkAtMouseCursor,
  },
  -- Disable the 'Down' event of CMD-Click to avoid weird program behaviors
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = act.Nop,
  },
}

-- Key bindings
config.keys = {
  -- Terminal control shortcuts
  -- --------------------------------------------------------
  
  -- Disable the default SUPER+K behavior
  { key = 'k', mods = 'SUPER', action = act.DisableDefaultAssignment },
  
  -- Clear scrollback & viewport, then redraw prompt
  { 
    key = 'k', 
    mods = 'SUPER',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' },
    },
  },
  
  -- Search case insensitive, default is case sensitive
  { key = 'f', mods = 'SUPER', action = act.Search({ CaseInSensitiveString = '' }) },
  
  -- Windows and Tabs
  -- --------------------------------------------------------
  -- Open new window in home directory
  { key = 'n', mods = 'SUPER', action = act.SpawnCommandInNewWindow { cwd = wezterm.home_dir } },
  
  -- Open new tab in home directory
  { key = 't', mods = 'SUPER', action = act.SpawnCommandInNewTab { cwd = wezterm.home_dir } },
  
  -- Close current tab/pane
  { key = 'w', mods = 'SUPER', action = act.CloseCurrentPane { confirm = true } },

  -- Pane management
  -- --------------------------------------------------------
  -- Split panes
  { key = 'd', mods = 'SUPER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'SUPER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Navigate between panes
  { key = '[', mods = 'SUPER', action = act.ActivatePaneDirection 'Prev' },
  { key = ']', mods = 'SUPER', action = act.ActivatePaneDirection 'Next' },

  -- Resize panes
  { key = 'h', mods = 'SUPER|ALT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'l', mods = 'SUPER|ALT', action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'k', mods = 'SUPER|ALT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'j', mods = 'SUPER|ALT', action = act.AdjustPaneSize { 'Down', 5 } },
}

return config
