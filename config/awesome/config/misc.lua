-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Gears for shapes
local gears = require("gears")

-- Misc libraries
local bling = require("modules.bling")
local machi = require("modules.layout-machi")

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

--bling.module.wallpaper.setup {
--  wallpaper = {"/home/matei/Pictures/Wallpaper/Waves Dark.jpg"},
--  position = "maximized",
--}

awful.screen.connect_for_each_screen(function(s) -- that way the wallpaper is applied to every screen
    bling.module.tiled_wallpaper("ﬦ", s, {       -- call the actual function ("x" is the string that will be tiled)
        fg = "#1f252a", -- define the foreground color
        bg = "#181e23", -- define the background color
        offset_y = 25,  -- set a y offset
        offset_x = 25,  -- set a x offset
        font = "Iosevka Nerd Font",  -- set the font (without the size)
        font_size = 24, -- set the font size
        padding = 100,  -- set padding (default is 100)
        zickzack = true -- rectangular pattern or criss cross
    })
end)

-- Flash focus
bling.module.flash_focus.disable()

-- Window switcher
bling.widget.window_switcher.enable {
    type = "thumbnail",
    hide_window_switcher_key = "Escape",
    minimize_key = "m",
    unminimize_key = "M",
    kill_client_key = "q",
    cycle_key = "Tab",
    previous_key = "Left",
    next_key = "Right"
}

