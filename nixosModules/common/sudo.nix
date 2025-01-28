{ config, lib, ... }: {

	options.sudo.passwordless = lib.mkOption {
		description = "set to false to require wheel group to type in passwords for sudo";
		type = lib.types.bool;
		default = true;
		};

	config = lib.mkIf config.sudo.passwordless {
		security.sudo.wheelNeedsPassword = false;
		};


	

}
