
{
  description = "Plotter";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        name = "{{ cookiecutter.project_slug }}";
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells = {
          default = pkgs.mkShell { 
            LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib.outPath}/lib:${pkgs.zlib}/lib:${pkgs.portaudio}/lib";
            packages = [ pkgs.python313 pkgs.poetry ]; 
          };
        };
      });
}

