{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "dev-server" = {
        hostname = "100.121.253.26";
      };

			"pi" = {
				hostname = "100.117.199.69";
			};

			"ubuntu-server" = {
				hostname = "100.118.34.22";
			};

			"*" = {
				user = "blckhrt";
			};
		};
}
