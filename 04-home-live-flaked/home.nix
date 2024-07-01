{ pkgs, home-manager, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];
  home-manager = let
    username = "nixos";
  in {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = { pkgs, osConfig, ... }: {
      home.stateVersion = osConfig.system.stateVersion;
      home.username = username;
      home.homeDirectory = "/home/${username}";

      home.packages = with pkgs; [
        jq
        fzf
        curl
        # ...
      ];
      # ...
    };
  };
}
