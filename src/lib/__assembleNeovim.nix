{
  pkgs,
  root,
  super,
}: {
  name,
  editionsDir,
  editionsSet,
  neovimPackage,
}: let
  spec = super.getSpec {
    inherit name editionsDir editionsSet;
  };

  # Configure neovim with the RC and with the plugins list
  configuredNeovim = pkgs.wrapNeovim neovimPackage {
    configure = {
      customRC = spec.config;
      packages.all.start = spec.plugins;
    };
  };
in
  # Create a shell application that runs Neovim with the specified runtime
  # dependencies and environment variables.
  pkgs.writeShellApplication {
    name = "nvim-${name}";
    runtimeInputs = [spec.runtimeDeps];

    text = ''
      NVIM_SELF=${configuredNeovim}/bin/nvim \
      ${spec.envVars} ${configuredNeovim}/bin/nvim "$@"
    '';
  }
