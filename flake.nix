{
  description = "neovim editions flake utils";

  outputs = {
    self,
    nixpkgs,
    utils,
    haumea,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in (haumea.lib.load {
        src = ./src;
        inputs = {
          inherit pkgs;
          inherit (pkgs.lib) debug;
        };
        transformer = haumea.lib.transformers.liftDefault;
      })
    );

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
