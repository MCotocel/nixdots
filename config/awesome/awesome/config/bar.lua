pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")


-- Declarative object management
local hotkeys_popup = require("awful.hotkeys_popup")
local bling = require("bling")

bling.widget.tag_preview.enable {
    show_client_content = true,
    x = 0,
    y = 0,
    scale = 0.25,
    honor_padding = false,
    honor_workarea = false,
    placement_fn = function(c)
        awful.placement.bottom_left(c, {
            margins = {
                bottom = 30,
                left = 30
            }
        })
    end
}
bling.widget.task_preview.enable {
    x = 20,
    y = 20,
    height = 200,
    width = 200,
    placement_fn = function(c)
        awful.placement.bottom(c, {
            margins = {
                bottom = 30
            }
        })
    end
}

awful.screen.connect_for_each_screen(function(s)

    -- Set tags and default layout
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.suit.fair)

    -- Show currently used layout
    s.layoutbox = awful.widget.layoutbox(s)

    s.layoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end)
    ))


    local taglist_shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 15)
    end

    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rounded_rect
        },
        layout   = {
            spacing = 0,
            spacing_widget = {
                color = '#181e23',
                shape = gears.shape.rounded_rect,
                widget = wibox.widget.separator,
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = 'text_role',
                                widget = wibox.widget.textbox,
                            },
                            margins = 0,
                            widget = wibox.container.margin,
                        },
                        widget = wibox.container.background,
                    },
                    {
                        id     = 'index_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 7,
                right = 7,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:connect_signal('mouse::enter', function()
                    if #c3:clients() > 0 then
                        awesome.emit_signal("bling::tag_preview::update", c3)
                        awesome.emit_signal("bling::tag_preview::visibility", s, true)
                    end
    
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::tag_preview::visibility", s, false)
                    if self.has_backup then self.bg = self.backup end
                end)
            end,
            update_callback = function(self, c3, index, objects)
            end,
        },
        buttons = taglist_buttons
    }

    local tasklist_buttons = gears.table.join(
        awful.button({}, 1, function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end), awful.button({}, 3, function()
            awful.menu.client_list({theme = {width = 250}})
        end), awful.button({}, 2, function() awful.client.focus.byidx(1) end)
    )

s.tasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    layout = {
        spacing_widget = {
            {
                forced_width = 5,
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
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        {
            wibox.widget.base.make_widget(),
            forced_height = 5,
            id            = 'background_role',
            widget        = wibox.container.background,
        },
        {
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
            },
            margins = 5,
            widget  = wibox.container.margin
        },
        nil,
        create_callback = function(self, c, index, objects) --luacheck: no unused args
            self:get_children_by_id('clienticon')[1].client = c
            
            -- BLING: Toggle the popup on hover and disable it off hover
            self:connect_signal('mouse::enter', function()
                    awesome.emit_signal("bling::task_preview::visibility", s,
                                        true, c)
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::task_preview::visibility", s,
                                        false, c)
                end)
        end,
        layout = wibox.layout.align.vertical,
    },
}


--    s.tasklist = awful.widget.tasklist {
--        screen = s,
--        filter = awful.widget.tasklist.filter.currenttags,
--        buttons = tasklist_buttons,
--        layout = {
--            spacing_widget = {
--                {
--                    color = '#384149',
--                    widget = wibox.widget.separator
--                },
--                    valign = 'center',
--                    halign = 'center',
--                    widget = wibox.container.place,
--            },
--            spacing = 1,
--            layout = wibox.layout.fixed.horizontal
--        },
--        widget_template = {
--            {
--                wibox.widget.base.make_widget(),
--                id = 'background_role',
--                widget = wibox.container.background,
--            },
--            {
--                awful.widget.clienticon,
--                margins = 5,
--                widget = wibox.container.margin
--            },
--                nil,
--                layout = wibox.layout.align.horizontal,
--            },
--        }

    -- Clock
    clock = wibox.widget.textclock()

    -- Battery
    battery = awful.widget.watch('bash -c "echo `cat /sys/class/power_supply/BAT0/capacity`%"', 15) 

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
     {"Terminal", function() awful.spawn.with_shell("wezterm") end},
     {"Editor", function() awful.spawn.with_shell("emacsclient -c") end},
     {"Browser", function() awful.spawn.with_shell("firefox") end},
     {"Music", function() awful.spawn.with_shell("spotify") end},
     {"File manager", function() awful.spawn.with_shell("thunar") end},
    }

    scriptmenu = {
     {"Take screenshot", function() awful.spawn.with_shell("~/.bin/rofi-screenshot") end},
     {"Image to text", function() awful.spawn.with_shell("~/.bin/rofi-imgtext") end},
     {"Shorten url", function() awful.spawn.with_shell("~/.bin/rofi-urlshorten") end},
    }

    mainmenu = awful.menu({items = {
        {"AwesomeWM", awesomemenu, beautiful.awesome_icon},
        {"Scripts", scriptmenu, beautiful.terminal},
        {"Apps", appmenu, beautiful.app},
    }})

    launcher = awful.widget.launcher({image = beautiful.ghost, menu = mainmenu})

    -- Create the top bar
    s.wibar = awful.wibar({
        position = "bottom",
        x = 0,
        y = 0,
        screen = s,
        height = 35,
        visible = true,
        stretch = true,
        bg = "#181e23",
    })

    -- Add widgets
    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            launcher,
            s.taglist,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            {
                s.tasklist,
                widget = wibox.container.background
            }
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.layout.margin(wibox.widget.systray(), 7, 7, 10, 10),
            wibox.layout.margin(battery, 7, 7, 7, 7),
            wibox.layout.margin(s.layoutbox, 7, 7, 7, 7),
        },
    }
end)
