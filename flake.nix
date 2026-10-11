{
  description = "Portable Neovim development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = builtins.currentSystem;
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      pkgs = import nixpkgs { inherit system; };
    in
    assert builtins.elem system supportedSystems;
    assert username != "" && homeDirectory != "";
    {
      apps = builtins.listToAttrs (map
        (supportedSystem: {
          name = supportedSystem;
          value.home-manager = {
            type = "app";
            program = "${home-manager.packages.${supportedSystem}.default}/bin/home-manager";
            meta.description = "Apply the portable Neovim Home Manager profile";
          };
        })
        supportedSystems);

      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./nix/home.nix
          {
            home.username = username;
            home.homeDirectory = homeDirectory;
          }
        ];
      };
    };
}
