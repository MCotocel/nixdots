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
                 --wibox.container.margin(awful.titlebar.widget.maximizedbutton(c), dpi(3), dpi(3), dpi(7), dpi(7)),
                 --wibox.container.margin(awful.titlebar.widget.minimizebutton(c), dpi(3), dpi(3), dpi(7), dpi(7)),
                 --wibox.container.margin(awful.titlebar.widget.closebutton(c), dpi(3), dpi(3), dpi(7), dpi(7)),
                 awful.titlebar.widget.closebutton(c),
                 awful.titlebar.widget.minimizebutton(c),
                 awful.titlebar.widget.maximizedbutton(c),
                 layout = wibox.layout.fixed.horizontal,
            },
              margins = dpi(8),
              widget = wibox.container.margin
           },
            {
               {
                  align = 'center',
                  widget = awful.titlebar.widget.titlewidget(c),
               },
               buttons = buttons,
               layout = wibox.layout.flex.horizontal
            },
            {
               awful.titlebar.widget.iconwidget(c),
               margins = dpi(8),
               buttons = buttons,
               widget = wibox.container.margin,
            },
        layout = wibox.layout.align.horizontal
    }
end)
