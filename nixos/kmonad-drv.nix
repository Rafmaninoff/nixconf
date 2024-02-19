let
  pkgs = import <nixpkgs> { };

  kmonad-bin = pkgs.fetchurl {
    url = "https://github.com/kmonad/kmonad/releases/download/0.4.2/kmonad-0.4.2-linux";
    sha256 = "f18334b4d037ca5140f800029222855669748622";
  };
in
pkgs.runCommand "kmonad" { }
  ''
    #!${pkgs.stdenv.shell}
    mkdir -p $out/bin
    cp ${kmonad-bin} $out/bin/kmonad
    chmod +x $out/bin/*
  ''
