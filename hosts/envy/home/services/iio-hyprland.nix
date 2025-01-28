{inputs, pkgs, ...}:
{
  systemd.user.services.iio-hyprland = { 
    Unit = {
      Description = "Hyprland iio service";
      After = [ "post-resume.target" ]; 
    };
    Service = {
      ExecStartPre = "/bin/sh -c 'while [ ! -e /run/systemd/propagate/iio-sensor-proxy.service ]; do sleep 0.5; done'";
      ExecStart = "${inputs.iio-hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/iio-hyprland";
      Restart = "always";
      RestartSec = "1";
    };
    Install = {
      WantedBy = [ "post-resume.target" ];
    };
  };
}
