{self}: {
  name,
  editionsSet,
}:
with builtins; let
  edition = editionsSet.${name};
in
  if edition.manifest ? "basedOn"
  then
    ((self {
        name = edition.manifest.basedOn;
        inherit editionsSet;
      })
      ++ [edition])
  else [edition]
