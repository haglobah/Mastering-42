{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devenv-up = self.devShells.x86_64-linux.default.config.procfileScript;

      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = [
                    # pkgs.bash-completion
                  ];

                  languages = {
                    racket = {
                      enable = true;
                      package = pkgs.racket;
                    };
                  };

                  enterShell = ''
                    racket --version
                  '';

                  processes.pollen.exec = "raco pollen start";
                }
              ];
            };
          });
    };
}
