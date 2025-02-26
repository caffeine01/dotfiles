{ writeShellScriptBin, pkgs }:

writeShellScriptBin "reset-network" ''
  ${pkgs.polkit}/bin/pkexec sh -c "echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove; sleep 1; echo 1 > /sys/bus/pci/rescan"
''
