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
    steam.enable = true;

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
  hardware.opengl = {
    enable = true;
    extraPackages = [ pkgs.libGL ];
    setLdLibraryPath = true;
  };

  users.defaultUserShell = pkgs.nushell;
  users.users.ecorous = {
    description = "Dawn";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.nushell;
    packages = with pkgs; [
      gh
      firefox
      thunderbird
      helix
      kitty
      prismlauncher
      jetbrains.idea-ultimate
      github-copilot-intellij-agent
      #jetbrains.rider
      flameshot
      vscode
      packwiz
      polybarFull
      libnotify
      nixfmt
      onefetch
      qbittorrent
      wine
      wine64
      protontricks
      signal-desktop
      (pkgs.discord-canary.override {
        withOpenASAR = true;
        withVencord = true;
      })
      gcc_multi
      lld
      vlc
      carapace
      micromamba
      nodejs-slim_21
    ];
  };

  environment.systemPackages = with pkgs; [
    helix
    wget
    nushell
    btop
    python3
    temurin-bin
    temurin-bin-8
    temurin-bin-17
    p7zip
    ntfs3g
    rustdesk
  ];

  services.tailscale.enable = true;

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  networking.firewall.enable = false;

  system.stateVersion = "24.05"; # no touchy. bad.
}
