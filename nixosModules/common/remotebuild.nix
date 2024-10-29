{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.is.remotebuilder;
in
{
  options.is.remotebuilder = mkOption {
    description = "make this machine a remote builder";
    type = types.bool;
    default = false;
  };

  config = mkIf config.is.remotebuilder {
    users.users.remotebuild = {
      isNormalUser = true;
      createHome = false;
      group = "remotebuild";

      openssh.authorizedKeys.keyFiles = [ ./remotebuilder.pub ];
    };

    users.groups.remotebuild = { };

    nix.settings.trusted-users = [ "remotebuilder" ];

  };

}
