local awful = require("awful")
local beautiful = require("beautiful")
beautiful.init("/home/matei/.config/awesome/quiet/theme.lua")
local bling = require("bling")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local machi = require("layout-machi")
local naughty = require('naughty')
local revelation = require("awesome-revelation")
revelation.charorder = "1234567890qwertyuiopasdfghjklzxcvbnm"
local wibox = require("wibox")
root.keys(globalkeys)

terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"

awful.spawn.with_shell("~/.config/awesome/autorun.sh")

-- Discord scratchpad
local discord_scratch = bling.module.scratchpad:new {
    command = "discocss",
    rule = { instance = "discord" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=200, y=70, height=600, width=700},
    reapply = true,
    dont_focus_before_close = false
}

-- Terminal scratchpad
local terminal_scratch = bling.module.scratchpad:new {
    command = "alacritty --class term_scratch",
    rule = { instance = "term_scratch" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=0, y=0, height=300, width=1366},
    reapply = true,
    dont_focus_before_close = false,
}

bling.widget.tag_preview.enable {
  show_client_content = false,
  x = 1280,
  y = 720,
  scale = 0.50,
  honor_padding = false,
  honor_workarea = false
}

modkey = "Mod4"
globalkeys = gears.table.join(

-- Toggle titlebar
awful.key({modkey}, '`', function() awful.titlebar.toggle(client.focus) end, {
    description = "Toggle title bar", group = "AwesomeWM"
}),

-- Expose
awful.key({modkey}, "e", revelation, {
    description = 'Expose', group = "AwesomeWM"
}),

-- Execute Lua code
awful.key({modkey}, "r", function() awful.prompt.run {
    prompt = "Run Lua code: ",
    textbox = awful.screen.focused().promptbox.widget,
    exe_callback = awful.util.eval,
    history_path = awful.util.get_cache_dir() .. "/history_eval" } end, {
    description = 'Execute Lua Code', group = "AwesomeWM"
}),

-- Toggle Wibar
awful.key({modkey}, "b", function() for s in screen do s.wibar.visible = not s.wibar.visible end end, {
    description = 'Toggle Wibar', group = "AwesomeWM"
}),

-- Discord scratchpad
awful.key({modkey, "Control"}, 'd', function() discord_scratch:toggle() end, {
    description = "Toggle Discord scratchpad", group = "Bling"
}),

-- Terminal scratchpad
awful.key({modkey, "Control"}, 't', function() terminal_scratch:toggle() end, {
    description = "Toggle terminal scratchpad", group = "Bling"
}),

-- Toggle swallowing
awful.key({modkey}, 's', function() bling.module.window_swallowing.toggle() end, {
   description = 'Toggle swallowing', group = "Bling"
}),

-- Show tag preview
awful.key({modkey, 'Control'}, '1', function()
    awesome.emit_signal("bling::tag_preview::update", mouse.screen.selected_tag)
    awesome.emit_signal("bling::tag_preview::visibility", mouse.screen, true)
end, {
    description = 'Show tag preview', group = "Bling"
}),
-- Hide tag preview
awful.key({modkey, 'Control'}, '2', function()
    awesome.emit_signal("bling::tag_preview::visibility", mouse.screen, false)
end, {
    description = 'Show tag preview', group = "Bling"
}),

-- Add client to tabbed layout
awful.key({modkey}, 't', function() bling.module.tabbed.pick() end, {
   description = 'Add client to tabbed layout', group = "Bling"
}),

-- Tab through clients in tabbed client
awful.key({modkey}, 'Tab', function() bling.module.tabbed.iter() end, {
   description = 'Tab through clients in tabbed client', group = "Bling"
}),

-- Edit the current layout
awful.key({modkey}, "'", function() machi.default_editor.start_interactive() end, {
    description = "Edit the current layout",
    group = "Machi"
}),

-- Switch windows in Machi layout
awful.key({modkey}, ".", function() machi.switcher.start(client.focus) end, {
    description = "Switch windows in Machi layout",
    group = "Machi"
}),

-- Switch layout to Machi
awful.key({modkey}, ",", function() awful.layout.set(machi.default_layout) end, {
    description = "Switch layout to Machi",
    group = "Machi"
}),

-- Previous workspace
awful.key({modkey}, "Left", awful.tag.viewprev, {
    description = "Previous workspace",
    group = "Workspaces"
}),

-- Next workspace
awful.key({modkey}, "Right", awful.tag.viewnext, {
    description = "Next workspace",
    group = "Workspaces"
}),

-- Switch layout
awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(1) end, {
    description = "Switch layout",
    group = "Windows"
}),

-- Toggle floating mode
awful.key({modkey, "Control"}, "space", awful.client.floating.toggle, {
    description = "Toggle floating mode",
    group = "Windows"
}),

-- Toggle Fullscreen
awful.key({modkey, "Shift"}, "f", function() client.focus.fullscreen = not client.focus.fullscreen client.focus:raise() end, {
    description = "Toggle fullscreen mode",
    group = "Windows"
}),

-- Close window
awful.key({modkey, "Shift"}, "q", function() client.focus:kill() end, {
    description = "Close window",
    group = "Windows"
}),
-- Focus next client
awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end, {
    description = "Focus next client",
    group = "Windows"
}),

-- Focus previous client
awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end, {
    description = "Focus previous client",
    group = "Windows"
}),

-- Swap with next client
awful.key({modkey, "Control"}, "j", function() awful.client.swap.byidx(1) end, {
    description = "Swap with next client",
    group = "Windows"
}),

-- Swap with previous client
awful.key({modkey, "Control"}, "k", function() awful.client.swap.byidx(-1) end, {
    description = "Swap with previous client",
    group = "Windows"
}),

-- Resize to the right
awful.key({modkey, "Shift"}, "l", function() awful.tag.incmwfact(0.05) end, {
    description = "Resize to the right",
    group = "Windows"
}),
-- Resize to the left
awful.key({modkey, "Shift"}, "h", function() awful.tag.incmwfact(-0.05) end, {
    description = "Resize to the left",
    group = "Windows"
}),

-- Minimize windows
awful.key({modkey}, "m", function() client.focus.minimized = true end, {
    description = "Minimize windows", group = "Windows"
}),

-- Un-minimize windows
awful.key({modkey, "Control"}, "m", function () local c = awful.client.restore() if c then c:activate { raise = true, context = "key.unminimize" } end end, {
    description = "Un-minimize windows", group = "Windows"
}),

-- Open terminal
awful.key({modkey}, "Return", function() awful.spawn(terminal) end, {
    description = "Open terminal",
    group = "Applications and menus"
}),

-- Open launcher
awful.key({modkey}, "space", function() awful.spawn.with_shell("rofi -show drun -display-drun 'App Launcher'") end, {
    description = "Open launcher",
    group = "Applications and menus"
}),

-- Power menu
awful.key({modkey}, "Escape", function() awful.spawn.with_shell("~/.bin/rofi-power") end, {
    description = "Power menu",
    group = "Applications and menus"
}),

-- Hotkey menu
awful.key({modkey}, "/", hotkeys_popup.show_help, {
    description = "Hotkey menu",
    group = "Applications and menus"
}))

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,

    -- View workspace
    awful.key({modkey}, "#" .. i + 9, function() local screen = awful.screen.focused() local tag = screen.tags[i] if tag then tag:view_only() end end, {
        description = "View workspace #" .. i,
        group = "Workspaces"
    }),

    -- Move focused client to workspace
    awful.key({modkey, "Shift"}, "#" .. i + 9, function() if client.focus then local tag = client.focus.screen.tags[i] if tag then client.focus:move_to_tag(tag) end end end, {
        description = "Move focused client to workspace #" .. i,
        group = "Workspaces"
    }))
end

clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
end), awful.button({modkey}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
end), awful.button({modkey}, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
end))

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mainmenu:toggle() end)
))

-- Click to change to workspace
local taglist_buttons = gears.table.join(awful.button({}, 1, function(t) t:view_only() end))

local tasklist_buttons = gears.table.join(
    awful.button({}, 1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end),
    awful.button({}, 3,
        function()
            awful.menu.client_list({theme = {width = 250}})
        end)
)

awful.screen.connect_for_each_screen(function(s)

    -- Set tags and default layout
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.suit.fair)

    -- Show currently used layout
    s.layoutbox = awful.widget.layoutbox(s)

    s.layoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end)
    ))
    -- Taglist widget
    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    -- Tasklist widget
    s.tasklist =
        awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
            layout = {
                spacing = 0,
                spacing_widget = {
                    widget = wibox.container.background
                },
                layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    nil,
                    awful.widget.clienticon,
                    nil,
                    layout = wibox.layout.fixed.horizontal,
                },
                top = 5,
                bottom = 5,
                left = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id = "background_role",
            widget = wibox.container.background
        }
    }

    -- Prompt
    s.promptbox = awful.widget.prompt()

    -- Clock
    clock = wibox.widget.textclock()

    -- Menu
    awesomemenu = {
     {"Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
     {"Reload", awesome.restart},
     {"Quit", function() awesome.quit() end},
    }

    appmenu = {
     {"Terminal", function() awful.spawn.with_shell("alacritty") end},
     {"Editor", function() awful.spawn.with_shell("emacs") end},
     {"Browser", function() awful.spawn.with_shell("qutebrowser") end},
     {"Music", function() awful.spawn.with_shell("spotify") end},
     {"File manager", function() awful.spawn.with_shell("thunar") end},
    }

    scriptmenu = {
     {"Replace app folder", function() awful.spawn.with_shell("~/.bin/apps") end},
     {"Random man page", function() awful.spawn.with_shell("~/.bin/randman") end},
     {"Take screenshot", function() awful.spawn.with_shell("~/.bin/rofi-screenshot") end},
     {"Image to text", function() awful.spawn.with_shell("~/.bin/rofi-imgtext") end},
     {"Shorten url", function() awful.spawn.with_shell("~/.bin/rofi-urlshorten") end},
     {"Change wallpaper", function() awful.spawn.with_shell("~/.bin/rofi-wallpaper") end},
    }

    mainmenu = awful.menu({items = {
        {"AwesomeWM", awesomemenu, beautiful.awesome_icon},
        {"Scripts", scriptmenu, beautiful.terminal},
        {"Apps", appmenu, beautiful.app},
    }})

    launcher = awful.widget.launcher({image = beautiful.ghost, menu = mainmenu})

    -- Create the wibox
    s.wibar = awful.wibar({
        position = "bottom",
        x = 0,
        y = 0,
        screen = s,
        height = 30,
        width = 1200,
        visible = true,
        type = "dock",
        shape = function(cr, w, h, r) gears.shape.octogon(cr, w, h, 0) end,
        stretch = false,
        bg = "#1f252a",
    })

    s.wibar.x = 80
    s.wibar.y = 720

    -- Add widgets
    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            launcher,
            s.taglist,
            wibox.widget {
                widget = wibox.widget.separator,
                forced_width = 25,
                opacity = 0
            },
            s.promptbox,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            {
                s.tasklist,
                shape =  function(cr, w, h, r) gears.shape.rounded_rect(cr, w, h, 20) end,
                widget = wibox.container.background
            }
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            clock,
            --wibox.widget.systray(),
            wibox.layout.margin(wibox.widget.systray(), 7, 7, 7, 7),
            wibox.layout.margin(s.layoutbox, 7, 7, 7, 7),
            wibox.widget {
                widget = wibox.widget.separator,
                forced_width = 1,
                opacity = 0
            },
        },
    }
end)

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

-- Hot corners module for AwesomeWM
-- Pretty much copied from github.com/manilarome/awesome-glorious-widgets/blob/master/hot-corners/init.lua

local execute_time = 0.01

local tl_callback = function()
    beautiful.useless_gap = 0
    for s in screen do s.wibar.visible = not s.wibar.visible end
    for s in screen do s.wibar.visible = not s.wibar.visible end
end

local tr_callback = function()
    beautiful.useless_gap = 10
    for s in screen do s.wibar.visible = not s.wibar.visible end
    for s in screen do s.wibar.visible = not s.wibar.visible end
end

local bl_callback = function()
    beautiful.useless_gap = 50
    for s in screen do s.wibar.visible = not s.wibar.visible end
    for s in screen do s.wibar.visible = not s.wibar.visible end
end

local br_callback = function()
    beautiful.useless_gap = 70
    for s in screen do s.wibar.visible = not s.wibar.visible end
    for s in screen do s.wibar.visible = not s.wibar.visible end
end

screen.connect_signal("request::desktop_decoration", function(s)

    gears.timer.start_new(0.1, function()

        s.corner_tl = wibox {
            x = s.geometry.x,
            y = s.geometry.y,
            visible = true,
            screen = s,
            ontop = true,
            opacity = 0.0,
            height = 1,
            width = 1,
            type = 'utility'
        }
        local tl_timer = gears.timer {
            timeout   = execute_time,
            call_now  = false,
            autostart = false,
            callback = function(self)
                tl_callback()
                self:stop()
            end
        }
        s.corner_tl:connect_signal(
            "mouse::enter",
            function()
                if tl_timer.started then
                    tl_timer:again()
                else
                    tl_timer:start()
                end
            end
        )
        s.corner_tl:connect_signal(
            "mouse::leave",
            function()
                if tl_timer.started then
                    tl_timer:stop()
                end
            end
        )

        s.corner_tr = wibox {
            x = s.geometry.x + (s.geometry.width - 1),
            y = s.geometry.y,
            visible = true,
            screen = s,
            ontop = true,
            opacity = 0.0,
            height = 1,
            width = 1,
            type = 'utility'
        }
        local tr_timer = gears.timer {
            timeout   = execute_time,
            call_now  = false,
            autostart = false,
            callback = function(self)
                tr_callback()
                self:stop()
            end
        }
        s.corner_tr:connect_signal(
            "mouse::enter",
            function()
                if tr_timer.started then
                    tr_timer:again()
                else
                    tr_timer:start()
                end
            end
        )
        s.corner_tr:connect_signal(
            "mouse::leave",
            function()
                if tr_timer.started then
                    tr_timer:stop()
                end
            end
        )

        s.corner_br = wibox {
            x = s.geometry.x + (s.geometry.width - 1),
            y = s.geometry.y + (s.geometry.height - 1),
            visible = true,
            screen = s,
            ontop = true,
            opacity = 0.0,
            height = 1,
            width = 1,
            type = 'utility'
        }
        local br_timer = gears.timer {
            timeout   = execute_time,
            call_now  = false,
            autostart = false,
            callback = function(self)
                br_callback()
                self:stop()
            end
        }
        s.corner_br:connect_signal(
            "mouse::enter",
            function()
                if br_timer.started then
                    br_timer:again()
                else
                    br_timer:start()
                end
            end
        )
        s.corner_br:connect_signal(
            "mouse::leave",
            function()
                if br_timer.started then
                    br_timer:stop()
                end
            end
        )

        s.corner_bl = wibox {
            x = s.geometry.x,
            y = s.geometry.y + (s.geometry.height - 1),
            visible = true,
            screen = s,
            ontop = true,
            opacity = 0.0,
            height = 1,
            width = 1,
            type = 'utility'
        }
        local bl_timer = gears.timer {
            timeout   = execute_time,
            call_now  = false,
            autostart = false,
            callback = function(self)
                bl_callback()
                self:stop()
            end
        }
        s.corner_bl:connect_signal(
            "mouse::enter",
            function()
                if bl_timer.started then
                    bl_timer:again()
                else
                    bl_timer:start()
                end
            end
        )
        s.corner_bl:connect_signal(
            "mouse::leave",
            function()
                if bl_timer.started then
                    bl_timer:stop()
                end
            end
        )

    end)

end)


-- A hack to always put the hot-corners on top
-- Pretty nasty code, eh?
-- Please, PR if you can improve this.
local move_to_top = function()
    focused = awful.screen.focused()

    local tl =focused.corner_tl
    local tr = focused.corner_tr
    local br = focused.corner_br
    local bl = focused.corner_bl

    tl.ontop = true
    tl.visible = false
    tl.visible = true

    tr.ontop = true
    tr.visible = false
    tr.visible = true

    br.ontop = true
    br.visible = false
    br.visible = true

    bl.ontop = true
    bl.visible = false
    bl.visible = true
end


client.connect_signal(
    "property::fullscreen",
    function(c)
        move_to_top()
    end
)
