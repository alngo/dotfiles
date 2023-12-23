# Tuxedora

## Description

Fedora 39 installation on a Tuxedo laptop.
```
Fedora Sericea
Tuxedo InfinityBook Pro 16
```

- [Fedora](https://fedoraproject.org/)
- [Creating and using a live installation image](https://docs.fedoraproject.org/en-US/quick-docs/creating-and-using-a-live-installation-image/)

Press F7 when booting and follow the installation steps.

## Flatpak applications

- [KeePassXC](https://keepassxc.org/)
- [Neovim](https://flathub.org/apps/io.neovim.nvim)

## Configuration

- [Fedora Sericea](https://fedoraproject.org/sericea/)
- [Fedora Sericea Configuration](https://docs.fedoraproject.org/en-US/fedora-sericea/configuration-guide/)
- [Sway Wiki](https://github.com/swaywm/sway/wiki)

### Keyboard configuration

Add the following lines to the ~/.config/sway/config

```
#
# Keyboard layout
#

input "type:keyboard" {
    xkb_layout us
    xkb_options ctrl:nocaps
    repeat_delay 250
    repeat_rate 30
}
```
To validate sway configuration:
```
sway --debug --validate [--config /path/to/config]
```
To Reload Sway
```
Mod+shift+c to reload
```

### Vim configuration


