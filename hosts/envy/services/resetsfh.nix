let 
  script = ''
        echo "Starting autorotate fix..."
        echo "1" > /sys/bus/pci/devices/0000:04:00.7/remove
        sleep 1
        echo "1" > /sys/bus/pci/rescan
      '';
in {
  systemd.services.reset-sfh = {
    enable = true;
    
    description = "Reset for AMD Sensor Fusion Hub PCI device.";
    after = [ "multi-user.target" "suspend.target" "hibernate.target" ];
    wantedBy = [ "multi-user.target" "suspend.target" "hibernate.target" ];
    
    serviceConfig = {
      Type = "oneshot";
    };
    
    inherit script;
  };
}
