-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local wibox = require("wibox")

-- Gears for shapes
local gears = require("gears")

-- Misc libraries
local bling = require("modules.bling")
local machi = require("modules.layout-machi")
local naughty = require("naughty")
local gears = require("gears")

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.fair,
    awful.layout.suit.tile.right,
    awful.layout.suit.magnifier,
    awful.layout.suit.spiral.dwindle,
    bling.layout.centered,
    bling.layout.deck,
    bling.layout.equalarea,
    bling.layout.mstab,
    bling.layout.horizontal,
    bling.layout.vertical,
    awful.layout.suit.floating,
    machi.default_layout,
}

beautiful.layout_machi = machi.get_icon()

machi.editor.nested_layouts = {
    ["1"] = bling.layout.centered,
    ["2"] = bling.layout.deck,
    ["3"] = bling.layout.equalarea,
    ["4"] = bling.layout.mstab,
}

bling.module.wallpaper.setup {
  wallpaper = {"/home/matei/Pictures/Wallpaper/Ravine.jpg"},
  position = "maximized",
}

-- Flash focus
bling.module.flash_focus.disable()

-- Window switcher
bling.widget.window_switcher.enable {
    type = "",
    hide_window_switcher_key = "Escape",
    minimize_key = "m",
    unminimize_key = "M",
    kill_client_key = "q",
    cycle_key = "Tab",
    previous_key = "Left",
    next_key = "Right"
}
