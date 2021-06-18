# === === === BASH PROFILE === === === #
SHELL_PROFILE="$HOME/.shell_profile"
if [ -f "$SHELL_PROFILE" ]; then
  # shellcheck source=../profile.shell
  . "$SHELL_PROFILE"
fi
