{inputs, pkgs, ...}:
{
    systemd.user.services.iio-hyprland = {
    Unit = {
      Description = "Hyprland iio service";
      PartOf = [ "hyprland-session.target" ];
      After = [ "hyprland-session.target" "suspend.target" "hibernate.target" ];
    };
    Service = {
      ExecStart = ''${inputs.iio-hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/iio-hyprland'';
      Restart = "on-failure";
    };
    Install.WantedBy = [ "hyprland-session.target" "suspend.target" "hibernate.target" ];
  };
}