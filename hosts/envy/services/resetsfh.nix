{ pkgs, ... }:
{
  systemd.services.reset-sfh = {
    enable = true;

    #don't even ask
    description = "autoreload amd_sfh kernel driver";
    before = [ "iio-sensor-proxy.service" "suspend.target" ];
    after = [ "multi-user.target" "hibernate.target" ];
    wantedBy = [ "multi-user.target" "suspend.target" "hibernate.target" ];
    upholds = [ "iio-sensor-proxy.service" ];
    
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.kmod}/sbin/modprobe -r amd_sfh";
      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 1'";
      ExecStartPost = "${pkgs.kmod}/sbin/modprobe amd_sfh";
    };
  };
}
