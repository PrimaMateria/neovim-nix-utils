{super}:
with builtins;
  {
    hierarchy,
    editionsDir,
  }:
    concatStringsSep "\n" (map super.edition.getConfig {
      inherit hierarchy editionsDir;
    })
