{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  environment.systemPackages = with pkgs; [
    glib
    gnome-themes-extra
  ];

  environment.etc = {
    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Adwaita-dark
      gtk-application-prefer-dark-theme=1
    '';
    "gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Adwaita-dark
      gtk-application-prefer-dark-theme=1
    '';
  };

  environment.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    XDG_CURRENT_DESKTOP = "sway";
  };

  programs.dconf.enable = true;
}
