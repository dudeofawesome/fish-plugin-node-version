# Switch Node version if specified in the cwd upon shell launch
function _node_version_activate --on-event _node_version_cwd
    echo "changed working dir to $(pwd)"

    if test -f '.nvmrc' || test -f '.node-version' || begin
            test -f 'package.json'; and [ "$(jq --raw-output '.engines.node' 'package.json')" != null ]
        end

        set version_from_file ""
        if begin
                test -f 'package.json'; and [ "$(jq --raw-output '.engines.node' 'package.json')" != null ]
            end
            set version_from_file "$(jq --raw-output '.engines.node' 'package.json')"
        end
        if test -f '.nvmrc'
            set version_from_file "$(cat '.nvmrc')"
        end
        if test -f '.node-version'
            set version_from_file "$(cat '.node-version')"
        end

        # prefer to use NVM, if installed
        if type -q nvm
            echo (nvm use)
        else if type -q n
            echo (n auto)
            # fall back to Nix
        else if type -q nix || type -q nix-shell
            set major_version_from_file (_node_version_get_major_version "$version_from_file")
            echo "Installing $major_version_from_file using nix or nix-shell"
            set package_name "nodejs_$major_version_from_file"

            # Check if the current node version is acceptable
            set actual_major_version = (_node_version_get_major_version (node --version))
            echo "Actually installing $actual_major_version"
            if test ! "$actual_major_version" -eq "$major_version_from_file"
                # use the new `nix shell` if available
                if type -q nix
                    echo "Using nix shell"
                    nix shell "nixpkgs#$package_name"
                else if type -q nix-shell
                    echo "Using nix-shell"
                    nix-shell -p "$package_name"
                end
                echo "Using Node $(node --version)"
            end
        else
            echo "No Node version management system found! Using $(node --version)."
        end
    end
end
