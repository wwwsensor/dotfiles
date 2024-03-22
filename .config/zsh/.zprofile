# Notable variables
N>/dev/null

# Always
mkdir -p ~/.cache
clear

# If tty is /dev/tty1
[ "/dev/tty1" = "$(tty)" ] && {

if [ which $WM >$N 2>&1 ]; then
  {

    # If $WM found
    pipewire &
    pipewire-pulse &
    dbus-run-session $WM

  } >~/.cache/zprofile.log 2>&1
else

    # If $WM not found
    echo .zprofile: $WM not found
    false

fi

}
