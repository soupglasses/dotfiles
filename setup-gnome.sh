
# Tweaks
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.shell disabled-extensions ['background-logo@fedorahosted.org']
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

gsettings set org.gnome.desktop.interface clock-format '12h'
gsettings set org.gnome.desktop.interface clock-show-seconds false
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.calendar active-view 'month'

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

gsettings set org.gnome.nautilus.preferences search-filter-time-type 'last_modified'

gsettings set org.gnome.desktop.input-sources mru-sources [('xkb', 'no+nodeadkeys'), ('xkb', 'us+colemak_dh')]
gsettings set org.gnome.desktop.input-sources per-window false
gsettings set org.gnome.desktop.input-sources sources [('xkb', 'no+nodeadkeys'), ('xkb', 'us+colemak_dh')]

# Keyboard settings
gsettings set org.gnome.desktop.wm.keybindings maximize ['<Super>w']
gsettings set org.gnome.mutter.keybindings toggle-tiled-left ['<Super>a']
gsettings set org.gnome.desktop.wm.keybindings unmaximize ['<Super>s']
gsettings set org.gnome.mutter.keybindings toggle-tiled-right ['<Super>d']
gsettings set org.gnome.shell.keybindings toggle-application-view []
gsettings set org.gnome.shell.keybindings toggle-overview []

gsettings set org.gnome.desktop.wm.keybindings switch-windows ['<Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward ['<Shift><Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-applications []
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward []

