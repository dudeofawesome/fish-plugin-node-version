function _node_version_get_major_version \
    --description "Gets the highest possible major version from a given input"

    set input (string trim "$argv[1]" | string trim --left --chars=v)

    if string match -eq '.' "$input"
        # the string has some dot notation
        if string match -rq '^(\d+)(\.\d+)?(\.\d)?$' "$input"
            echo (string match -rg '^(\d+)\.' "$input")
        else
            echo "Woah woah woah, getting fancy now are we?"
            exit 1
        end
    else
        echo "$input"
    end
end
