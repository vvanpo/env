Install with `bash -c "$(curl -fsSL https://raw.githubusercontent.com/vvanpo/env/master/init)"`.

Only run this installer on a new home directory, or to update an existing
installation. The installation will overwrite various dot-files and other
configuration files.

Once installed, you can run `config -l` to see your current configuration.
Commands for `config` are the same as for `git config`. After editing your
configuration to add your own files or overwrite current ones, you just need to
run the installer again (can be done with `config --install`).

For example, to source a script from your `.bashrc`, run
`config --add includes.bashrc.files <path-to-script>` followed by
`config --install`. To ensure one script runs before another, change its order
within your config file (`vi "$PREFIX/etc/$NAME/config"`).

### To do:
- Git-hooks for linting and ctags.
- OS-specific package manager use to install configured list of programs.
- Vundle support.
- Fix symbolic-linking.
- Properly trap errors.
