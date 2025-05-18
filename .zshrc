export PATH=/home/xarnz/.local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/xarnz/Applications/shell:/home/xarnz/bots:/home/xarnz/.cargo/bin

[[ $- != *i* ]] && return


for f in ~/.config/zshrc/*; do
    if [ ! -d $f ]; then
        c=`echo $f | sed -e "s=.config/zshrc=.config/zshrc/custom="`
        [[ -f $c ]] && source $c || source $f
    fi
done


if ! [ -d /mnt/acemany/usr ]; then
    echo "     !!! WARNING !!!       "
    echo "SECOND DISK FAILED TO MOUNT"
    echo "PLEASE RUN try-fix-disk!!! "
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
