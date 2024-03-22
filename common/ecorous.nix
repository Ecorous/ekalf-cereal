{
  home.stateVersion = "24.05";

  home.username = "ecorous";
  home.homeDirectory = "/home/ecorous";

  xsession.enable = true;
  xsession.windowManager.command = "startplasma-x11";

  programs = {
    home-manager.enable = true;
    #gh.enable = true;
    ssh.enable = true;
    btop.enable = true;
    helix.enable = true;
    hyfetch.enable = true;

    nushell = import ./nushell.nix;

    kitty.font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 12;
    };
    hyfetch.settings = {
      preset = "lesbian";
      light_dark = "dark";
      lightness = 0.62;
      mode = "rgb";
      color_align = { mode = "horizontal"; custom_colors = []; fore_back = null; };
      backend = "neofetch";
      args = null;
      distro = null;
      pride_month_shown = [];
      pride_month_disable = false;
    };
    ssh.matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        #identityFile = "~/.ssh/git.pub";
      };
      "*" = {
        #identityFile = "~/.ssh/auth.pub";
        extraOptions = { IdentityAgent = "~/.1password/agent.sock"; };
      };
    };
  };

  services = {
    #polybar = import ./polybar.nix;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    flameshot.enable = true;
  };

  home.file = import ./ecorous.files.nix;
}
