{
  description = "devshell for heywoodlh actions";

  inputs.nixos-configs.url = "git+https://tangled.org/heywoodlh.io/nixos-configs";

  outputs = {
    self,
    nixos-configs,
  }:
    nixos-configs.inputs.flake-utils.lib.eachDefaultSystem (system: let
      nixpkgs = nixos-configs.inputs.nixpkgs;
      pkgs = nixpkgs.legacyPackages.${system};
      tangled-sync = nixos-configs.packages.${system}.tangled-sync;
    in {
      devShell = pkgs.mkShell {
        name = "heywoodlh.io shell";
        buildInputs = with pkgs; [
          yaml-language-server
          yamlfmt
        ];
        shellHook = ''
          ${tangled-sync}/bin/tangled-sync.sh
        '';
      };

      formatter = pkgs.alejandra;
    });
}
