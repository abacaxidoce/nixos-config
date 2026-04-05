{ config, pkgs, ... }:

{
  imports = [
    ./gtk.nix  # GTK-Theme
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    
    # Packages
    extraPackages = with pkgs; [
      fuzzel
      mako
      libnotify
      brightnessctl
      wlsunset
      jq
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}