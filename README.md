# NixOS Config


## Stack:
- **WM:** Sway
- **Login:** Tuigreet
- **Package Manager:** Flakes + Home-Manager
- **Editor:** Nvim



#### _Nixos-Version:_ 25.11


## **Installation DotFiles:**

1. git clone nixos-config
2. cd nixos-config/nixos
3. sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/nixos/hardware-configuration.nix
4. git init
5. git add .
6. git commit -m "1.0"
6. sudo nixos-rebuild switch --flake .#nixos_btw
7. reboot