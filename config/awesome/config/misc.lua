-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local wibox = require("wibox")

-- Gears for shapes
local gears = require("gears")

-- Misc libraries
local naughty = require("naughty")
local gears = require("gears")

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.fair,
    awful.layout.suit.tile.right,
    awful.layout.suit.magnifier,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
}
