# Always
clear
mkdir -p ~/.cache

[ "/dev/tty1" = "$(tty)" ] &&
which $WM >/dev/null 2>&1 &&
{
  # WM found
  pipewire &
  pipewire-pulse &
  dbus-run-session $WM &
  return 0
} >~/.cache/zprofile.log 2>&1 ||
{
  # WM not found
  echo .zprofile: $WM not found
  return 1
}
