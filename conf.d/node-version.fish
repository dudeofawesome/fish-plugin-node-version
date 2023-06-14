# Set current working directory history
set --global _node_version_old_cwd (pwd)

# Attach event handlers
functions --query \
  _node_version_on_prompt \
  _node_version_activate
