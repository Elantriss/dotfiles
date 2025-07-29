#!/usr/bin/env bash

# Selecionar um wallpaper aleatório
NEW_WP=$(ls "$HOME/Pictures/wallpapers" | shuf -n 1)

# Caminho completo do wallpaper
WALLPAPER="$HOME/Pictures/wallpapers/$NEW_WP"

# Caminho do arquivo de configuração
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Limpar o arquivo de configuração do hyprpaper
echo > $HYPRPAPER_CONF

# Mudar o conteúdo de hyprpaper.conf
echo "preload = $WALLPAPER" >> $HYPRPAPER_CONF
echo "wallpaper = , $WALLPAPER" >> $HYPRPAPER_CONF
echo "splash = false" >> $HYPRPAPER_CONF

# Reiniciar o hyprpaper
killall hyprpaper
hyprpaper &