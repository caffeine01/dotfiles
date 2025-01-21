{inputs, pkgs, ...}:
{
  systemd.user.services.iio-hyprland = { 
    Unit = {
      Description = "Hyprland iio service";
      Before = [ "suspend.target" ];
      After = [ "iio-sensor-proxy.service" "graphical-session.target" ]; #"suspend.target" "hibernate.target" ];
    };
    Service = {
      ExecStartPre = "/bin/sh -c 'while ! ${pkgs.systemd}/bin/systemctl --system is-active iio-sensor-proxy.service; do sleep 0.5; done'";
      ExecStart = "${inputs.iio-hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/iio-hyprland";
      Restart = "always";
      RestartSec = "1";
    };
    Install = {
      WantedBy = [ "graphical-session.target" "suspend.target" "hibernate.target" ];
    };
  };
}
