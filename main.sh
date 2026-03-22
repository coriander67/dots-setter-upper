echo "welcome to the setup"
echo "copy current config? <1> <0>"
read -r CHOICE
if [ "$CHOICE" -eq 1 ]; then
    #cp -r ~/.config PROFILES/
    echo "enter a name for your current config"
    read NAME
    rsync -av \
        --include="hypr/***"\
        --include="waybar/***"\
        --include="alacritty.toml"\
        --exclude="*"\
        ~/.config/ PROFILES/$NAME
    
    #mv PROFILES/.config PROFILES/""$NAME"_$(date +%m-%d)"
fi
mapfile -t profiles < <(find PROFILES -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
echo "list of all profiles:"
printf '%s\n' "${profiles[@]}"