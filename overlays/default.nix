{ inputs, ... }: {
  additions = final: _prev:
    import ../pkgs {
      inherit (final) callPackage;
      pkgs = final;
    };
}
