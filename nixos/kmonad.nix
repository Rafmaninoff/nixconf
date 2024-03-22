{ pkgs, lib, ... }:
let
  kmonad-bin = pkgs.fetchurl {
    url = "https://github.com/kmonad/kmonad/releases/download/0.4.2/kmonad";
    sha256 = "54d3f1b56a8fc8f2e7a2cd290d2cbd8892cfc54e1e76fb4cd24769ebf46fe348";
  };
in
pkgs.stdenv.mkDerivation {
  name = "kmonad";
  version = "0.4.2";
  src = kmonad-bin;
  phases = [ "installPhase" ];
  installPhase = ''
    #!${pkgs.stdenv.shell}
    mkdir -p $out/bin
    cp ${kmonad-bin} $out/bin/kmonad
    chmod +x $out/bin/*
  '';
}
