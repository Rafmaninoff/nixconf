{ pkgs, lib, config, ... }:
with lib;
let cfg = config.has.javawrappers;
in {
  options.has.javawrappers = mkEnableOption "enable java wrappers";

  config = mkIf config.has.javawrappers {
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "java8" ''
        ${pkgs.jdk8}/bin/java "$@"
      '')
      (writeShellScriptBin "java17" ''
        ${pkgs.jdk17}/bin/java "$@"
      '')
      (writeShellScriptBin "java21" ''
        ${pkgs.jdk21}/bin/java "$@"
      '')
    ];

  };

}
