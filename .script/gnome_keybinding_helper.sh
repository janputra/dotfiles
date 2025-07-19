#!/bin/bash

if [[ "$1" == "export" ]] then 
	dconf dump /org/gnome/desktop/wm/keybindings/ > gnome-keybindings.dconf
	dconf dump /org/gnome/settings-daemon/plugins/media-keys/ >> gnome-keybindings.dconf

elif [[ "$1" == "import" ]] then 
	dconf load /org/gnome/desktop/wm/keybindings/ < gnome-keybindings.dconf
	dconf load /org/gnome/settings-daemon/plugins/media-keys/ < gnome-keybindings.dconf
else
	echo "Usage: $0 [export|import]"
	exit 1
fi

