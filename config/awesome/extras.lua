-- Standard awesome library
local awful = require("awful")

-- Bling bling
local bling = require("bling")

-- Layouts
local machi = require("layout-machi")

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.fair,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile.bottom,
    bling.layout.centered,
    machi.default_layout,
    bling.layout.mstab,
    awful.layout.suit.floating,
}

-- Generate wallpaper
awful.screen.connect_for_each_screen(function(s)
    bling.module.tiled_wallpaper("", s, {
        fg = "#384149",
        bg = "#1f252a",
        offset_y = 15,
        offset_x = 15,
        font = "Iosevka Nerd Font",
        font_size = 15,
        padding = 100,
        zickzack = true
    })
end)

-- Flash focus
-- bling.module.flash_focus.enable()
