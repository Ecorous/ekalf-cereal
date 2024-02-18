
{
    # configure ecorous user
    # using nix home-manager
    # in the other file we have this file imported as home-manager.users.ecorous = this file


    home.username = "ecorous";
    home.homeDirectory = "/home/ecorous";

    home.stateVersion = "24.05";

    xsession.enable = true;
    xsession.windowManager.command = "startplasma-x11";

    programs = {
        home-manager.enable = true;
        gh.enable = true;
        ssh.enable = true;
        btop.enable = true;
        helix.enable = true;
        hyfetch.enable = true;
        kitty.enable = true;
        
        nushell = import ./nushell.nix;

        kitty.font = {
            name = "JetBrainsMono Nerd Font Mono";
            size = 12;
        };
        hyfetch.settings = {
            preset = "lesbian";
            mode = "rgb";
            lightDark = "dark";
            lightness = 0.62;
            colorAlign = {
                mode = "horizontal";
            };
            backend = "neofetch";
            distro = "nixos";
        };
        ssh.matchBlocks = {
            "github.com" = {
                hostname = "github.com";
                user = "git";
                #identityFile = "~/.ssh/git.pub";
            };
            "*" = { 
                #identityFile = "~/.ssh/auth.pub";
                extraOptions = {
                    IdentityAgent = "~/.1password/agent.sock";
                };
            };
        };
    };

    services =  {
        polybar = import ./polybar.nix;
        kdeconnect.enable = true;
        kdeconnect.indicator = true;
        flameshot.enable = true;
    };

    home.file = import ./ecorous.files.nix;
}
