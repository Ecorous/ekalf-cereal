{
  imports = [ ../common/home-manager.nix ];

  home-manager.users.ecorous = import ../common/ecorous.nix;
}
