{ config, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	programs = {
		thunar.enable = true;
		xfconf.enable = true;
		yazi.enable = true;
		xwayland.enable = true;
		steam.enable = true;
		noisetorch.enable = true;


		hyprland = {
		      enable = true;
		      withUWSM = true;
		      xwayland.enable = true;
		};

		thunar.plugins = with pkgs.xfce; [
	  		thunar-volman
		];

		zsh = {
			enable = true;
			syntaxHighlighting.enable = true;
			autosuggestions.enable = true;
			enableCompletion = true;

			shellAliases = {
				update = "sudo nixos-rebuild switch";
				garbage = "nix-collect-garbage -d";
				s = "kitten ssh";
	      	};
			ohMyZsh = {
				enable = true;
				theme = "frisk"; #frontcube frisk
			};
		};

		dms-shell = {
			enable = true;
	
			systemd = {
				enable = true;             # Systemd service for auto-start
				restartIfChanged = true;   # Auto-restart dms.service when dankMaterialShell changes
			};
		};
	};
}
