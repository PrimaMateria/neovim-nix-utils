{super}:
with builtins;
  {
    hierarchy,
    editionsDir,
  }:
    concatStringsSep "\n" (map (edition:
      super.edition.getConfig {
        inherit edition editionsDir;
      })
    hierarchy)
