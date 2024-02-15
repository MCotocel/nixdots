{ config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor = ,preferred,0x0,1
      monitor = eDP-1,preferred,2560x0,1
      env = XCURSOR_SIZE,24
      env = WLR_NO_HARDWARE_CURSORS,1
      exec-once = gnome-keyring-daemon -r
      exec-once = cbatticon
      exec-once = solaar -w hide -b solaar
      exec-once = emacs --daemon
      exec-once = hyprctl setcursor "Breeze_Snow" 24
      exec = pkill eww
      exec = eww daemon
      exec = eww -c ~/.config/eww open bar-internal
      exec = eww -c ~/.config/eww open bar-external
      exec-once = kmonad ~/.config/kmonad/internal.kbd
      exec = kmonad ~/.config/kmonad/external.kbd
      exec-once = swaybg -m fill -i ~/Pictures/Wallpaper/Street.jpg

      input {
          kb_layout = us
          repeat_rate = 50
          repeat_delay = 300
          follow_mouse = 0
          mouse_refocus = 0
          touchpad {
              natural_scroll = 1
          }
          sensitivity = 0
      }

      general {
          gaps_in = 3
          gaps_out = 5
          border_size = 0
          col.active_border = rgba(ccccccff)
          col.inactive_border = rgba(ccccccff)

          layout = dwindle
      }

      decoration {
          rounding = 0;
          drop_shadow = true
          shadow_ignore_window = true
          shadow_offset "0 8"
          shadow_range = 20
          shadow_render_power = 5
          col.shadow = rgba(000000cc)
      }

      animations {
          enabled = yes

          bezier = easeOutCubic, 0.33, 1, 0.68, 1

          animation = windows, 1, 2, easeOutCubic, slide
          animation = windowsOut, 1, 2, easeOutCubic, slide
          animation = fade, 1, 2, easeOutCubic
          animation = workspaces, 0, 1, easeOutCubic, slide
      }

      dwindle {
          preserve_split = yes
      }

      master {
          new_is_master = true
      }

      gestures {
          workspace_swipe = 1
          workspace_swipe_cancel_ratio = 0.3
      }

      misc {
          disable_hyprland_logo = 1
      }

      $mainMod = SUPER

      bind = $mainMod, Return, exec, alacritty
      bind = $mainMod SHIFT, Q, killactive, 
      bind = $mainMod CONTROL, space, togglefloating, 
      bind = $mainMod SHIFT, F, fullscreen, 

      bind = $mainMod, space, exec, rofi -show drun -display-drun 'App Launcher'
      bind = $mainMod SHIFT, E, exec, emacsclient -c
      bind = $mainMod SHIFT, R, exec, emacsclient -c -e '(elfeed)'
      bind = $mainMod, N, exec, emacsclient -c --eval "(progn (org-agenda-list) (split-window-right) (other-window 1) (find-file-other-window \"~/State/Vault/20231002084007-refile.org\") (split-window-below) (other-window 1) (elfeed) (enlarge-window ( - 25 (window-body-height))))"
      bind = $mainMod SHIFT, S, exec, ~/.bin/rofi-screenshot
      bind = $mainMod, escape, exec, ~/.bin/rofi-power
      bind = $mainMod, D, exec, ~/.bin/dashboard

      bind = , XF86AudioRaiseVolume, exec, pactl -- set-sink-volume @DEFAULT_SINK@ +5%
      bind = , XF86AudioLowerVolume, exec, pactl -- set-sink-volume @DEFAULT_SINK@ -5%
      bind = , XF86AudioMute, exec, amixer set Master toggle
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86MonBrightnessUp, exec, brightnessctl s 5%+
      bind = , XF86MonBrightnessDown, exec, brightnessctl s 5%-

      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d

      bind = $mainMod SHIFT, h, movewindow, l
      bind = $mainMod SHIFT, l, movewindow, r
      bind = $mainMod SHIFT, k, movewindow, u
      bind = $mainMod SHIFT, j, movewindow, d

      bind = $mainMod CONTROL, h, resizeactive, -25 0
      bind = $mainMod CONTROL, l, resizeactive, 25 0
      bind = $mainMod CONTROL, k, resizeactive, 0 -25
      bind = $mainMod CONTROL, j, resizeactive, 0 25

      bind = $mainMod, C, centerwindow

      bind = $mainMod, Tab, cyclenext
      bind = $mainMod, Tab, bringactivetotop, 
      bind = $mainMod SHIFT, Tab, exec, rofi -show window

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod, right, workspace, e+1
      bind = $mainMod, left, workspace, e-1

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bind=, mouse:275, workspace, e-1
      bind=, mouse:276, workspace, e+1
    '';
  };
}
