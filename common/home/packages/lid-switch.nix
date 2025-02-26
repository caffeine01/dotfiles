{ writeShellScriptBin }:

writeShellScriptBin "lid-switch" ''
  #!/usr/bin/env bash

  lid_state=$(cat /proc/acpi/button/lid/LID/state)
  external_monitor=$(hyprctl monitors | grep -c "HDMI-A-1")

  if [[ "$lid_state" == *"closed"* ]]; then
    systemctl --user stop iio-hyprland
    if [[ "$external_monitor" -gt 0 ]]; then
      kanshictl switch external-only
    fi
  elif [[ "$lid_state" == *"open"* ]]; then
    systemctl --user start iio-hyprland
    if [[ "$external_monitor" -gt 0 ]]; then
      kanshictl switch dual-display
    fi
  fi
''
