{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:
let
  cfg = config.libadwaita-without-adwaita;
in
with lib;
{
  options.libadwaita-without-adwaita.enable = mkEnableOption "Enables custom gtk4 themes accross all gtk apps by default.";

  config = mkMerge [
    (mkIf cfg.enable {
      nixpkgs.overlays =
        let
          aurRepo = pkgs.fetchgit {
            url = "https://aur.archlinux.org/libadwaita-without-adwaita-git.git";
            rev = "312880664a0b37402a93d381c9465967d142284a";
            hash = "sha256-Z8htdlLBz9vSiv5qKpCLPoFqk14VTanaLpn+mBITq3o=";
          };
          themingPatch = aurRepo + "/theming_patch.diff";
        in
        [
          (final: prev: {
            libadwaita-without-adwaita = prev.libadwaita.overrideAttrs (old: {
              doCheck = false;
              patches = (old.patches or [ ]) ++ [
                themingPatch
              ];
              mesonFlags = (old.mesonFlags or [ ]) ++ [
                "--buildtype=release"
                "-Dexamples=false"
              ];
            });
          })
        ];
      system.replaceDependencies.replacements = with pkgs; [
        {
          oldDependency = libadwaita.out;
          newDependency = libadwaita-without-adwaita.out;
        }
      ];
    })
  ];
}
