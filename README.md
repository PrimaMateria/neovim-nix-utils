# neovim-nix-utils

## Description
These are nix utils that help to assemble your own neovim package. Neovim can be
organized into editions with simple inheritance of the configuration.

Blog with tutorial: [https://primamateria.github.io/blog/neovim-editions/](https://primamateria.github.io/blog/neovim-editions/).

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
  - [Editions Directory](#editions-directory)
  - [Editions Set](#editions-set)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Installation

Add following to the flake inputs:

```nix
neovim-nix-utils = {
  url = "github:PrimaMateria/neovim-nix-utils";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
## Usage

```nix   
(neovim-nix-utils.lib.${system}.init {
  neovimPackage = pkgs.neovim;
  editionsDir = ./packages/neovim;
  editionsSet = root.packages.neovim;
}).assembleNeovim { name = "neovimEditionName"}
```

The `init` function takes the following parameters:

- `neovimPackage` - the Neovim package that will be used. The
  Neovim-nightly-overlay package can be passed here. 
- `editionsDir` - is the root directory where all editions are stored. From this
  directory, the configuration files will be loaded.
- `editionsSet` - an attribute set where the attribute key is the name of the edition
  and the attribute value is the edition specification.

The `assembleNeovim` function takes one parameter, and that is a name of the
edition it should assemble. The return value is the Nix package containing
configured neovim.

### Editions Directory

The editions directory contains a subdirectory for each edition that has a
directory named `__config`. Inside the `__config` directory, there can be four
optional directories.

- `lua/` - contains Lua Neovim configuration scripts
- `vim/` - contains Lua Vim configuration scripts
- `luanix/` - contains Nix files, where each is a function that returns a string
  containing Lua Neovim configuration script
- `vimnix/` - contains Nix files, where each is a function that returns a string
  containing Vim Neovim configuration script

### Editions Set 

The editions set contains an attribute for each edition. The value of the
attribute follows the following schema:

```
{
   manifest = { name = "editionName"; basedOn = "parentEdition"; };
   plugins = [ package ];
   dependencies = [ package ];
   dependenciesEnd = [ package ];
   treesitterPlugins = treesitterPlugins: [ package ];
   envVars = {MY_ENV_VAR = "foo";} 
}
```

- `manifest` (required) - edition metadata
  - `name` (required) - name of the edition
  - `basedOn` (optional) - name of the edition from which configuration will be
    inherited
- `plugins` (optional) - list of plugin packages
- `dependencies` (optional) - list of runtime dependencies that will be
  available in Neovim's runtime
- `dependenciesEnd` (optional) - list of Node and Python dependencies (this is a
  workaround for an issue with symlink derivation where Node and Python packages
  must be specified last, otherwise they will be ignored)
- `treesitterPlugins` (optional) - a callback for
  `nixpkgs.vimPlugins.nvim-treesitter.withPlugins`. It is a function that takes
  a parameter, an attribute set with available treesitter plugins, and returns a
  list of chosen treesitter plugins that should be installed.
- `envVars` (optional) - an attribute set where the key is the environment
  variable name and the value is the value. These variables will be passed when
  starting Neovim.


## Contributing
Contributions are welcome. Before doing a major change, please first discuss in
the matrix chat.

## License
Mozilla Public License Version 2.0

## Contact

Matrix room: [#neovim-nix-utils:matrix.primamateria.ddns.net](https://matrix.to/#/#neovim-nix-utils:matrix.primamateria.ddns.net)
