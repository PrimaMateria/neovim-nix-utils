{self}: {
  name,
  editionsSet,
}:
with builtins; let
  edition = editionsSet.${name};
in
  if edition.manifest ? "basedOn"
  then ((self edition.manifest.basedOn) ++ [edition])
  else [edition]
