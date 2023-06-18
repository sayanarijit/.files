let
  base = (import ./home.nix { inherit config pkgs; });
in

base // {
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    vivid
    luarocks
  ];
}
