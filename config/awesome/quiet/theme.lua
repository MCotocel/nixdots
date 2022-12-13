local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi

-- Fonts
theme.font = "Iosevka Nerd Font 11"

-- Bar
theme.wibar_border_width = dpi(5)
theme.wibar_border_color = "#181e23"
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
theme.taglist_squares_sel_empty = nil
theme.taglist_squares_unsel_empty = nil

-- Backgrounds
theme.bg_normal = "#181e23"
theme.bg_focus = "#181e23"
theme.bg_urgent = "#181e23"
theme.bg_minimize = "#181e23"
theme.bg_systray = "#1f252a"
theme.bg_diff = "#1f252a"

-- Foregrounds
theme.fg_normal = "#D5D5D5"
theme.fg_focus = "#80d1ff"
theme.fg_urgent = "#ff8080"
theme.fg_minimize = "#C780FF"

-- Gap and borders
theme.useless_gap = dpi(10)
theme.gap_single_client = true
theme.border_width = dpi(4)
theme.border_color_normal = "#1f252a"
theme.border_color_active = "#1f252a"
theme.border_color_marked = "#80d1ff"

-- Taglist
theme.taglist_bg = "#1f252a"
theme.taglist_bg_focus = "#1f252a"
theme.taglist_bg_empty = "#1f252a"
theme.taglist_bg_occupied = "#1f252a"
theme.taglist_bg_urgent = "#1f252a"
theme.taglist_fg = "#80d1ff"
theme.taglist_fg_empty = "#1f252a"
theme.taglist_fg_occupied = "#97D59B"

-- Tasklist
theme.tasklist_bg_normal = "#181e23"
theme.tasklist_align = "center"
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true

-- Titlebar
theme.titlebar_bg_focus = "#181e23"
theme.titlebar_bg_normal = "#181e23"

theme.titlebar_fg_focus = "#d5d5d5"
theme.titlebar_fg_normal = "#d5d5d5"

theme.titlebar_close_button_normal = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_close_button_focus  = gfs.get_configuration_dir() .. "quiet/titlebar/close.png"

theme.titlebar_minimize_button_normal = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_minimize_button_focus  = gfs.get_configuration_dir() .. "quiet/titlebar/minimize.png"

theme.titlebar_ontop_button_normal_inactive = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_ontop_button_focus_inactive  = gfs.get_configuration_dir() .. "quiet/titlebar/ontop.png"
theme.titlebar_ontop_button_normal_active = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_ontop_button_focus_active  = gfs.get_configuration_dir() .. "quiet/titlebar/ontop.png"

theme.titlebar_sticky_button_normal_inactive = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_sticky_button_focus_inactive  = gfs.get_configuration_dir() .. "quiet/titlebar/sticky.png"
theme.titlebar_sticky_button_normal_active = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_sticky_button_focus_active  = gfs.get_configuration_dir() .. "quiet/titlebar/sticky.png"

theme.titlebar_floating_button_normal_inactive = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_floating_button_focus_inactive  = gfs.get_configuration_dir() .. "quiet/titlebar/floating.png"
theme.titlebar_floating_button_normal_active = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_floating_button_focus_active  = gfs.get_configuration_dir() .. "quiet/titlebar/floating.png"

theme.titlebar_maximized_button_normal_inactive = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_maximized_button_focus_inactive  = gfs.get_configuration_dir() .. "quiet/titlebar/maximize.png"
theme.titlebar_maximized_button_normal_active = gfs.get_configuration_dir() .. "quiet/titlebar/inactive.png"
theme.titlebar_maximized_button_focus_active  = gfs.get_configuration_dir() .. "quiet/titlebar/maximize.png"

-- Edge snap
theme.snap_bg = "#1f252acc"
theme.snap_border_width = dpi(10000)
theme.snap_shape = gears.shape.rectangle

-- Icon theme
theme.icon_theme = "Papirus-Dark"

-- Menu
theme.menu_height = dpi(30)
theme.menu_width = dpi(200)
theme.menu_font = "Iosevka 11"
theme.menu_bg_focus = "#1f252a"
theme.menu_submenu = "    "
theme.menu_submenu_icon = nil

theme.ghost = "~/.config/awesome/icons/pfp_trans.png"
theme.pfp = "~/.config/awesome/icons/pfp.png"
theme.awesome_icon = "~/.config/awesome/icons/awesome.svg"

-- Bling
theme.tabbed_spawn_in_tab = true
theme.tabbar_ontop = true
theme.tabbar_style = "boxes"
theme.tabbar_position = "bottom"
theme.tabbar_size = dpi(40)
theme.tabbar_radius = dpi(0)
theme.mstab_bar_padding = dpi(0)
theme.tabbar_bg_focus = "#1f252a"
theme.tabbar_bg_normal = "#181e23"
theme.tabbar_color_close = "#181e23"
theme.tabbar_color_min = "#181e23"
theme.tabbar_color_float = "#181e23"

theme.flash_focus_start_opacity = 0.6
theme.flash_focus_step = 0.01

theme.tag_preview_widget_border_radius = 0
theme.tag_preview_client_border_radius = 0
theme.tag_preview_client_border_width = 0
theme.tag_preview_widget_border_width = 0
theme.tag_preview_client_opacity = 1
theme.tag_preview_widget_margin = 0
theme.tag_preview_client_bg = "#181e23"
theme.tag_preview_widget_bg = "#1f252a"

theme.task_preview_widget_border_radius = 0
theme.task_preview_widget_bg = "#181e23"
theme.task_preview_widget_border_color = "#181e23"
theme.task_preview_widget_border_width = 0
theme.task_preview_widget_margin = dpi(5)

theme.window_switcher_widget_bg = "#1f252a"
theme.window_switcher_widget_border_width = 5
theme.window_switcher_widget_border_radius = 0
theme.window_switcher_widget_border_color = "#181e23"
theme.window_switcher_name_normal_color = "#8b8b8b"
theme.window_switcher_name_focus_color = "#ffffff"
theme.window_switcher_clients_spacing = 15 -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 150 -- The width of one client widget
theme.window_switcher_client_height = 250 -- The height of one client widget
theme.window_switcher_client_margins = 20 -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10 -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10 -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center" -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200 -- The width of one title
theme.window_switcher_name_font = "Iosevka 11" -- The font of all titles
theme.window_switcher_icon_valign = "center" -- How to vertially align the one icon
theme.window_switcher_icon_width = 40 -- Thw width of one icon

-- Hotkey popup

theme.hotkeys_font = "Iosevka 11"
theme.hotkeys_description_font = "Iosevka 9"
theme.hotkeys_modifiers_fg = "#80D1FF"
theme.hotkeys_border_width = 0
theme.hotkeys_group_margin = dpi(10)

-- Notifications

local global_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 0)
end

theme.notification_font = "Iosevka 11"
theme.notification_bg = "#181e23"
theme.notification_fg = "#D5D5D5"
theme.notification_shape = global_shape
theme.notification_spacing = dpi(10)
theme.notification_margin = dpi(15)
theme.notification_border_width = dpi(3)
theme.notification_border_color = "#1f252a"
theme.notification_max_width = dpi(300)
theme.notification_max_height = dpi(200)
theme.notification_icon_size = dpi(100)
naughty.config.defaults.padding = dpi(70)
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = theme.notification_margin
naughty.config.defaults.border_width = theme.notification_border_width
naughty.config.presets.critical.bg = '#181e23'
naughty.config.presets.critical.fg = '#ff8080'

theme.systray_icon_spacing = dpi(5)

return theme
