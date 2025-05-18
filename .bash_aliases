alias bye='byedpi -n saldsad -d 2+s -s 25+s -t 4 -a 3 -S -M hdr'

alias v4mindustryserver='java -jar $HOME/appss/mindustry_4.0/server.jar'
alias v4playmindustry='java -jar $HOME/appss/mindustry_4.0/mindustry.jar'
alias gradlew='./gradlew'
alias py='python'
alias matrix='cmatrix -bs'

alias scan-drives='echo 0 0 0 | sudo tee /sys/class/scsi_host/host*/scan'
alias try-fix-disk='scan-drives; system_rc'

alias unproxy='unset all_proxy'


add2path() {
  if ! echo "$PATH" | PATH=$(getconf PATH) grep -Eq '(^|:)'"${1:?missing argument}"'(:|\$)' ; then # Use the POSIX grep implementation
    if [ -d "$1" ]; then # Don't add a non existing directory to the PATH
      if [ "$2" = front ]; then # Use a standard shell test
        PATH="$1:$PATH"
      else
        PATH="$PATH:$1"
      fi
      export PATH
    fi
  fi
}

add2path $HOME/Applications/shell front
add2path $HOME/bots
add2path $HOME/.cargo/bin
add2path $HOME/.local/bin
