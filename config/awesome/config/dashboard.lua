-- Load required libraries
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")
local volume_bar = require("config.volume_bar")
local beautiful = require("beautiful")

local dashboard_visible = true

local dashboard = wibox({
    visible = false,
    ontop = true,
    screen = screen.primary,
    width = 500,
    height = awful.screen.focused().geometry.height,
    x = 0,
    y = 0,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
})

-- Add widgets to the dashboard
dashboard:setup {
    {
        volume_bar,
        layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.fixed.horizontal
}

dashboard_toggle = function()
   dashboard.visible = not dashboard.visible
end
