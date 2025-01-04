{super}: {
  editionsDir,
  editionsSet,
}: {
  assembleNeovim = {name}:
    super.assembleNeovim {inherit name editionsDir editionsSet;};
}
