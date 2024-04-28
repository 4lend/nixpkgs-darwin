local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')
local colors = require('colors.custom')
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
   local tab, pane, window = mux.spawn_window(cmd or {})
   window:gui_window():maximize()
end)

return {
   animation_fps = 60,
   max_fps = 60,
   front_end = 'WebGpu',
   webgpu_power_preference = 'HighPerformance',
   webgpu_preferred_adapter = gpu_adapters:pick_best(),

   -- color scheme
   colors = colors,

   -- -- background
   -- background = {
   --    {
   --       source = { File = wezterm.GLOBAL.background },
   --    },
   --    {
   --       source = { Color = colors.background },
   --       height = '100%',
   --       width = '100%',
   --       opacity = 0.96,
   --    },
   -- },

   -- scrollbar
   enable_scroll_bar = false,

   -- tab bar
   enable_tab_bar = false,
   hide_tab_bar_if_only_one_tab = true,
   use_fancy_tab_bar = true,
   tab_max_width = 25,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- window
   native_macos_fullscreen_mode = true,
   window_decorations = 'RESIZE',
   window_padding = {
      left = 5,
      right = 10,
      top = 12,
      bottom = 7,
   },
   window_close_confirmation = 'NeverPrompt',
   window_frame = {
      active_titlebar_bg = '#090909',
      border_left_width = '0.5cell',
      border_right_width = '0.5cell',
      border_bottom_height = '0.25cell',
      border_top_height = '0.25cell',
      -- border_left_color = 'purple',
      -- border_right_color = 'purple',
      -- border_bottom_color = 'purple',
      -- border_top_color = 'purple',
   },
   inactive_pane_hsb = {
      saturation = 0.9,
      brightness = 0.65,
   },

   term = "xterm-256color",

   -- wezterm.on("gui-startup", function()
   --   local tab, pane, window = mux.spawn_window{}
   --   window:gui_window():maximize()
   -- end)

   -- return {}
}
