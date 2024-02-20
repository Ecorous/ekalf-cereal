# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  #nixpkgs.overlays = [(import (builtins.fetchTarball "https://github.com/PrismLauncher/PrismLauncher/archive/develop.tar.gz")).overlays.default];

  imports = [ # Include the results of the hardware scan.
    ../common/system.nix
    ../common/plasma.nix
    ./hardware.nix
  ];

  networking.hostName = "willow";

  programs.adb.enable = true;

  services.syncthing.settings = {
    devices.yggdrasil = { # pc
      id = "WWUGF3Q-3GEQOAA-5OQBK4Z-DMV4X4V-7FIXLJZ-SLMT63X-NFIVNEO-G6OOBA5";
      autoAcceptFolders = true;
    };
    folders.Sync.devices = [ "yggdrasil" ];
  };

  users.users.ecorous.extraGroups = [ "adbusers" ];
}

