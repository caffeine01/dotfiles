{ pkgs, ... }:

let
  script = "${pkgs.writeShellScriptBin "start" ''
    active_sessions=$("${pkgs.iproute2}"/bin/ss -tn | grep -c "192.168.122.3:3389")
    vm_state=$("${pkgs.libvirt}"/bin/virsh domstate "win11")

    if [ "$active_sessions" -eq 0 ] && [ "$vm_state" = "running" ]; then
        "${pkgs.libvirt}"/bin/virsh managedsave "win11"
    fi
  ''}/bin/start";
in
{
  systemd.services.vm-auto-suspend = {
    description = "Automatically suspends Windows 11 KVM when RDP connection is absent.";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    inherit script;
  };

  systemd.timers.vm-auto-suspend = {
    wantedBy = [ "timers.target" ];
    after = [
      "network.target"
      "libvirtd.service"
    ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "vm-auto-suspend.service";
    };
  };
}
