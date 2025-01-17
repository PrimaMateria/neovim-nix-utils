{root}: {hierarchy}:
with builtins; let
  dependencies = concatMap (edition:
    if edition ? dependencies
    then edition.dependencies
    else [])
  hierarchy;

  # https://ertt.ca/blog/2022/01-12-nix-symlinkJoin-nodePackages/
  dependenciesEnd = concatMap (edition:
    if edition ? dependenciesEnd
    then edition.dependenciesEnd
    else [])
  hierarchy;
in
  # Create a derivation that aggregates symlinks of all runtime dependencies
  # from the list.
  root.lib.joinRuntimeDeps {
    dependencies = dependencies ++ dependenciesEnd;
  }
