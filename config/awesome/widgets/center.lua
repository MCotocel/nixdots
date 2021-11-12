local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local helpers = require("helpers")

function vert_pad(height)
    return wibox.widget {
        forced_height = height,
        layout = wibox.layout.fixed.vertical
    }
end

function hor_pad(width)
    return wibox.widget {
        forced_width = width,
        layout = wibox.layout.fixed.horizontal
    }
end

local center = {
   hor_pad(10),
   wibox.widget {
      text = "Testing",
      align = "center",
      valign = "center",
      widget = wibox.widget.textbox
   },
   wibox.widget {
       max_value = 100,
       background_color = beautiful.bg_normal,
       color = beautiful.bg_diff,
       widget = wibox.widget.progressbar
   },
   nil,
   expand = "none",
   layout = wibox.layout.align.horizontal
}

local awful = require("awful")
local helpers = require("helpers")

local update_interval = 10 -- every 3 minutes

local disk_script = [[
    sh -c "
    echo 75
    "
]]

awful.widget.watch(disk_script, update_interval, function(_, stdout)
    local available = tonumber(stdout:match('^(.*)@')) / 1000
    local used = tonumber(stdout:match('@(.*)$')) / 1000
    awesome.emit_signal("signal::disk", used, available + used)
end)

awesome.connect_signal("signal::disk", function(used, total)
    disk_bar.value = tonumber(100 * used / total)
end)

local center_width = 800
local center_height = 400
local centerbox = wibox {
    height = center_height,
    width = center_width,
    x = 300,
    y = 150,
    visible = false,
    ontop = true,
    shape = gears.shape.rounded_rect,
    bg = beautiful.bg_diff
}

awesome.connect_signal("toggle::dash", function()
    centerbox.visible = not centerbox.visible
end)

centerbox:setup(center)
