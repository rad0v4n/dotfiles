{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
  	open = false;
  	modesetting.enable = true;
  	powerManagement.enable = true;
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # zsh
  users.extraUsers.user = {
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
  

  # Allow unfree packages and flakes
  nixpkgs.config.allowUnfree = true;
  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = import ./packages.nix { inherit pkgs; };

  programs = {
  	thunar.enable = true;
  	xfconf.enable = true;
  	yazi.enable = true;
  	xwayland.enable = true;
  	steam.enable = true;
  	noisetorch.enable = true;
  };
  
  programs.hyprland = {
	enable = true;
	withUWSM = true;
	xwayland.enable = true;
  };

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];

  programs.zsh = {
  	enable = true;
  	syntaxHighlighting.enable = true;
  	autosuggestions.enable = true;
  	enableCompletion = true;

  	shellAliases = {
  	    update = "sudo nixos-rebuild switch";
  	    garbage = "nix-collect-garbage -d";
  	    s = "kitten ssh";
  	};
  	ohMyZsh = { # "ohMyZsh" without Home Manager
  	    enable = true;
  	    theme = "frisk"; #frontcube frisk
  	  };
  };

  programs.dms-shell = {
    enable = true;
  
    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dankMaterialShell changes
    };
  };

  services = {
    	gvfs.enable = true;
    	gnome.gnome-keyring.enable = true;
    	printing.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
  };
  
  security.pam.services.hyprland.enableGnomeKeyring = true;

  # virtual machines
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["user"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  
  system.stateVersion = "25.11";

}
