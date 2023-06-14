function _node_version_get_major_version
  return (echo $argv[1] | cut -c2- | cut -d '.' -f1)
end
