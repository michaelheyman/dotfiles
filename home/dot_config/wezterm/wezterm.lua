local wezterm = require 'wezterm'
local act = wezterm.action

config = wezterm.config_builder()

config.inactive_pane_hsb = {
  saturation = 0.8, -- Default: 0.9
  brightness = 0.5, -- Default: 0.8
}

  config.keys = {
  -- Disable the default CMD+K behavior (Super+k) so we can overwrite it
  {
    key = 'k',
    mods = 'CMD',
    action = act.DisableDefaultAssignment,
  },
  -- Clear scrollback & viewport, then redraw prompt
  {
    key = 'k',
    mods = 'CMD',
    action = act.Multiple {
      -- Clear the terminal's scrollback and visible viewport
      act.ClearScrollback 'ScrollbackAndViewport',
      -- Ask the shell to redraw its prompt on the fresh screen (sends Ctrl+L)
      act.SendKey { key = 'L', mods = 'CTRL' },
    },
  },

  -- Search case insensitive, default is case sensitive
  {
    key = 'f',
    mods = 'CMD',
    action = act.Search({ CaseInSensitiveString = '' })
  },

  -- Windows, Tabs, and Panes
  -- Open new window in home directory
  {
    key = 'n',
    mods = 'CMD',
    action = act.SpawnCommandInNewWindow { cwd = wezterm.home_dir }
  },
  -- Open new tab in home directory
  {
    key = 't',
    mods = 'CMD',
    action = act.SpawnCommandInNewTab { cwd = wezterm.home_dir }
  },
  -- Split pane vertically
  {
    key = 'd',
    mods = 'CMD',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split pane horizontally
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Close current pane
  {
    key = 'w',
    mods = 'CMD',
    action = act.CloseCurrentPane { confirm = true },
  },
  -- Navigate to the previous pane
  {
    key = '[',
    mods = 'CMD',
    action = act.ActivatePaneDirection 'Prev',
  },
  -- Navigate to the next pane
  {
    key = ']',
    mods = 'CMD',
    action = act.ActivatePaneDirection 'Next',
  },
  -- Resize panes
  { key = 'h', mods = 'CMD|ALT', action = act.AdjustPaneSize { 'Left', 1 } },
  { key = 'l', mods = 'CMD|ALT', action = act.AdjustPaneSize { 'Right', 1 } },
  { key = 'k', mods = 'CMD|ALT', action = act.AdjustPaneSize { 'Up', 1 } },
  { key = 'j', mods = 'CMD|ALT', action = act.AdjustPaneSize { 'Down', 1 } },
}

return config

