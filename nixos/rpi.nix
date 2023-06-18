let
  base = (import ./home.nix { inherit config pkgs; });
in

{
  # ~/.config/nixpkgs/config.nix
  nixpkgs = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # ~/.config/nixpkgs/home.nix
  home = base.home // {
    stateVersion = "23.05";
    packages = with pkgs; [
      vivid
      luarocks
    ];
  };

  # ~/.config/nixpkgs/home.nix
  programs = base.programs;
}
