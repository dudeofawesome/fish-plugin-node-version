source ./functions/_node_version_get_major_version.fish

@echo _node_version_get_major_version

@echo non-standard "vX.X.X"
@test "parses 'v18'" "$(_node_version_get_major_version v18)" = 18
@test "parses 'v18.0'" "$(_node_version_get_major_version v18.0)" = 18
@test "parses 'v18.0.1'" "$(_node_version_get_major_version v18.0.1)" = 18

@echo basic "X.X.X"
@test "parses '18'" "$(_node_version_get_major_version 18)" = 18
@test "parses '18.0'" "$(_node_version_get_major_version 18.0)" = 18
@test "parses '18.0.1'" "$(_node_version_get_major_version 18.0.1)" = 18

# @echo range ">= X.X.X"
# @test "parses '>= 18'" "$(_node_version_get_major_version '>= 18')" = 18

# @echo range ">= X.X.X < Y.Y.Y"
