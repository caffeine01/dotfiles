{ writeShellScriptBin }:

writeShellScriptBin "set-wallpapers" ''
  #!/usr/bin/env bash

  # Initialize swww if not already running
  if ! pgrep -x "swww-daemon" > /dev/null; then
      swww-daemon
  fi

  # Set wallpapers for each monitor
  swww img /home/isaac/Documents/houseonthesideofalake.jpg
''
