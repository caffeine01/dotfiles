{ pkgs, config, ... }:
{
  config = {
    systemd.services = {
      sfh-unload = {
        description = "Unload amd_sfh kernel driver after boot and before sleep";
        after = [ "multi-user.target" ];
        before = [ "sleep.target" "iio-sensor-proxy.service" ];
        wantedBy = [ "multi-user.target" "sleep.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.kmod}/sbin/modprobe -r amd_sfh";
          ExecPost = "${pkgs.coreutils}/bin/sleep 1";
        };
      };

      sfh-reload = {
        description = "Reload amd_sfh kernel driver after boot and after wake";
        before = [ "iio-sensor-proxy.service" ];
        after = [ "sfh-unload.service" "multi-user.target" "hibernate.target" "suspend.target" ];
        wantedBy = [ "multi-user.target" "hibernate.target" "suspend.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.kmod}/sbin/modprobe amd_sfh";
        };
      };
    };
  };
}
