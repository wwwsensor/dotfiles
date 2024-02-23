mkdir -p ~/.cache; clear; which $WM >/dev/null && [ "/dev/tty1" = "$(tty)" ] && {

  # $WM found
  pipewire &
  pipewire-pulse &
  dbus-run-session $WM

} >~/.cache/zprofile.log 2>&1 || {

  # $WM not found
  echo .zprofile: $WM not found
  false

}
