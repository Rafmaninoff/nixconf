{ pkgs, config, lib, ... }:

let
  startScript = pkgs.writeShellScriptBin "start" ''

'';
in
{

  imports = [ ./waybar.nix ];

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard

    eww-wayland
    swww

    networkmanagerapplet

    rofi-wayland
    wofi

    wdisplays

    #    (pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlages = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))
  ];

  wayland.windowManager.hyprland = {
    enable = true;


    settings = {
      general = {
        layout = "master";
      };

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "${pkgs.bash}/bin/bash ${startScript}/bin/start"
        "waybar"
      ];

      input = {
        follow_mouse = 1;

        touchpad.natural_scroll = false;

        repeat_rate = 40;
        repeat_delay = 500;
        force_no_accel = true;

        sensitivity = 0.0;

      };

      misc = {
        enable_swallow = true;
        force_default_wallpaper = 0;
      };

      decoration = {
        rounding = 5;

        drop_shadow = true;
        shadow_range = 30;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.25, 0.9, 0.1, 1.02";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1,7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 3, myBezier, fade"
        ];
      };

      "$mod" = "SUPER";

      bind =
        [
          "$mod, return, exec, kitty"
          "$mod SHIFT, Q, killactive,"
          "$mod SHIFT, M, exit,"
          "$mod SHIFT, F, togglefloating,"
          "$mod, F, fullscreen,"
          "$mod, G, togglegroup,"
          "$mod, bracketleft, changegroupactive, b"
          "$mod, bracketright, changegroupactive, f"
          "$mod, O, exec, wofi --show drun"
          "$mod, S, exec, rofi -show drun -show-icons"
          "$mod, P, pin, active"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, l, movewindow, r"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, j, movewindow, d"

          # Scroll through existing workspaces with mod + scroll
          "bind = $mod, mouse_down, workspace, e+1"
          "bind = $mod, mouse_up, workspace, e-1"
        ]
        ++ map
          (n: "$mod SHIFT, ${toString n}, movetoworkspace, ${toString (
            if n == 0
            then 10
            else n
          )}") [ 1 2 3 4 5 6 7 8 9 0 ]
        ++ map
          (n: "$mod, ${toString n}, workspace, ${toString (
            if n == 0
            then 10
            else n
          )}") [ 1 2 3 4 5 6 7 8 9 0 ];

      binde = [
        "$mod SHIFT, h, moveactive, -20 0"
        "$mod SHIFT, l, moveactive, 20 0"
        "$mod SHIFT, k, moveactive, 0 -20"
        "$mod SHIFT, j, moveactive, 0 20"

        "$mod CTRL, l, resizeactive, 30 0"
        "$mod CTRL, h, resizeactive, -30 0"
        "$mod CTRL, k, resizeactive, 0 -10"
        "$mod CTRL, j, resizeactive, 0 10"
      ];

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };

  };



}

