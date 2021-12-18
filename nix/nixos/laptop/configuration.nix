# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/sops.nix
      ./modules/syncthing.nix
      ./modules/interception-tools.nix
    ];

  # Set up GRUB to support encrypted root
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.luks.devices = {
    cryptroot = {
      device = "/dev/disk/by-uuid/c17f5de8-196f-4078-acc0-26526ae3243c";
      preLVM = true;
    };
  };
  boot.initrd.availableKernelModules = [
    "aesni_intel"
    "cryptd"
  ];

  networking.hostName = "laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.networkmanager.enable = true;
  # networking.interfaces.enp0s31f6.useDHCP = true;
  # networking.interfaces.wlp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "ter-i24b";
    packages = [ pkgs.terminus_font ];
    earlySetup = true;
    keyMap = "no";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "no";
  services.xserver.xkbVariant = "nodeadkeys";

  # Intel Drivers
  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.useGlamor = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.mutableUsers = false;

  users.users.sofi = {
    isNormalUser = true;
    hashedPassword = "$6$2ak/F4qUswye5sRP$LxE.rjak3AwazC8Ub3UI7mlMD08lWEkfV/ttu87byo7B0nj9TrkuEoy3JK4LkQxdJRvzDiKSUfCs/Hi84PJBZ1";
    description = "Sofi";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvgn0kSAboULv37yLS1fGwByGSudhbQGrP/RrO7+cH+ sofi@mailbox.org" ];
  };

  # Zsh setup
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = [ pkgs.zsh ];
  users.users.sofi.shell = pkgs.zsh;
  users.users.sofi.useDefaultShell = false;

  #home-manager.users.sofi = import ./home/home.nix;

  # home-manager = {
  #   useUserPackages = true;
  #   useGlobalPkgs = true;
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    evolution
    gnome.gnome-tweaks
    gnome.dconf-editor
    htop
    neovim
    git
    python
    sops
    wget
    firefox
    ungoogled-chromium
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
  programs.mosh.enable = true;

  programs.gamemode.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [];
  # networking.firewall.allowedUDPPorts = [];

  system.stateVersion = "21.05";
}
