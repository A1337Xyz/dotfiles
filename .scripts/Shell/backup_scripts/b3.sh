#!/usr/bin/env bash
BKP=~/backup_$(date +%Y%m%d%H).tar.lzma
trap '{ rm -v "$BKP"; exit 1; }' 2
tar --lzma -pcf "$BKP" --numeric-owner \
    --exclude='*__*__*' --exclude='*venv*' --exclude='*.pid' --exclude='*.out' \
    ~/.toprc \
    ~/.xinitrc \
    ~/.scripts \
    ~/.profile \
    ~/.config/bashrc \
    ~/.config/X11 \
    ~/.config/bash_aliases \
    ~/.config/vim \
    ~/.config/i3* \
    ~/.config/cava \
    ~/.config/ranger \
    ~/.config/zsh/.zshrc \
    ~/.config/nnn/plugins \
    ~/.config/mpv/{mpv.conf,input.conf} \
    ~/.config/ncmpcpp/config \
    ~/.config/minidlna \
    ~/.config/nano/nanorc \
    ~/.config/sxhkd/sxhkdrc \
    ~/.config/qutebrowser \
    /etc/sysctl.d \
    /etc/modprobe.d \
    /etc/default/grub 

[ $? -ne 0 ] && { rm -v "$BKP"; exit 1; }
read -r -p "Create a backup of the pacman database? [y/n] " ask
[ "${ask,,}" = 'y' ] && {
    tar -cjf ~/pacman_db.tar.bz2 /var/lib/pacman/local;
    du -sh ~/pacman*.tar*;
}
du -sh "$BKP" 
