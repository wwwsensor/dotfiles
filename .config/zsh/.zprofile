# Always
clear
mkdir -p ~/.cache

# If tty is /dev/tty1
[ "/dev/tty1" = "$(tty)" ] && which $WM >/dev/null 2>&1 && {

  pipewire &
  pipewire-pulse &
  dbus-run-session $WM

} >~/.cache/zprofile.log 2>&1
