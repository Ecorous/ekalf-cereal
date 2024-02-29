{
  imports = [ ./desktop.nix ];
  services.xserver.desktopManager.plasma6 = { enable = true; };
  services.xserver.displayManager.defaultSession = "plasma";
}
