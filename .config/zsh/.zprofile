# Always
clear
mkdir -p ~/.cache

# If tty is /dev/tty1
[ "/dev/tty1" = "$(tty)" ] && {

  pipewire &
  pipewire-pulse &
  dbus-run-session $WM

} >~/.cache/zprofile.log 2>&1
