{ config, pkgs, ... }:

{
	services = {

		gvfs.enable = true;
		gnome.gnome-keyring.enable = true;
		printing.enable = true;
	
		xserver.xkb = {
		    layout = "us";
		    variant = "";
		};
		
		avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};

  		mullvad-vpn = {
			enable = true;
			package = pkgs.mullvad-vpn;
		};	
	};
}
