pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")

-- Bling
local bling = require("modules.bling")

-- Hotkey help for other apps
require("awful.hotkeys_popup.keys")

client.connect_signal("request::titlebars", function(c)

    -- Buttons for the titlebar
    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end))

    awful.titlebar(c, {position = 'top', size = dpi(35)}):setup{
        {
           {
                 awful.titlebar.widget.closebutton(c),
                 awful.titlebar.widget.minimizebutton(c),
                 awful.titlebar.widget.maximizedbutton(c),
                 layout = wibox.layout.fixed.horizontal,
                 spacing = dpi(5),
            },
              margins = dpi(12),
              widget = wibox.container.margin
           },
           {
              layout = wibox.layout.flex.horizontal
           },
           {
              awful.titlebar.widget.titlewidget(c),
              margins = dpi(10),
              buttons = buttons,
              widget = wibox.container.margin,
           },
        layout = wibox.layout.align.horizontal
    }
end)
