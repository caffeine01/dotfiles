{ pkgs, ... }:
let
  script = ''
    ${pkgs.util-linux}/bin/rfkill unblock all
  '';
in
{
  systemd.services.unblock-wifi = {
    enable = true;

    description = "Unblock Wi-Fi on Resume";
    after = [
      "suspend.target"
      "hibernate.target"
    ];
    wantedBy = [
      "suspend.target"
      "hibernate.target"
    ];

    serviceConfig = {
      Type = "oneshot";
    };

    inherit script;
  };
}
