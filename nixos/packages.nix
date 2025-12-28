# packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  	#hyprland
	hyprcursor
	hyprpolkitagent

	#compositor
	wl-clipboard
	xclip
	playerctl
	btop
	slurp
	grim
	killall
	libnotify
	pywal
	pywalfox-native
	kdePackages.qt6ct

	#apps
	keepassxc
	spotify
	git
	fastfetch
	firefox
	micro
	vesktop
	gparted
	mullvad
	mullvad-browser	
	ferdium
	nix-search-cli
	tor-browser
	lutris
	wineWowPackages.stable
	winetricks
	libreoffice
	python3
	tldr
	ngrok
	obsidian
	mpv
	pureref
	qbittorrent
	kitty
	vscode
	eog
	kdePackages.kdenlive
	libqalculate

	# cybersecurity
	caido
	burpsuite
	nmap
	ffuf
	hashcat
	sqlite
	postgresql
	exploitdb
	metasploit
	openvpn
	nettools
	
	#themes
	qogir-theme
	qogir-icon-theme
	adw-gtk3
	papirus-icon-theme
  ];
}
