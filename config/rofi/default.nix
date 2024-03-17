{
  home.file.".config/rofi/config.rasi".text = ''
    @theme "./Quiet.rasi"
    configuration {
        icon-theme: "Papirus";
        modi: "drun,run,keys";
        drun {
            parse-system: false;
        }
    }
  '';
  home.file.".config/rofi/Quiet.rasi".text = ''
      * {
        ac: #cccccc;
        bg: #000000;
        fg: #d5d5d5;
        bd: #182528;
        background-color: @bg;
      }

      window {
        padding: 20px;
        width: 30%;
        height: 40%;
        border: 0.2em;
        border-color: @bd;
      }

      prompt { text-color: @fg; }

      textbox-prompt-colon {
        expand: false;
        str: " - ";
        text-color: inherit;
      }

      entry {
        spacing: 0;
        text-color: @fg;
      }

      inputbar {
        text-color: @fg;
        children: [ prompt, textbox-prompt-colon, entry ];
      }

      listview {
        padding: 5px 5px 5px 5px;
        columns: 3;
      }

      element {
        border: 0px;
        border-radius: 0px;
        padding: 5px;
        text-color: @fg;
        background-color: @bg;
        children: [ element-icon, element-text ];
        spacing: 10px;
      }

      element selected {
        background-color: @fg;
        text-color: @bg;
      }

      element-icon { size: 1em; }

      element-text, element-icon {
        background-color: inherit;
        text-color: inherit;
      }
    '';
}
