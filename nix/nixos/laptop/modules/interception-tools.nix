{ pkgs, ... }:

{
  environment.etc."interception/lenovo.yaml".text = ''
    TIMING:
      TAP_MILLISEC: 210
      DOUBLE_TAP_MILLISEC: 0
      SYNTHETIC_KEYS-PAUSE_MILLISEC: 10

    MAPPINGS:
      - KEY: KEY_CAPSLOCK
        TAP: KEY_ESC
        HOLD: KEY_LEFTCTRL
  '';

  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/interception/lenovo.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          NAME: "AT Translated Set 2 keyboard"
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK]
    '';
  };
}
