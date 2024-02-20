{ config, lib, pkgs, ... }:

{
  imports = [ ./upgrade-diff.nix ./docker.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    _1password-gui.polkitPolicyOwners = [ "ecorous" ];

    git = {
      enable = true;

      config = {
        init.defaultBranch = "mistress";
        gpg.format = "ssh";

        user = {
          name = "Ecorous";
          email = "ecorous@outlook.com";
          signingkey =
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIazU90lTF7rPY11hzMA2CdOXmdaOBTZWJ25PBDl1gzS";
        };

        "gpg \"ssh\"".program =
          "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        commit.gpgSign = true;
      };
    };
  };

  fonts.fontconfig.enable = true;
  fonts.packages = [ pkgs.nerdfonts ];

  services.syncthing = import ./syncthing.nix;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.defaultUserShell = pkgs.nushell;
  users.users.ecorous = {
    description = "Dawn";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.nushell;
    packages = with pkgs; [
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
      libnotify
      nixfmt
      onefetch
    ];
  };

  environment.systemPackages = with pkgs; [
    helix
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

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  networking.firewall.enable = false;

  system.stateVersion = "24.05"; # no touchy. bad.
}
