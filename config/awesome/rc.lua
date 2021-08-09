pcall(require, "luarocks.loader")

local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

local bling = require("bling")
local gears = require("gears")
local gfs = require("gears.filesystem")
local machi = require("layout-machi")
local naughty = require('naughty')

local beautiful = require("beautiful")
beautiful.init(gfs.get_configuration_dir() .. "quiet/theme.lua")

local revelation = require("awesome-revelation")
revelation.charorder = "1234567890qwertyuiopasdfghjklzxcvbnm"

local wibox = require("wibox")

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
  x = 341.5,
  y = 192,
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

-- Left
awful.key({modkey}, "h", function() awful.client.focus.bydirection("left") end, {
    description = "Focus left",
    group = "Windows"
}),

-- Down
awful.key({modkey}, "j", function() awful.client.focus.bydirection("down") end, {
    description = "Focus down",
    group = "Windows"
}),

-- Up
awful.key({modkey}, "k", function() awful.client.focus.bydirection("up") end, {
    description = "Focus up",
    group = "Windows"
}),

-- Right
awful.key({modkey}, "l", function() awful.client.focus.bydirection("right") end, {
    description = "Focus right",
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
}),

-- Volume up
awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer set Master 10%+") end, {
    description = "Volume up",
    group = "Applications and menus"
}),

-- Volume down
awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer set Master 10%-") end, {  
    description = "Volume down",
    group = "Applications and menus"
}),

-- Toggle mute
awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer set Master toggle") end, {
    description = "Toggle mute",
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

root.keys(globalkeys)

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

    s.tasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing_widget = {
                {
                    forced_width  = 5,
                    forced_height = 24,
                    thickness = 1,
                    color = '#777777',
                    widget = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 1,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 5,
                id = 'background_role',
                widget = wibox.container.background,
            },
            {
                {
                    id = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 5,
                widget = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects)
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical,
            },
    }

    -- Prompt
    s.promptbox = awful.widget.prompt()

    -- Clock
    clock = wibox.widget.textclock()

    -- Battery
    battery = awful.widget.watch('bash -c "echo Battery: `cat /sys/class/power_supply/BAT0/capacity`%"', 15) 

    local battery_tooltip = awful.tooltip
    {
        objects        = { battery },
        timer_function = function()
            return io.popen("bash -c \"echo -n Status: `cat /sys/class/power_supply/BAT0/status`\""):read("*a")
        end,
        timeout=0,
        bg="#1f252a",
        align="top_left",
        margins="5"
    }

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
        bg = "#181e23",
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
            spacing = 5,
            clock,
            wibox.layout.margin(battery, 0, 7, 0, 0),
            wibox.layout.margin(wibox.widget.systray(), 0, 7, 7, 7),
            wibox.layout.margin(s.layoutbox, 0, 0, 7, 7),
            wibox.widget {
                widget = wibox.widget.separator,
                forced_width = 1,
                opacity = 0
            },
        },
    }
end)

-- Notifications
naughty.config.defaults.margin = beautiful.notification_margin
naughty.config.defaults.border_width = beautiful.notification_border_width

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

local titlebar = awful.titlebar(c, {position = 'top', height = '40'})

titlebar:setup{
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
            left = 10,
            right = 10,
            top = 3,
            bottom = 3
}

-- Titlebar only if floating
client.connect_signal("property::floating", function(c)
    if c.floating then awful.titlebar.show(c) else awful.titlebar.hide(c) end
end)

-- Corners
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h, r) gears.shape.rounded_rect(cr, w, h, 15) end
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
    bling.module.tiled_wallpaper("", s, {
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
bling.module.flash_focus.enable()

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
        left = 10,
        right = 10,
        top = 3,
        bottom = 3
    }
end)

-- Titlebar only if floating
client.connect_signal("property::floating", function(c)
    if c.floating then awful.titlebar.show(c) else awful.titlebar.hide(c) end
end)

-- Corners
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h, r) gears.shape.rounded_rect(cr, w, h, 15) end
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
    bling.module.tiled_wallpaper("", s, {
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
bling.module.flash_focus.enable()
