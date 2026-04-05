{ config, pkgs, ... }:

{
  imports = [
   ./hardware-configuration.nix
   ./modules/core/system.nix
  ];
}