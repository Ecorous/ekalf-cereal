{
  enable = true;
  user = "ecorous";
  dataDir = "/home/ecorous/.syncthing-nix";
  configDir = "/home/ecorous/.syncthing-nix/.stconfig";
  overrideDevices =
    false; # connecting 2 nix devices means the ids dont stay the same - nothing I can do about that
  overrideFolders = false;
  settings = {
    devices.s20-fe-5g = {
      id = "KI23VC7-VHCFVOJ-7GFA4BD-CTMFAVG-WEC3KXI-4PONMNS-FHV5OKX-IR2HYQG";
      autoAcceptFolders = true;
    };

    folders.Sync = {
      id = "4k29q-qtyr9";
      path = "/home/ecorous/Sync";
      devices = [ "s20-fe-5g" ];
    };
  };
}
