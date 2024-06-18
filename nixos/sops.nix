{ config, pkgs, lib, inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/raf/.config/sops/age/keys.txt";

  sops.secrets = {
    example_key = { };
    "myservice/mysubdir/mysecret" = { };
  };

}
