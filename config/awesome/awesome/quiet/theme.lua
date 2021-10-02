local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")
local naughty = require("naughty")
local ruled = require("ruled")

-- Fonts

theme.font = "Iosevka Nerd Font 11"

-- Bar
theme.wibar_border_width = 0
theme.wibar_border_color = "#384149"
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
theme.taglist_squares_sel_empty = nil
theme.taglist_squares_unsel_empty = nil

-- Backgrounds

theme.bg_normal = "#181e23"
theme.bg_focus = "#181e23"
theme.bg_urgent = "#181e23"
theme.bg_minimize = "#181e23"
theme.bg_systray = "#181e23"

-- Foregrounds

theme.fg_normal = "#D5D5D5"
theme.fg_focus = "#80D1FF"
theme.fg_urgent = "#ff8080"
theme.fg_minimize = "#C780FF"

-- Gap and borders

theme.useless_gap = 15
theme.gap_single_client = true
theme.border_width = 0
theme.border_color_normal = "#1f252a"
theme.border_color_active = "#384149"
theme.border_color_marked = "#80d1ff"

-- Taglist
theme.taglist_bg = "#181e23"
theme.taglist_bg_focus = "#1f252a"
theme.taglist_bg_empty = "#181e23"
theme.taglist_bg_occupied = "#181e23"
theme.taglist_fg = "#80D1FF"
theme.taglist_fg_empty = "#D5D5D5"
theme.taglist_fg_occupied = "#97D59B"

-- Tasklist

theme.tasklist_bg_normal = "#181e23"
theme.tasklist_align = "center"
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true

-- Titlebar

theme.titlebar_bg_focus = "#1f252a"
theme.titlebar_bg_normal = "#1f252a"

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

theme.snap_bg = "#181e23"
theme.snap_border_width = "5"

-- Icon theme

theme.icon_theme = "Papirus"

-- Menu
theme.menu_height = "25"
theme.menu_width = "200"
theme.menu_submenu = ""
theme.menu_submenu_icon = nil

theme.ghost = "~/.config/awesome/icons/pfp_trans.png"
theme.awesome_icon = "~/.config/awesome/icons/awesome.png"
theme.app = "~/.config/awesome/icons/app.png"
theme.terminal = "~/.config/awesome/icons/terminal.png"

-- Bling
theme.tabbed_spawn_in_tab = true
theme.tabbar_ontop = true
theme.tabbar_style = "boxes"
theme.tabbar_position = "top"
theme.tabbar_size = 40
theme.tabbar_radius = 15
theme.mstab_bar_padding = 0
theme.tabbar_bg_focus = "#181e23"
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
theme.tag_preview_widget_bg = "#384149"

theme.task_preview_widget_border_radius = 0
theme.task_preview_widget_bg = "#181e23"
theme.task_preview_widget_border_color = "#181e23"
theme.task_preview_widget_border_width = 0
theme.task_preview_widget_margin = 5

-- Hotkey popup

theme.hotkeys_font = "Iosevka 11"
theme.hotkeys_description_font = "Iosevka 9"
theme.hotkeys_modifiers_fg = "#80D1FF"
theme.hotkeys_border_width = 0
theme.hotkeys_group_margin = 20

-- Notifications

local notif_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 0)
end

theme.notification_font = "Iosevka 11"
theme.notification_bg = "#181e23"
theme.notification_fg = "#D5D5D5"
theme.notification_shape = notif_shape
theme.notification_spacing = 10
theme.notification_margin = 15
theme.notification_border_width = 3
theme.notification_border_color = "#384149"
theme.notification_max_width = 300
theme.notification_max_height = 200
theme.notification_icon_size = 100
naughty.config.defaults.padding = 70
naughty.config.defaults.position = "bottom_left"
naughty.config.defaults.margin = theme.notification_margin
naughty.config.defaults.border_width = theme.notification_border_width
naughty.config.presets.critical.bg = '#181e23'
naughty.config.presets.critical.fg = '#ff8080'

return theme
