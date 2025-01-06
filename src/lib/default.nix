{
  super,
  debug,
}: {
  init = {
    editionsDir,
    editionsSet,
  }: {
    assembleNeovim = {name}:
      super.assembleNeovim (debug.traceVal {inherit name editionsDir editionsSet;});
  };
}
