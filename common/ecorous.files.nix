{ # home.file = {
  "git.pub" = {
    source = ../global/config/git.pub;
    target = ".ssh/git.pub";
  };
  "auth.pub" = {
    source = ../global/config/auth.pub;
    target = ".ssh/auth.pub";
  };
  "plasma_login.sh" = {
    text = ''
      #!/usr/bin/env bash
      #polybar &
      1password &
    '';
    executable = true;
  };
} # }
