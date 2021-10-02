-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Misc libraries
local bling = require("bling")
local machi = require("layout-machi")

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.fair,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile.bottom,
    bling.layout.centered,
    bling.layout.deck,
    bling.layout.equalarea,
    bling.layout.mstab,
    machi.default_layout,
    awful.layout.suit.floating,
}

machi.editor.nested_layouts = {
    ["0"] = awful.layout.suit.fair,
    ["1"] = awful.layout.suit.tile,
    ["2"] = awful.layout.suit.tile.left,
    ["3"] = awful.layout.suit.tile.top,
    ["4"] = awful.layout.suit.tile.bottom,
    ["5"] = bling.layout.centered,
    ["6"] = bling.layout.deck,
    ["7"] = bling.layout.equalarea,
    ["8"] = bling.layout.mstab,
}


-- Corners
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h, r) gears.shape.rounded_rect(cr, w, h, 15) end
end)

-- No corners in fullscreen
local function is_maximized(c)
    local function _fills_screen()
        local wa = c.screen.workarea
        local cg = c:geometry()
        return wa.x == cg.x and wa.y == cg.y and wa.width == cg.width and wa.height == cg.height
    end
    return c.maximized or (not c.floating and _fills_screen())
end


client.connect_signal("property::geometry", function(c)
    if is_maximized(c) then
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr, w, h, 15)
        end
    else
        c.shape = function(cr,w,h)
           gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0)
        end
    end
end)


bling.module.wallpaper.setup {
  wallpaper = {"/home/matei/Pictures/Wallpaper/Typewriter.jpg"},
}

-- Flash focus
bling.module.flash_focus.disable()
