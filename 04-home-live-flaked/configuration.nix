{
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ./home.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "24.05";

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  console.font = "ter-132b";
  console.colors = [
    "1e1e2e" # base
    "181825" # mantle
    "313244" # surface0
    "45475a" # surface1
    "585b70" # surface2
    "cdd6f4" # text
    "f5e0dc" # rosewater
    "b4befe" # lavender
    "f38ba8" # red
    "fab387" # peach
    "f9e2af" # yellow
    "a6e3a1" # green
    "94e2d5" # teal
    "89b4fa" # blue
    "cba6f7" # mauve
    "f2cdcd" # flamingo
  ];
}
