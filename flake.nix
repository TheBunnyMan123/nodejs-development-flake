{
  description = "A dev environment for Figura";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        system = "${system}";
      };
    in {
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          bashInteractive
          (vscode-with-extensions.override {
            vscode = vscodium;
            vscodeExtensions = with vscode-extensions; [
              sumneko.lua
            ];
          })

          nodePackages.nodejs
          nodePackages.nodemon
          nodePackages.ts-node
        ];

        shellHook = ''
          exec codium .
        '';
      };
    }
  );
}
