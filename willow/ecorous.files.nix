
{ # home.file = {
    #"git.pub" = {
    #    source = config.lib.file.mkOutOfStoreSymlink ./config/git.pub;
    #    target = ".ssh/git.pub";
    #    mode = 600;
    #};
    #"auth.pub" = {
    #    source = config.lib.file.mkOutOfStoreSymlink ./config/auth.pub;
    #    target = ".ssh/auth.pub";
    #    mode = 600;
    #};
    "plasma_login.sh" = {
        text = ''
        #!/usr/bin/env bash
        polybar &
        '';
        executable = true;
    };
} # }