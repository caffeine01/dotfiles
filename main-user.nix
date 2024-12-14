{lib, config, pkgs, ...}:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "Enable User Module.";

    userName = lib.mkOption {
      default = "isaac";
      description = ''
        Username.
      ''
    }
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      shell = pkgs.zsh;
    }
  }
}
