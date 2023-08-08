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
      exec-once = swaybg -i ~/Pictures/Wallpaper/Rainy\ Street.jpg
      exec-once = eww -c ~/.config/eww open bar-internal
      exec = eww -c ~/.config/eww open bar-external
      exec-once = kmonad ~/.config/kmonad/internal.kbd
      exec = kmonad ~/.config/kmonad/external.kbd

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
          gaps_in = 5
          gaps_out = 20
          border_size = 0
          col.active_border = rgba(ace1ffff)
          col.inactive_border = rgba(181e23ff)

          layout = dwindle
      }

      decoration {
          rounding = 5;
          multisample_edges = true;
          blur = false
          drop_shadow = true
          shadow_ignore_window = true
          shadow_offset "0 8"
          shadow_range = 20
          shadow_render_power = 3
          col.shadow = rgba(000000cc)
      }

      animations {
          enabled = yes

          bezier = easeOutCubic, 0.33, 1, 0.68, 1

          animation = windows, 1, 2, easeOutCubic, slide
          animation = windowsOut, 1, 2, easeOutCubic, slide
          animation = fade, 1, 2, easeOutCubic
          animation = workspaces, 1, 1, easeOutCubic, slide
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

      bind = $mainMod, Return, exec, wezterm
      bind = $mainMod SHIFT, Q, killactive, 
      bind = $mainMod CONTROL, space, togglefloating, 
      bind = $mainMod SHIFT, F, fullscreen, 

      bind = $mainMod, space, exec, rofi -show drun -display-drun 'App Launcher' -disable-history
      bind = $mainMod SHIFT, E, exec, emacsclient -c
      bind = $mainMod SHIFT, S, exec, ~/.bin/rofi-screenshot
      bind = $mainMod, escape, exec, ~/.bin/rofi-power
      bind = CONTROL SHIFT, escape, exec, lxtask

      bind = , XF86AudioRaiseVolume, exec, pactl -- set-sink-volume @DEFAULT_SINK@ +5%
      bind = , XF86AudioLowerVolume, exec, pactl -- set-sink-volume @DEFAULT_SINK@ -5%
      bind = , XF86AudioMute, exec, amixer set Master toggle
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86MonBrightnessUp, exec, brightnessctl s 2%+
      bind = , XF86MonBrightnessDown, exec, brightnessctl s 2%-

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
