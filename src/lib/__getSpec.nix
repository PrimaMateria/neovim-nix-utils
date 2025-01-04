{super}: {
  name,
  editionsDir,
  editionsSet,
}: let
  hierarchy = super.hierarchy.recurse {inherit name editionsSet;};
in {
  config = super.hierarchy.getConfig {inherit hierarchy editionsDir;};
  plugins = super.hierarchy.getPlugins {inherit hierarchy;};
  runtimeDeps = super.hierarchy.getRuntimeDeps {inherit hierarchy;};
  envVars = super.hierarchy.getEnvVars {inherit hierarchy;};
}
