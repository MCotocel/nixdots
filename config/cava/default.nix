{ config, ... }:

{
  home.file.".config/cava/config".text = ''
      [general]
      
      autosens = 1
      sensitivity = 30
      
      bars = 0
      bar_width = 0
      bar_spacing = 0
      
      [input]
      
      method = pulse
      source = auto
      
      [output]
      
      method = ncurses
      channels = stereo
      
      [smoothing]
      
      integral = 90
      monstercat = 1
      gravity = 150
      
      [color]
      gradient = 1
      gradient_count = 2
      gradient_color_1 = '#ace1ff'
      gradient_color_2 = '#ffffff'
      
      [eq]
      
      1 = 1 # bass
      3 = 1 # midtone
      5 = 1 # treble
  '';
}
