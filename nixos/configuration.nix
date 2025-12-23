{ config, pkgs, ... }:

{
	imports =
	[
		./hardware-configuration.nix
		./packages.nix
		./programs.nix
		./services.nix
	];

	# nvidia
	hardware.graphics.enable = true;
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.nvidia = {
	open = false;
	modesetting.enable = true;
	powerManagement.enable = true;
	};

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos";
	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Bratislava";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "sk_SK.UTF-8";
		LC_IDENTIFICATION = "sk_SK.UTF-8";
		LC_MEASUREMENT = "sk_SK.UTF-8";
		LC_MONETARY = "sk_SK.UTF-8";
		LC_NAME = "sk_SK.UTF-8";
		LC_NUMERIC = "sk_SK.UTF-8";
		LC_PAPER = "sk_SK.UTF-8";
		LC_TELEPHONE = "sk_SK.UTF-8";
		LC_TIME = "sk_SK.UTF-8";
	};

	users.users.user = {
		isNormalUser = true;
		description = "user";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};

	fonts.packages = with pkgs; [
		fira-code
		fira-code-symbols
		nerd-fonts.fira-code
	];

	environment.variables = {
		EDITOR = "micro";
		VISUAL = "micro";
		XDG_CACHE_HOME  = "$HOME/.cache";
		XDG_CONFIG_HOME = "$HOME/.config";
		XDG_DATA_HOME   = "$HOME/.local/share";
		XDG_STATE_HOME  = "$HOME/.local/state";
		XAUTHORITY		= "$HOME/.Xauthority";
	};

	security.pam.services.hyprland.enableGnomeKeyring = true;

	# virtual machines
	programs.virt-manager.enable = true;
	users.groups.libvirtd.members = ["user"];
	virtualisation.libvirtd.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;

	system.stateVersion = "25.11";
}
