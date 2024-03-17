{ config, ... }:

{
  home.file.".config/eww/eww.scss".text = ''
      // Colours
      $background: #000000;
      $foreground: #d5d5d5;
      
      $black: #000000;
      $gray: #565F89;
      $red: #FF8080;
      $green: #97D59B;
      $yellow: #FFFE80;
      $blue: #ACE1FF;
      $magenta: #C780FF;
      $cyan: #80FFE4;
      $white: $foreground;
      
      * {
          background-color: unset;
          font-family: "Iosevka Nerd Font";
      }
      
      .eww_bar {
          background-color: $background;
          padding: 1em;
          border-right: 0.3em solid #182528;
      }
      
      .power_icon {
          color: $red;
          font-size: 2.5em;
          margin-right: 3px;
      }

      .workspace-entry.occupied {
      	color: #97D59B
      }
      
      .workspace-entry.current {
      	color: #ACE1FF
      }
      
      .control {
          font-family: Iosevka Nerd Font;
          font-size: 1.5em;
          background-color: $black;
          border-radius: 5px;
      }
      
      .top {
          font-family: Iosevka Nerd Font;
          background-color: $black;
          border-radius: 5px;
      }
      
      .middle {
          font-family: Iosevka Nerd Font;
          font-size: 2em;
          background-color: $black;
          border-radius: 5px;
      }
      
      .lay {
          font-family: Iosevka Nerd Font;
          font-size: 1.5em;
          margin-right: 8px;
          margin-top: 5px;
          color: $red;
      }
      
      .bat {
          font-family: Iosevka Nerd Font;
          font-size: 1.5em;
          margin-left: 2px;
          margin-bottom: 2px;
          color: $blue;
      }
      
      .time {
          font-family: Iosevka Nerd Font;
          font-weight: bold;
          font-size: 1.5em;
          background-color: $black;
          color: $white;
          border-radius: 5px;
          padding: 0.2em 0 0.2em 0;
      }
      
      .powermenu {
        font-family: Iosevka Nerd Font;
        font-size: 1.4em;
        font-weight: bold;
      }
  '';
  home.file.".config/eww/eww.yuck".text = ''
      ;; Power menu widget ;;
      (defwidget power []
        (box :orientation "v" 
             (button :class "power_icon" :onclick "~/.bin/rofi-power; sleep 0.2"  "󰐥")))
      
      ;; Workspace widget ;;
      (deflisten workspaces :initial "[]" "bash ./scripts/get-workspaces")
      (deflisten current_workspace :initial "1" "bash ./scripts/get-active-workspace")
      (defwidget workspaces []
        (eventbox :onscroll "bash ./scripts/change-active-workspace {} ''${current_workspace}" :class "workspaces-widget"
                  (box :orientation "v"
                       (label :text "''${workspaces}''${current_workspace}" :visible false)
                       (for workspace in workspaces
                            (eventbox :onclick "hyprctl dispatch workspace ''${workspace.id}"
                                      (box :class "workspace-entry ''${workspace.id == current_workspace ? "current" : ""} ''${workspace.windows > 0 ? "occupied" : "empty"}"
                                           (label :text "")))))))
      
      ;; Layer widget ;;
      (defwidget lay []
        (box :orientation "v"	
      	   (label :class "lay" :text layer)))
      (defpoll layer :interval "0.2s" "scripts/layer")
      
      ;; Battery widget ;;
      (defwidget bat []
        (box :orientation "v"	
      	   (label :class "bat" :text battery)))
      (defpoll battery :interval "1s" "scripts/battery")
      
      ;; Control panel widgets ;;	
      (defwidget control []
        (box :orientation "v" :space-evenly false :class "control"
             (lay)
             (bat)))
      
      ;; Clock widget ;;
      (defwidget time []
        (box :orientation "v" :class "time" :valign "end"
      	   (button :class "time-hour" hour)
      	   (button :class "time-min"  min)))
      (defpoll hour :interval "1s" "date '+%H'")
      (defpoll min :interval "1s" "date '+%M'")
      
      ;; Top widgets ;;
      (defwidget top []
        (box :orientation "v" :valign "start" :class "top"
             (power)))
      
      ;; Middle widgets ;;
      (defwidget middle []
        (box :orientation "v" :valign "center" :class "middle"
             (workspaces)))
      
      ;; End widgets ;;
      (defwidget end []
        (box :orientation "v" :space-evenly "false" :valign "end" :spacing 5
             (control)
             (time)))
      
      ;; Bar widgets ;;
      (defwidget bar []
        (box :class "eww_bar" :orientation "v" :vexpand "false" :hexpand "false"
             (top)
             (middle)
             (end)))
      
      ;; Bar windows ;;
      (defwindow bar-internal
      	:geometry (geometry :x "0":y "0" :anchor "center left" :height "100%" :width "30px")
      	:monitor 0
          :exclusive true
          :stacking "fg"
          (bar))
      
      (defwindow bar-external
      	:geometry (geometry :x "0" :y "0" :anchor "center left" :height "100%" :width "30px")
      	:monitor 1
          :exclusive true
          :stacking "fg"
          (bar))

      (defwindow bar-secondary
      	:geometry (geometry :x "0" :y "0" :anchor "center left" :height "100%" :width "30px")
      	:monitor 2
          :exclusive true
          :stacking "fg"
          (bar))
  '';
  home.file.".config/eww/scripts/battery".text = ''
      bat=/sys/class/power_supply/BAT0/
      per="$(cat "$bat/capacity")"
      
      [ $(cat "$bat/status") = Charging ] && echo "󰂄" && exit
      
      if [ "$per" -gt "80" ]; then
      	icon="󰁹"
      elif [ "$per" -gt "50" ]; then
      	icon="󰁾"
      elif [ "$per" -gt "30" ]; then
      	icon="󰁼"
      elif [ "$per" -gt "0" ]; then
      	icon="󰁺"
      fi
      echo "$icon"
  '';
  home.file.".config/eww/scripts/battery".executable = true;
  home.file.".config/eww/scripts/change-active-workspace".text = ''
      function clamp {
      	min=$1
      	max=$2
      	val=$3
      	python -c "print(max($min, min($val, $max)))"
      }
      
      direction=$1
      current=$2
      if test "$direction" = "down"
      then
      	target=$(clamp 1 10 $(($current+1)))
      	echo "jumping to $target"
      	hyprctl dispatch workspace $target
      elif test "$direction" = "up"
      then
      	target=$(clamp 1 10 $(($current-1)))
      	echo "jumping to $target"
      	hyprctl dispatch workspace $target
      fi
  '';
  home.file.".config/eww/scripts/change-active-workspace".executable = true;
  home.file.".config/eww/scripts/get-active-workspace".text = ''
      hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'
      
      socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'
  '';
  home.file.".config/eww/scripts/get-active-workspace".executable = true;
  home.file.".config/eww/scripts/get-workspaces".text = ''
      spaces (){
      	WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
      	seq 1 10 | jq --argjson windows "''${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
      }
      
      spaces
      socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
      	spaces
      done
  '';
  home.file.".config/eww/scripts/get-workspaces".executable = true;
  home.file.".config/eww/scripts/layer".text = ''
      layer="$(tail -n 1 ~/.config/kmonad/log)"
      
      if [ "$layer" == "qwe" ]; then
      	icon="󰌌"
      elif [ "$layer" == "fun" ]; then
          icon="󱊶"
      elif [ "$layer" == "mrk" ]; then
          icon=""
      fi
      echo "$icon"
  '';
  home.file.".config/eww/scripts/layer".executable = true;
}
