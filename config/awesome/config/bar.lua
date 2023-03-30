pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Declarative object management
local hotkeys_popup = require("awful.hotkeys_popup")
local bling = require("modules.bling")

awful.screen.connect_for_each_screen(function(s)

    -- Set tags and default layout
    awful.tag({"◼", "◼", "◼", "◼", "◼", "◼", "◼", "◼", "◼"}, s, awful.layout.suit.fair)

    -- Show currently used layout
    local layoutbox = awful.widget.layoutbox(s)

    local layoutbox_container = {
        layoutbox,
        left = dpi(3),
        right = dpi(3),
        bg = beautiful.bg_systray,
        widget = wibox.container.margin
    }

    local final_layoutbox = wibox.widget {
        {
            layoutbox_container,
            top = dpi(8),
            bottom = dpi(8),
            left = dpi(8),
            right = dpi(8),
            layout = wibox.container.margin
        },
        bg = beautiful.bg_systray,
        shape = gears.shape.rectangle,
        widget = wibox.container.background
    }

    layoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end)
    ))

    local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({}, 2, function(t) client.focus:move_to_tag(t) end),
        awful.button({}, 3, function(t) awful.tag.viewtoggle(t) end),
        awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end))

    local taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rectangle
        },
        layout = {
            spacing = dpi(1),
            spacing_widget = {
                color = beautiful.bg_diff,
                widget = wibox.widget.separator
            },
            layout = wibox.layout.fixed.horizontal
        },
        shape = gears.shape.rectangle,
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = 'text_role',
                                widget = wibox.widget.textbox,
                            },
                            margins = dpi(0),
                            widget = wibox.container.margin,
                        },
                        widget = wibox.container.background,
                    },
                    {
                        id = 'index_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
        },
        buttons = taglist_buttons
    }

    local taglist_container = {
        taglist,
        left = dpi(1),
        right = dpi(1),
        bg = beautiful.bg_systray,
        widget = wibox.container.margin
    }

    local final_taglist = wibox.widget {
        {
            taglist_container,
            top = dpi(1),
            bottom = dpi(1),
            left = dpi(1),
            right = dpi(1),
            layout = wibox.container.margin
        },
        bg = beautiful.bg_systray,
        shape = gears.shape.rectangle,
        widget = wibox.container.background
    }

    -- Add a nice background to the system tray

    local systray = wibox.widget.systray()
    systray:set_base_size(beautiful.systray_icon_size)

    local systray_container = {
        systray,
        left = dpi(5),
        right = dpi(5),
        top = dpi(5),
        bottom = dpi(5),
        bg = beautiful.bg_systray,
        widget = wibox.container.margin
    }

    local final_systray = wibox.widget {
        {
            systray_container,
            top = dpi(6),
            bottom = dpi(6),
            left = dpi(3),
            right = dpi(3),
            layout = wibox.container.margin
        },
        bg = beautiful.bg_systray,
        shape = gears.shape.rectangle,
        widget = wibox.container.background
    }

    -- Clock
    local clock = awful.widget.watch('bash -c "date +%H:%M"', 1)

    local clock_container = {
        clock,
        left = dpi(8),
        right = dpi(8),
        bg = beautiful.bg_systray,
        widget = wibox.container.margin
    }

    local final_clock = wibox.widget {
        {
            clock_container,
            top = dpi(6),
            bottom = dpi(6),
            left = dpi(3),
            right = dpi(3),
            layout = wibox.container.margin
        },
        bg = beautiful.bg_systray,
        shape = gears.shape.rectangle,
        widget = wibox.container.background
    }

    local clock_tooltip = awful.tooltip
    {
        objects = { clock },
        timer_function = function()
            return io.popen("bash -c \"echo -n `date '+%a, %b %d'`\""):read("*a")
        end,
        timeout = 2,
        bg = beautiful.bg_diff,
        align = "top",
        margins = dpi(10)
    }

    -- Menu
    local appmenu = {
     {"Music", function() awful.spawn.with_shell("spotify") end},
     {"Editor", function() awful.spawn.with_shell("emacsclient -c") end},
     {"Browser", function() awful.spawn.with_shell("firefox") end},
     {"Terminal", function() awful.spawn.with_shell("wezterm") end},
     {"All apps", function() awful.spawn.with_shell("sleep 0.2; rofi -show drun -display-drun 'App Launcher' -disable-history") end},
    }

    local miscmenu = {
     {"Take screenshot", function() awful.spawn.with_shell("sleep 0.2; ~/.bin/rofi-screenshot") end},
     {"Image to text", function() awful.spawn.with_shell("sleep 0.2; ~/.bin/rofi-imgtext") end},
     {"Shorten url", function() awful.spawn.with_shell("sleep 0.2; ~/.bin/rofi-urlshorten") end},
     {"View desktop", function() awful.tag.viewnone() end},
     {"Tab client", function() bling.module.tabbed.pick_with_dmenu() end},
    }

    mainmenu = awful.menu({items = {
        {"Apps", appmenu},
        {"Misc", miscmenu},
        {"File manager", function() awful.spawn.with_shell("nemo") end},
        {"Detect monitors", function() awful.spawn.with_shell("autorandr -c; echo 'awesome.restart()' | awesome-client") end},
        {"View hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
        {"Power menu", function() awful.spawn.with_shell("sleep 0.2; ~/.bin/rofi-power") end},
    }})

    local launcher = awful.widget.launcher({image = beautiful.awesome_icon, menu = mainmenu})

    local launcher_container = {
        launcher,
        left = dpi(1),
        right = dpi(1),
        bg = beautiful.bg_systray,
        widget = wibox.container.margin
    }

    local final_launcher = wibox.widget {
        {
            launcher_container,
            top = dpi(5),
            bottom = dpi(5),
            left = dpi(5),
            right = dpi(5),
            layout = wibox.container.margin
        },
        bg = beautiful.bg_systray,
        shape = gears.shape.rectangle,
        widget = wibox.container.background
    }

    -- Create the wibar
    s.wibar = awful.wibar({
        position = "bottom",
        x = dpi(0),
        y = dpi(0),
        screen = s,
        height = dpi(45),
        visible = true,
        stretch = true,
    })

    -- Add widgets
    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(final_launcher, dpi(3), dpi(3), dpi(3), dpi(3)),
        },
        {
            layout = wibox.layout.fixed.horizontal,
            {
                wibox.container.margin(final_taglist, dpi(3), dpi(3), dpi(3), dpi(3)),
                widget = wibox.container.background
            }
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(final_clock, dpi(3), dpi(3), dpi(3), dpi(3)),
            wibox.container.margin(final_systray, dpi(3), dpi(3), dpi(3), dpi(3)),
            wibox.container.margin(final_layoutbox, dpi(3), dpi(3), dpi(3), dpi(3))
        },
    }
end)
