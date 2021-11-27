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
-- local function create_title_button(c, color_focus, color_unfocus, shape)
--     local tb = wibox.widget {
--         forced_width = dpi(16),
--         forced_height = dpi(16),
--         bg = color_focus .. 80,
--         shape = shape,
--         widget = wibox.container.background
--     }
-- 
--     local function update()
--         if client.focus == c then
--             tb.bg = color_focus
--         else
--             tb.bg = color_unfocus
--         end
--     end
--     update()
-- 
--     c:connect_signal("focus", update)
--     c:connect_signal("unfocus", update)
-- 
--     tb:connect_signal("mouse::enter", function() tb.bg = color_focus .. 55 end)
--     tb:connect_signal("mouse::leave", function() tb.bg = color_focus end)
-- 
--     tb.visible = true
--     return tb
-- end
-- 
-- local ci = function(width, height)
--     return function(cr) gears.shape.circle(cr, width, height) end
-- end
-- 
-- local close = create_title_button(c, "#FF8080",
--                                   beautiful.bg_normal, ci(12, 12))
-- close:connect_signal("button::press", function() c:kill() end)
-- local min = create_title_button(c, "#FFFE80",
--                                 beautiful.bg_normal, ci(12, 12))
-- min:connect_signal("button::press", function() c.minimized = true end)
-- local max = create_title_button(c, "#97D59B",
--                                 beautiful.bg_normal, ci(12, 12))
-- max:connect_signal("button::press",
--                    function() c.maximized = not c.maximized end)

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
               wibox.container.margin(awful.widget.clienticon(c), dpi(7), dpi(7), dpi(7), dpi(7)),
               layout = wibox.container.fixed.horizontal,
            },
            {
               buttons = buttons,
               layout = wibox.container.flex.horizontal
            },
            {
               --max,
               --min,
               --close,
               wibox.container.margin(awful.titlebar.widget.maximizedbutton(c), dpi(1), dpi(1), dpi(9), dpi(9)),
               wibox.container.margin(awful.titlebar.widget.minimizebutton(c), dpi(1), dpi(1), dpi(9), dpi(9)),
               wibox.container.margin(awful.titlebar.widget.closebutton(c), dpi(1), dpi(1), dpi(9), dpi(9)),
               layout = wibox.container.fixed.horizontal,
            },
            layout = wibox.container.align.horizontal
        },
        widget = wibox.container.margin,
        --left = dpi(12),
        --right = dpi(12),
        --top = dpi(9),
        --bottom = dpi(9)
    }
end)
