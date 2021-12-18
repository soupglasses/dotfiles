{
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = true;
      gtk-theme = "Adwaita-dark";
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/nautilus/preferences" = {
      search-filter-time-type = "last_modified";
    };
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple ["xkb" "dk+nodeadkeys"])
        (lib.hm.gvariant.mkTuple ["xkb" "no+nodeadkeys"])
        (lib.hm.gvariant.mkTuple ["xkb" "us+colemak_dh"])
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      maximize = [ "<Super>w" ];
      unmaximize = [ "<Super>s" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      switch-applications = [ ];
      switch-applications-backward = [ ];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Super>a" ];
      toggle-tiled-right = [ "<Super>d" ];
    };
    "org/gnome/shell/keybindings" = {
      toggle-application-view = [ ];
      toggle-overview = [ ];
    };
  };
}
