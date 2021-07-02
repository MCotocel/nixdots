-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init("/home/matei/.config/awesome/quiet/theme.lua")

-- Keybindings
require("keys")
root.keys(globalkeys)

-- Menu bar
require("bar")

-- UI
require("ui")

-- Extras
require("extras")

require("corners")

-- Bling bling
local bling = require("bling")

-- Layouts
local machi = require("layout-machi")

-- Expose for AwesomeWM
local revelation = require("awesome-revelation")
revelation.init()

-- Default terminal and editor
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Autostart apps
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
