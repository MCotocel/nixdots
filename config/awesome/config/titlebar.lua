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

-- Titlebar
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
                wibox.layout.margin(awful.widget.clienticon(c), dpi(7), dpi(7), dpi(7), dpi(7)),
                layout = wibox.layout.fixed.horizontal,
            },
            {
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                wibox.layout.margin(awful.titlebar.widget.maximizedbutton(c), dpi(1), dpi(1), dpi(9), dpi(9)),
                wibox.layout.margin(awful.titlebar.widget.minimizebutton(c), dpi(1), dpi(1), dpi(9), dpi(9)),
                wibox.layout.margin(awful.titlebar.widget.closebutton(c), dpi(1), dpi(1), dpi(9), dpi(9)),
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
        --left = dpi(12),
        --right = dpi(12),
        --top = dpi(9),
        --bottom = dpi(9)
    }
end)
