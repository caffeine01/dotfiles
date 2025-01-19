{ pkgs, ... }:
let
  script = ''
    ${pkgs.kmod}/sbin/modprobe -r amd_sfh 
    sleep 1
    ${pkgs.kmod}/sbin/modprobe amd_sfh
  '';
in 
{
  systemd.services.reset-sfh = {
    enable = true;
    
    description = "autoreload amd_sfh kernel driver";
    before = [ "iio-sensor-proxy.service" ];
    after = [ "multi-user.target" "suspend.target" "hibernate.target" ];
    wantedBy = [ "multi-user.target" "suspend.target" "hibernate.target" ];
    
    serviceConfig = {
      Type = "oneshot";
    };

    inherit script;
  };
}
