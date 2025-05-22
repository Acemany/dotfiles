export PATH=$HOME/.local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/xarnz/Applications/shell:/home/xarnz/bots:/home/xarnz/.cargo/bin

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi


[[ $- != *i* ]] && return

if ! [ -d /mnt/acemany/usr ] && [ -d /mnt/acemany ]; then
  echo "     !!! WARNING !!!       "
  echo "SECOND DISK FAILED TO MOUNT"
  echo "PLEASE RUN try-fix-disk!!! "
fi


for f in ~/.config/zshrc/*; do
    if [ ! -d $f ]; then
        c=`echo $f | sed -e "s=.config/zshrc=.config/zshrc/custom="`
        [[ -f $c ]] && source $c || source $f
    fi
done
