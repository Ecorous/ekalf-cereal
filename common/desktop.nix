{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.xserver.xkb.layout = "gb";
  services.xserver.libinput = {
    enable = true;
    touchpad.tapping = false;
  };

}
