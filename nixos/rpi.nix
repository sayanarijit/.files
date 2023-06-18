{ config, pkgs, ... }:

let
  base = (import ./home.nix { inherit config pkgs; });
in
base // {
  home = base.home // {
    stateVersion = "23.05";
    packages = with pkgs; [
      # vivid
      luarocks
    ];
  };
}
