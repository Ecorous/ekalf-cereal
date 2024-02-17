# Thank you https://github.com/soopyc/nix-on-koumakan/blob/a21ffa952a7aa6231fa3850ff33f4b837d3b183a/global/upgrade-diff.nix
{pkgs, ...}: {
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
    '';
  };
}