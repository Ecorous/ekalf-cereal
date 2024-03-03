{ # home.packages.nushell
  enable = true;
  configFile.source = ../global/config/config.nu;
  envFile.source = ../global/config/config.nu;
  extraConfig = ''
    def paru [] {
        echo "dumbass, you're not on arch, you're on nixos"
    }

    def nixos-switch [flake: string = "/home/ecorous/ekalf-cereal#", --build] {
        let sub = if $build { "build" } else "switch"
        echo nixos-switch: ([$sub ing] | str join) the system flake | str join " "
        sudo nixos-rebuild $sub --flake $flake
    }
    def disks [] {
      df -h | str replace "Mounted on" "Mountpoint" | detect columns | sort-by Use% | reverse | move Mountpoint --before Filesystem | rename "Mount" "Device" "Total Size" "Used" "Available" "Used (%)"
    }

    def shell [--nix_file: string = "shell.nix", --command: string = "nu"] {
      nix-shell $nix_file --command $command
    }

    def shellOf-node [] {
      shell --nix_file /home/ecorous/shells/node.nix
    }
  '';
}
