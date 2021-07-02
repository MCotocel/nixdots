-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

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
    awful.titlebar(c, {position = 'top', size = '20'}):setup{
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                layout = wibox.layout.fixed.horizontal,
                widget
            },
            {
                {
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c),
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                awful.widget.clienticon(c),
                layout = wibox.layout.fixed.horizontal,
                widget
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
        left = 2,
        right = 2,
        top = 0,
        bottom = 2
    }
end)

-- Titlebar only if floating
client.connect_signal("property::floating", function(c) 
    if c.floating then awful.titlebar.show(c) else awful.titlebar.hide(c) end 
end)

-- Corners
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h, r) gears.shape.octogon(cr, w, h, 0) end
end)

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
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap +
            awful.placement.no_offscreen
        }
    }, -- Floating clients.
    {
        rule_any = {
            class = {
                "Gpick", "Tor Browser", "Gimp"
            }

        },
        properties = {
            floating = true
        }
    }, -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {
                "normal", "dialog"
            }
        },
        properties = {
            titlebars_enabled = false
        }
    }
}
