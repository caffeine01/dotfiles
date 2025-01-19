{inputs, pkgs, ...}:
{
  systemd.user.services.iio-hyprland = {
    Unit = {
      Description = "Hyprland iio service";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];# "suspend.target" "hibernate.target" ];
    };
    Service = {
      ExecStart = ''${inputs.iio-hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/iio-hyprland'';
      Restart = "always";
      RestartSec = "10";
    };
    Install.WantedBy = [ "graphical-session.target" ]; # "suspend.target" "hibernate.target" ];
  };
}
