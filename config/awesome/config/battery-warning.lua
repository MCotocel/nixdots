local naughty = require("naughty")

local function trim(s)
  return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function bat_notification()

  local f_capacity = assert(io.open("/sys/class/power_supply/BAT0/capacity", "r"))
  local f_status = assert(io.open("/sys/class/power_supply/BAT0/status", "r"))

  local bat_capacity = tonumber(f_capacity:read("*all"))
  local bat_status = trim(f_status:read("*all"))

  if (bat_capacity <= 20 and bat_status == "Discharging") then
     naughty.notify({ title = "Battery Warning",
      text = "Battery low! " .. bat_capacity .."%" .. " left!",
      fg="#ff8080",
      bg="#0b1116",
      timeout = 0
    })
  end
end

local battimer = timer({timeout = 60})
battimer:connect_signal("timeout", bat_notification)
battimer:start()
