{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.libvirt;
in
{
  options.has.libvirt = mkOption {
    description = "enable libvirt virtualisation and associated tools.";
    type = types.bool;
    default = false;
  };

  config = mkIf config.has.libvirt {
    virtualisation.libvirtd.enable = true;

    virtualisation.libvirtd.qemu = {
      swtpm.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };

    virtualisation.spiceUSBRedirection.enable = true;

    users.users.raf.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
      dnsmasq
      virt-manager
      virt-manager-qt
    ];





  };

}
