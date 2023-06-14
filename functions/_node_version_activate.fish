# Switch Node version if specified in the cwd upon shell launch
function _node_version_activate --on-event _node_version_cwd
  echo "changed working dir to $(pwd)"

  if test -f '.nvmrc' || test -f '.node-version'
    set version_from_file ""
    if test -f '.nvmrc'; set version_from_file "$(cat '.nvmrc')"; end
    if test -f '.node-version'; set version_from_file "$(cat '.node-version')"; end

    # prefer to use NVM, if installed
    if type -q nvm
      echo (nvm use)
    else if type -q n
      echo (n auto)
    # fall back to Nix
    else if type -q nix || type -q nix-shell
      # TODO: actually get only the major version
      set major_version_from_file "$version_from_file"
      set package_name "nodejs_$major_version_from_file"
      # BUG: this causes an infinite loop of entering new nix-shells
      # Look in to using $SHLVL maybe?
      # https://github.com/NixOS/nix/issues/6677
      # if [ test -n "$IN_NIX_SHELL" ] or test "$SHLVL" -lte 2
      # Maybe a better strategy is to check if the node version is acceptable
      set actual_major_version = (node --version | cut -c2- | cut -d '.' -f1)
      if test "$actual_major_version" -neq "$major_version_from_file"
        if type -q nix
          nix shell "nixpkgs#$package_name"
        else if type -q nix-shell
          nix-shell -p "$package_name"
        end
        echo "Using Node $(node --version)"
      end
    else
      echo "No Node version management system found! Using $(node --version)."
    end
  end
end
