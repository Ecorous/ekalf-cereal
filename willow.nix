# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  #nixpkgs.overlays = [(import (builtins.fetchTarball "https://github.com/PrismLauncher/PrismLauncher/archive/develop.tar.gz")).overlays.default];
  
  imports =
    [ # Include the results of the hardware scan.
      ./willow/hardware.nix
      ./willow/upgrade-diff.nix
      ./willow/docker.nix
    ];

  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostName = "willow";
  nixpkgs.config.allowUnfree = true;
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # KDE
  services.xserver.displayManager.sddm.enable = true;
  
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.tapping = false;
  };
  
  programs = {
    #nushell.enable = true;
    _1password.enable = true;
    _1password-gui.enable = true;
    _1password-gui.polkitPolicyOwners = ["ecorous"];
    adb.enable = true;

    git = {
      enable = true;

      config = {
        init.defaultBranch = "main";
        gpg.format = "ssh";

        user = {
          name = "Ecorous";
          email = "ecorous@outlook.com";
          signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIazU90lTF7rPY11hzMA2CdOXmdaOBTZWJ25PBDl1gzS";
        };

        "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        commit.gpgsign = true;
      };
    };
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      # Nerd Fonts
      nerdfonts
    ];

  };
  
  services.syncthing = {
    enable = true;
    user = "ecorous";
    dataDir = "/home/ecorous/.syncthing-nix";
    configDir = "/home/ecorous/.syncthing-nix/.stconfig";
    overrideDevices = true;
    settings = {
      devices = {
        "yggdrasil-arch" = { # pc (arch)
          id = "WWUGF3Q-3GEQOAA-5OQBK4Z-DMV4X4V-7FIXLJZ-SLMT63X-NFIVNEO-G6OOBA5";
          autoAcceptFolders = true;
        };
        "s20-fe-5g" = { # phone
          id = "KI23VC7-VHCFVOJ-7GFA4BD-CTMFAVG-WEC3KXI-4PONMNS-FHV5OKX-IR2HYQG";
          autoAcceptFolders = true;
        };
      };
      folders = {
        "Sync" = {
          id = "4k29q-qtyr9";
          path = "/home/ecorous/Sync";
          devices = [
            "yggdrasil-arch"
            "s20-fe-5g"
          ];
        };
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.nushell;
  users.users.ecorous = {
    description = "Dawn";
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" ]; # Enable ‘sudo’ and 'adb' for the user.
    shell = pkgs.nushell;
    packages = with pkgs; [ # put gui packages only here or in programs above; don't put in systemPackages
      firefox
      thunderbird
      tree
      helix
      kitty
      prismlauncher
      jetbrains.idea-ultimate
      github-copilot-intellij-agent
      jetbrains.rider
      flameshot
      vscode
      packwiz
      polybarFull
      nodejs_21
    ];
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nushell
    btop
    python3
    graalvm-ce
    zulu8
    zulu11
    zulu17
    temurin-bin
    temurin-bin-8
    temurin-bin-11
    temurin-bin-17
    p7zip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

