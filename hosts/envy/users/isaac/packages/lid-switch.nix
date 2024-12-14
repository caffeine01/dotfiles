{ writeShellScriptBin }:

writeShellScriptBin "lid-switch" ''
        #!/usr/bin/env bash

        lid_state=$(cat /proc/acpi/button/lid/LID/state)
        external_monitor=$(hyprctl monitors | grep -c "HDMI-A-1")

        if [[ "$lid_state" == *"closed"* ]] && [[ "$external_monitor" -gt 0 ]]; then
          kanshictl switch external-only
        elif [[ "$lid_state" == *"open"* ]] && [[ "$external_monitor" -gt 0 ]]; then
          kanshictl switch dual-display
        fi
''