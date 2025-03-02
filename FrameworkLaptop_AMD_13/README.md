# This is a note over the environment for my Framework Laptop 13inch AMD

## Initial installation settings

## Pacman packages

* less
* rsync
* xev
* qtile
* rofi
* ibus
* neovim
* virtualbox
* wine
* winetricks
* ollama
* signal-desktop
* handbrake-cli
* unrar
* calibre
* audacity
* conky
* nitrogen
* flameshot
* python-virtualenv
* xinput
* libinput
* acipilight
* python-dbus-fast
* alsa-utils
* python-iwlib
* upower
* xorg-server-xephyr
* nautilus
* breeze-icons

## AUR

* [qtile-extras](https://aur.archlinux.org/packages/qtile-extras)
* [teams](https://aur.archlinux.org/packages/teams)
* [brave-bin](https://aur.archlinux.org/packages/brave-bin)
* [i3lock-color](https://aur.archlinux.org/packages/i3lock-color)
* [i3lock-fancy-git](https://aur.archlinux.org/packages/i3lock-fancy-git)
* [mcomix](https://aur.archlinux.org/packages/mcomix)
* [mozc](https://aur.archlinux.org/packages/mozc)
* [ibus-mozc](https://aur.archlinux.org/packages/ibus-mozc)
* [mozc-ut](https://aur.archlinux.org/packages/mozc-ut)
* [ttf-juisee](https://aur.archlinux.org/packages/ttf-juisee) -- This is the font I'd be using
* [xremap-x11-bin](https://aur.archlinux.org/packages/xremap-x11-bin)
* [alttab](https://aur.archlinux.org/packages/alttab)

## Configs

```
export HC="$HOME/.config"
```

### XRemap
```
mv xremap.yml $HC/
sudo gpasswd -a $USER input
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules
echo "uinput" | sudo tee /etc/modules-load.d/uinput.conf
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
```

### DPI settings (for my display)

```
echo 'Xft.dpi: 164' > $HOME/.Xresources
```

### Qtile

```
cp -r qtile $HC/
```

### Mozc
```
mkdir $HC/mozc
cp config1.db $HC/mozc
```

Run `ibus-setup` and select "mozc(あ)" as only input source. 

### Terminal config
```
# alacritty
mkdir $HC/alacritty
cp alacritty.toml $HC/alacritty/
```

### For alttab , add following lines in `/etc/fonts/fonts.conf`
```
<!--
  Font family that can also render Japanese chars
-->
	<match target="pattern">
		<test qual="any" name="family">
			<string>juisee</string>
		</test>
		<edit name="family" mode="assign" binding="same">
			<string>JuiseeSZIS-Regular</string>
		</edit>
	</match>
```

### video group (necessary for brightness control)
```
sudo usermod -a -G video $USER
sudo chgrp video /sys/class/backlight/amdgpu_bl1/brightness
sudo chmod g+w /sys/class/backlight/amdgpu_bl1/brightness
sudo chown root:video /sys/class/leds/chromeos:white:power/brightness
```

### MComix
```
cp -r mcomix $HC/
```

