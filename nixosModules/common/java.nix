{ pkgs, pkgs-stable, lib, config, ... }:
with lib;
let
  cfg = config.has.javawrappers;
in
{
  options.has.javawrappers = mkOption {
    description = "wrappers for different java versions";
    type = types.bool;
    default = true;
  };

  config = mkIf cfg {
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
      (writeShellScriptBin "java25" ''
        ${pkgs.jdk25}/bin/java "$@"
      '')
      (writeShellScriptBin "javaGraal" ''
        ${pkgs-stable.graalvmPackages.graalvm-oracle}/bin/java "$@"
      '')
    ];
  };
}
