local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

-- Pane appearance settings
config.inactive_pane_hsb = {
  saturation = 0.8, -- Default: 0.9
  brightness = 0.5, -- Default: 0.8
}

-- Key bindings
config.keys = {
  -- Terminal control shortcuts
  -- --------------------------------------------------------
  
  -- Disable the default CMD+K behavior (Super+k) so we can overwrite it
  { key = 'k', mods = 'CMD', action = act.DisableDefaultAssignment },
  
  -- Clear scrollback & viewport, then redraw prompt
  { 
    key = 'k', 
    mods = 'CMD',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' },
    },
  },
  
  -- Search case insensitive, default is case sensitive
  { key = 'f', mods = 'CMD', action = act.Search({ CaseInSensitiveString = '' }) },
  
  -- Windows and Tabs
  -- --------------------------------------------------------
  -- Open new window in home directory
  { key = 'n', mods = 'CMD', action = act.SpawnCommandInNewWindow { cwd = wezterm.home_dir } },
  
  -- Open new tab in home directory
  { key = 't', mods = 'CMD', action = act.SpawnCommandInNewTab { cwd = wezterm.home_dir } },
  
  -- Close current tab/pane
  { key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = true } },
  
  -- Pane management
  -- --------------------------------------------------------
  -- Split panes
  { key = 'd', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  
  -- Navigate between panes
  { key = '[', mods = 'CMD', action = act.ActivatePaneDirection 'Prev' },
  { key = ']', mods = 'CMD', action = act.ActivatePaneDirection 'Next' },
  { key = 'h', mods = 'CMD', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CMD', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CMD', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CMD', action = act.ActivatePaneDirection 'Right' },
  
  -- Resize panes
  { key = 'h', mods = 'CMD|ALT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'l', mods = 'CMD|ALT', action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'k', mods = 'CMD|ALT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'j', mods = 'CMD|ALT', action = act.AdjustPaneSize { 'Down', 5 } },
}

return config

