{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../common/system.nix
    ../common/plasma.nix
    #./hardware.nix
  ];

  networking.hostName = "yggdrasil";

  services.syncthing.settings = {
    devices.willow = { # laptop
      id = "XBATWII-SVTIEMV-EIQSLJG-CTW2KVN-M6KS4WA-6ZJ7QHQ-UUPLOW2-ZEN2TAX";
      autoAcceptFolders = true;
    };
    folders.Sync.devices = [ "willow" ];
  };
}
