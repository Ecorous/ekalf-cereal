{ # home.file = {
    "git.pub" = {
        text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIazU90lTF7rPY11hzMA2CdOXmdaOBTZWJ25PBDl1gzS";
        target = ".ssh/git.pub";
    };
    "auth.pub" = {
        text = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqBQLLXMRRce/jXq6wKzxVOZd7yN6S7MHRcAhSDYUFNpJvvhTiHr8IW6c/DXURvEGUZETjxdo0cNjw7T5KjuokPUZMHZO/ehJHzoyx5B6TRvOWHRI/ZRrrkk+V/04eLRbfnu1+xPy8qmPyhH6SPu+1nZ/x97IpLzlNHLRnclkBL47WaVqkcgCtuU/kZbmO4z3VF+PJeYHx+xWQeCnzGI5naagN+7paRSMFrOdmvSt37JbaM9nN6v95s3jGQcfiAw1OXNGLlDRtjhjmF9vFCm79rAbz3tmuioFlPGjZvps1FJsMCSst020decQOW+stOOZbbzxZqhFfREz4ljxiWQ0sn0f2Z6GfGYvFGDWAoEl5DubGqlciELAnG9Qo1L9VNn23Uox1q+/4Ao/Pt6h5eGn/Of11QKcfqFTcmkcc4QuxU3gIG0jyezC19Xj+oW/HsytTrlPinGJHEPaBm2ES42VOVX7Vb0aNqV1Grd2xRsRdA+oEQ8Nk20k5YDqqMnXmQ5c=";
        target = ".ssh/auth.pub";
    };
    "plasma_login.sh" = {
        text = ''
        #!/usr/bin/env bash
        polybar &
        '';
        executable = true;
    };
} # }