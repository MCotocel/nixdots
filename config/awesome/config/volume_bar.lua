local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local function update_volume(widget)
    awful.spawn.easy_async_with_shell(
        "amixer sget Master",
        function(stdout)
            local volume = string.match(stdout, "(%d?%d?%d)%%")
            volume = tonumber(string.format("% 3d", volume))
            widget.value = volume / 100
            widget:update()
        end
    )
end

local function volume_up()
    awful.spawn("amixer -q set Master 2%+")
    update_volume(volume_widget)
end

local function volume_down()
    awful.spawn("amixer -q set Master 2%-")
    update_volume(volume_widget)
end

local function volume_toggle()
    awful.spawn("amixer -q set Master toggle")
    update_volume(volume_widget)
end

local volume_bar = wibox.widget {
    max_value = 1,
    forced_width = 400,
    forced_height = 50,
    paddings = 2,
    border_width = 1,
    color = beautiful.bg_diff,
    background_color = beautiful.bg_normal,
    border_color = beautiful.fg_normal,
    widget = wibox.widget.progressbar,
}

update_volume(volume_bar)

volume_bar:buttons(
    gears.table.join(
        awful.button({}, 4, volume_up),
        awful.button({}, 5, volume_down),
        awful.button({}, 1, volume_toggle)
    )
)

gears.timer {
    timeout = 0.05,
    autostart = true,
    callback = function() update_volume(volume_bar) end
}

return volume_bar
