umask 022

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
  for profile in /etc/profile.d/*.sh; do
    test -r "$profile" && . "$profile"
  done
  unset profile
fi

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 > /dev/null && startx

