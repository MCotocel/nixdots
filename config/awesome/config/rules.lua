pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Hotkey help for other apps
require("awful.hotkeys_popup.keys")

-- Rules
awful.rules.rules = {
    -- All clients will match this rule
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            maximized_vertical = false,
            maximized_horizontal = false,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            titlebars_enabled = true
        }
    },
    {
       rule = { class = "lxtask" },
       properties = {
          floating = true,
          titlebars_enabled = false
       }
    }
}

-- Snippet from https://github.com/Vermoot
-- Centres window in parent window
client.connect_signal("manage", function (c)
   if c.floating then
      if c.transient_for == nil then
         awful.placement.centered(c)
      else
         awful.placement.centered(c, {parent = c.transient_for})
      end
         awful.placement.no_offscreen(c)
   end
end)

-- Fullscreen instead of maximise
client.connect_signal("property::maximized", function(c)
    c.maximized = false
    c.fullscreen = true
end)
