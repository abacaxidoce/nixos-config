{ pkgs, ... }:

{
  imports = [
    ./modules/dev/default.nix
  ];

  # User Information
  home.username = "dryyy";
  home.homeDirectory = "/home/dryyy";

  # DotFiles
  home.file.".config" = {
    source = ./config;
    recursive = true; 
  };

  # User Packages
  home.packages = with pkgs; [   
    # CLI tools:
    alacritty
    neovim
    
    # Graphical Applications:
    firefox
    discord
  ];

  home.stateVersion = "25.11"; # Keep the same version as the system.nix
  programs.home-manager.enable = true;
}