list-recipes:
  just --list

path-01 := "./01-simple-live-non-flaked/configuration.nix"
build-01-simple-live-non-flaked: (build-non-flaked path-01)
build-nixos-generators-01-simple-live-non-flaked: (build-nixos-generator-non-flaked path-01)

path-02 := "./02-simple-live-flaked"
build-02-simple-live-flaked: (build-flaked path-02)
build-nixos-generators-02-simple-live-flaked: (build-nixos-generator-flaked path-02)

path-03 := "./03-home-live-non-flaked/configuration.nix"
build-03-home-live-non-flaked: (build-non-flaked path-03)
build-nixos-generators-03-home-live-non-flaked: (build-nixos-generator-non-flaked path-03)
add-home-manager-channel:
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
  nix-channel --update
remove-home-manager-channel:
  nix-channel --remove home-manager

path-04 := "./04-home-live-flaked"
build-04-home-live-flaked: (build-flaked path-04)
build-nixos-generators-04-home-live-flaked: (build-nixos-generator-flaked path-04)

path-05 := "./05-home-broken-live-flaked"
build-05-home-broken-live-flaked: (build-flaked path-05)
build-nixos-generators-05-home-broken-live-flaked: (build-nixos-generator-flaked path-05)

[private]
build-non-flaked nixos-config:
  nix-build "<nixpkgs/nixos>" -A config.system.build.isoImage -I nixos-config={{nixos-config}}

[private]
build-flaked flake-directory configuration-name="liveImage":
  nix build {{flake-directory}}#nixosConfigurations.{{configuration-name}}.config.system.build.isoImage

[private]
build-nixos-generator-flaked flake-directory configuration-name="liveImage":
  nix run nixpkgs#nixos-generators -- --format iso --flake {{flake-directory}}#{{configuration-name}} -o result

[private]
build-nixos-generator-non-flaked nixos-config:
  nix run nixpkgs#nixos-generators -- --format iso --configuration {{nixos-config}} -o result
