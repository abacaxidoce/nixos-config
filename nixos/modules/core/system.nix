{ pkgs, ... }:

{
  imports = [
   ./desktop/sway.nix
   ./login.nix
  ];
  
  # System basis
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

  # System Cleanup and Optimization
  zramSwap.enable = true;
  nix.settings.auto-optimise-store = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d"; 
  };

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network 
  networking.hostName = "nixos_btw";
  networking.networkmanager.enable = true;

  # Regional settings
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "br-abnt2";

  # Sound and Media Services
  security.rtkit.enable = true; 
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # System Modules
  hardware.bluetooth.enable = true;

  # User and Permissions
  users.users.dryyy = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}