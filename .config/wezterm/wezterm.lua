-- Pull in the wezterm API
local wezterm = require "wezterm"
local act = wezterm.action
local sessionizer = require "sessionizer"

-- This will hold the configuration
local config = wezterm.config_builder()

wezterm.on("update-right-status", function(window, _)
    window:set_right_status(window:active_workspace())
end)

config.audible_bell = "Disabled"
config.enable_wayland = false

config.font = wezterm.font "BerkeleyMono Nerd Font"
config.color_scheme = "GruvboxDarkHard"
config.colors = {
    background = "#000000",
}
config.font_size = 22

config.warn_about_missing_glyphs = false

-- config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.tab_bar_at_bottom = true

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
    {
        key = "f",
        mods = "CTRL",
        action = wezterm.action_callback(sessionizer.toggle),
    },

    -- Prompt for a name to use for a new workspace and switch to it.
    {
        key = "w",
        mods = "LEADER",
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Fuchsia" } },
                { Text = "Enter name for new workspace" },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
    {
        key = "L",
        mods = "LEADER",
        action = act.ShowLauncherArgs { flags = "WORKSPACES" },
    },
    {
        key = "c",
        mods = "LEADER",
        action = act.SpawnTab "CurrentPaneDomain",
    },
    {
        key = "x",
        mods = "LEADER",
        action = act.CloseCurrentTab { confirm = true },
    },
    {
        key = "l",
        mods = "LEADER",
        action = act.ActivateLastTab,
    },
    {
        key = "n",
        mods = "ALT",
        action = act.SwitchWorkspaceRelative(1),
    },
    {
        key = "p",
        mods = "ALT",
        action = act.SwitchWorkspaceRelative(-1),
    },
    {
        key = "|",
        mods = "LEADER|SHIFT",
        action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
        key = "_",
        mods = "LEADER|SHIFT",
        action = act.SplitVertical { domain = "CurrentPaneDomain" },
    },

    {
        key = "h",
        mods = "CTRL|SUPER",
        action = act.ActivatePaneDirection "Left",
    },
    {
        key = "l",
        mods = "CTRL|SUPER",
        action = act.ActivatePaneDirection "Right",
    },
    {
        key = "k",
        mods = "CTRL|SUPER",
        action = act.ActivatePaneDirection "Up",
    },
    {
        key = "j",
        mods = "CTRL|SUPER",
        action = act.ActivatePaneDirection "Down",
    },

    -- {
    --   key = "x",
    --   mods = "LEADER",
    --   action = wezterm.action_callback(function(window, pane)
    --     local workspace = window:active_workspace()
    --     func.kill_workspace(window, pane, workspace)
    --   end),
    -- },
}

for i = 1, 5 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL",
        action = act.ActivateTab(i - 1),
    })
end

for i = 1, 8 do
    -- CTRL+ALT + number to move to that position
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL|ALT",
        action = act.MoveTab(i - 1),
    })
end

-- config.window_frame = {
--   border_left_width = '0.1cell',
--   border_right_width = '0.1cell',
--   border_bottom_height = '0.05cell',
--   border_top_height = '0.05cell',
--   border_left_color = '#fc3838',
--   border_right_color = '#fc3838',
--   border_bottom_color = '#fc3838',
--   border_top_color = '#fc3838',
-- }

-- config.window_decorations = "RESIZE"

config.automatically_reload_config = true
config.check_for_updates = true

config.pane_focus_follows_mouse = true
-- config.window_background_opacity = 0.95
config.default_prog = { "/usr/bin/zsh", "-l" }
config.hide_mouse_cursor_when_typing = true
-- config.xcursor_theme = "Breeze-Light"
-- config.xcursor_size = 24

return config
