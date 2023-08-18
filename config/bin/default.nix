{ config, ... }:

{
  home.file.".bin/lock".text = ''
      gtklock -s ~/.config/gtklock.css
  '';
  home.file.".bin/lock".executable = true;
  home.file.".bin/rofi-power".text = ''
      res=$(echo -en "Reload|Lock|Suspend|Logout|Shutdown|Reboot" | rofi -sep "|" -dmenu -i -p 'Power Options' -theme-str 'window { height: 25%; width: 15%;}') # Make selection prompt
      
      if [ $res = "Reload" ]; then
      
          ~/.bin/sys-notify 'Reloading config' low
          hyprctl reload
      
      elif [ $res = "Lock" ]; then
      
          ~/.bin/sys-notify 'Locking screen' low
          ~/.bin/lock &
      
      elif [ $res = "Suspend" ]; then
      
          ~/.bin/sys-notify 'Suspending' low
          systemctl suspend
      
      elif [ $res = "Logout" ]; then
      
          ~/.bin/sys-notify 'Logging out' low
          sleep 1
          pkill -KILL -u $(whoami)
      
      elif [ $res = "Shutdown" ]; then # If selection is shutdown
      
          ~/.bin/sys-notify 'Shutting down' low
          sleep 1
          shutdown -h now
      
      elif [ $res = "Reboot" ]; then
      
          ~/.bin/sys-notify 'Rebooting' low
          sleep 1
          reboot
      
      fi
  '';
  home.file.".bin/rofi-power".executable = true;
  home.file.".bin/rofi-imgtext".text = ''
      sel=$(echo "Screen|Selection" | rofi -sep "|" -dmenu -i -p 'Image to text' -theme-str 'window { height: 10%; width: 10%;}')
      
      if [[ $sel = "Screen" ]]; then
      
          maim ~/Pictures/Screenshots/imgtext.png;
          tesseract ~/Pictures/Screenshots/imgtext.png ~/imgtext;
          xclip -sel c < ~/imgtext.txt;
          notify-send "Image to text" "Saved text to clipboard" -i ~/Pictures/Screenshots/imgtext.png
          rm ~/imgtext.txt ~/Pictures/Screenshots/imgtext.png
      
      fi
      
      if [[ $sel = "Selection" ]]; then
      
          maim -s ~/Pictures/Screenshots/imgtext.png;
          tesseract ~/Pictures/Screenshots/imgtext.png ~/imgtext -l eng;
          xclip -sel c < ~/imgtext.txt;
          notify-send "Image to text" "Saved text to clipboard" -i ~/Pictures/Screenshots/imgtext.png
          rm ~/imgtext.txt ~/Pictures/Screenshots/imgtext.png
      
      fi
      
      exit 0
  '';
  home.file.".bin/rofi-imgtext".executable = true;
  home.file.".bin/rofi-screenshot".text = ''
      sel=$(echo "Screen|Sel. copy|Sel. save" | rofi -sep "|" -dmenu -i -p 'Screenshot' -theme-str 'window { height: 15%; width: 15%;}')
       
      if [[ $sel = "Screen" ]]; then
      
          sleep 0.5
          grimshot save output
          
      elif [[ $sel = "Sel. copy" ]]; then # If selection is selection
      
          sleep 0.5
          grimshot copy area
      
      elif [[ $sel = "Sel. save" ]]; then # If selection is selection
      
          sleep 0.5
          grimshot save area
      
      fi
      
      exit 0
  '';
  home.file.".bin/rofi-screenshot".executable = true;
  home.file.".bin/sys-notify".text = ''
      function main() {
        notify-send -a 'System Notification' "$\{1}" -u "$\{2}"
      }
      
      main "$\{@}"
  '';
  home.file.".bin/sys-notify".executable = true;
  home.file.".bin/nas".text = ''
      if ! type "doas" > /dev/null 2>&1 ; then
        priv="sudo"
      else
        priv="doas"
      fi
      
      function help() {
          cat <<EOF
      Usage: nas [OPTION] [OPTION]
      
      Options:
          help         show this text
      
          clean        clean and garabge collect store
          rebuild      rebuild configuration for host
          sync         pull config from git repo, then commit and push
          update       update flake
      EOF
      }
      
      function sync() {
        echo "Syncing nix config"
        cd ~/nixdots || exit
        git pull
        git add .
        git diff --cached
        git commit
        git push
      }
      
      function rebuild() {
        echo "Rebuilding config"
        $priv nixos-rebuild --flake ~/nixdots --impure switch
      }
      
      function update() {
        echo "Updating flake"
        $priv nix flake update ~/nixdots
      }
      
      function clean() {
        echo "Clearing store"
        $priv nix-store --gc
        echo "Removing old generations"
        $priv nix-env --delete-generations old
        echo "Collecting system garbage"
        $priv nix-collect-garbage -d
        echo "Collecting user garbage"
        nix-collect-garbage -d
      }
      
      case "$1" in
        sync)    sync ;;
        rebuild) rebuild ;;
        update)  update ;;
        clean)   clean ;;
        \'\')    help ;;
        help)    help ;;
        *)       help ;;
      esac
  '';
  home.file.".bin/nas".executable = true;
}
