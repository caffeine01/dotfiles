# This is a workaround for an issue affecting how the AMD Sensor Fusion Hub
# on this HP Envy x360 is initialised and reinitialised during boot and wake
# from hibernate or suspend. The SFH works perfectly, but the amd_sfh kernel
# module needs to be reloaded each time in order it to be properly initialised.
# Most likely a hardware quirk, tried briefly to get a kernel patch made with an
# AMD rep on bugzilla but to no avail. Chasing this would take way too long
# (i am a student after all) and so this will have to do for now.
{ pkgs, config, ... }:
{
  config = {
    systemd.services = {
      sfh-unload = {
        description = "Unload amd_sfh kernel driver after boot and before sleep";
        after = [ "multi-user.target" ];
        before = [
          "sleep.target"
          "iio-sensor-proxy.service"
        ];
        wantedBy = [
          "multi-user.target"
          "sleep.target"
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.kmod}/sbin/modprobe -r amd_sfh";
          ExecPost = "${pkgs.coreutils}/bin/sleep 1";
        };
      };

      sfh-reload = {
        description = "Reload amd_sfh kernel driver after boot and after wake";
        before = [ "iio-sensor-proxy.service" ];
        after = [
          "sfh-unload.service"
          "multi-user.target"
          "hibernate.target"
          "suspend.target"
        ];
        wantedBy = [
          "multi-user.target"
          "hibernate.target"
          "suspend.target"
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.kmod}/sbin/modprobe amd_sfh";
        };
      };
    };
  };
}
