# This is a note over the environment for my Framework Laptop 13inch AMD

## Initial installation settings

## Pacman packages

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

## AUR

* [qtile-extras](https://aur.archlinux.org/packages/qtile-extras)
* [teams](https://aur.archlinux.org/packages/teams)
* [brave-bin](https://aur.archlinux.org/packages/brave-bin)
* [i3lock-color](https://aur.archlinux.org/packages/i3lock-color)
* [i3lock-fancy-git](https://aur.archlinux.org/packages/i3lock-fancy-git)
* [ibus-mozc](https://aur.archlinux.org/packages/ibus-mozc)
* [mcomix](https://aur.archlinux.org/packages/mcomix)
* [mozc-ut](https://aur.archlinux.org/packages/mozc-ut)
* [ttf-juisee](https://aur.archlinux.org/packages/ttf-juisee) -- This is the font I'd be using
* [xremap-x11-bin](https://aur.archlinux.org/packages/xremap-x11-bin)

## Configs

```
export HC="$HOME/.config"
```

### DPI settings (for my display)

```
echo 'Xft.dpi: 164' > $HOME/.Xresources
```

### Qtile

```
cp -r qtile $HC/
```

### XRemap
```
mv xremap.yml $HC/
```

### Mozc
```
mkdir $HC/mozc
cp config1.db $HC/mozc
```

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
sudo chown root:video /sys/class/leds/chromeos:white:power/brightness
```

### MComix
```
cp -r mcomix $HC/
```

