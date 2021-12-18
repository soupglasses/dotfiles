{ config, pkgs, lib, ... }:

{
  sops.secrets = {
    "syncthing/key".owner = "sofi";
    "syncthing/cert".owner = "sofi";
    "syncthing/devices/desktop/id".owner = "sofi";
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    user = "sofi";
    group = "users";
    dataDir = "/home/sofi";
    configDir = "/home/sofi/.config/syncthing";

    extraOptions = {
      # Stop syncthing from attempting to connect to the outside world,
      # as I want it to sync only locally.
      options.relaysEnabled = false;
      options.globalAnnounceEnabled = false;
    };

    # Allow nix to overwrite devices and folders in the web interface.
    overrideDevices = true;
    overrideFolders = true;

    # Following https://docs.syncthing.net/users/config.html
    # cert.pem and key.pem are the device’s ECDSA public and private key.
    # These form the basis for the device ID.
    cert = config.sops.secrets."syncthing/cert".path;
    key = config.sops.secrets."syncthing/key".path;

    devices = {
      "desktop" = {
        name = "Desktop";
        id = config.sops.secrets."syncthing/devices/desktop/id".path;
      };
    };

    folders = {
      "books" = {
        id = "books";
        label = "Books";
        path = "/home/sofi/Books";
        devices = [ "desktop" ];
        versioning = { type = "trashcan"; params.cleanoutDays = "180"; };
      };
      "code" = {
        id = "code";
        label = "Code";
        path = "/home/sofi/Code";
        devices = [ "desktop" ];
        versioning = { type = "trashcan"; params.cleanoutDays = "180"; };
      };
      "documents" = {
        id = "documents";
        label = "Documents";
        path = "/home/sofi/Documents";
        devices = [ "desktop" ];
        versioning = { type = "trashcan"; params.cleanoutDays = "180"; };
      };
      "music" = {
        id = "music";
        label = "Music";
        path = "/home/sofi/Music";
        devices = [ "desktop" ];
        versioning = { type = "trashcan"; params.cleanoutDays = "180"; };
      };
      "pictures" = {
        id = "pictures";
        label = "Pictures";
        path = "/home/sofi/Pictures";
        devices = [ "desktop" ];
        versioning = { type = "trashcan"; params.cleanoutDays = "180"; };
      };
      "secure" = {
        id = "secure";
        label = "Secure";
        path = "/home/sofi/.secure";
        devices = [ "desktop" ];
        versioning = { type = "trashcan"; params.cleanoutDays = "180"; };
      };
      "multimc" = {
        id = "multimc";
        label = "MultiMC";
        path = "/home/sofi/.local/share/multimc";
        devices = [ "desktop" ];
        versioning = { type = "trashcan"; params.cleanoutDays = "180"; };
      };
    };
  };
}
