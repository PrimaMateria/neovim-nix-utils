{
  super,
  debug,
}: {
  init = {
    neovimPackage,
    editionsDir,
    editionsSet,
  }: {
    assembleNeovim = {name}:
      super.assembleNeovim {inherit name editionsDir editionsSet neovimPackage;};
  };
}
