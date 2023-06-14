function _node_version_on_prompt --on-event fish_prompt
  if [ "$_node_version_old_cwd" != "$(pwd)" ]
    set --global _node_version_old_cwd (pwd)
    emit _node_version_cwd
  end
end
