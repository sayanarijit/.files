# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let

  # Personal Info
  # Stolen from https://github.com/JonathanReeve/dotfiles
  name = "Arijit Basu";
  email = "sayanarijit@gmail.com";
  username = "sayanarijit";
  homedir = "/home/${username}";

  unstable = import <nixpkgs-unstable> { };

  # nnnWithIcons = pkgs.nnn.override { withNerdIcons = true; };

  yarnPkgs = pkgs.yarn2nix-moretea.mkYarnPackage {
    name = "yarnPkgs";
    src = ../files/yarn;
    packageJSON = ../files/yarn/package.json;
    yarnLock = ../files/yarn/yarn.lock;
    publishBinsFor = [
      "diagnostic-languageserver"
      "dockerfile-language-server-nodejs"
      "vim-language-server"
      "vscode-langservers-extracted"
      "yaml-language-server"
      "typescript-language-server"
      "typescript"
      "prettier"
      "@fsouza/prettierd"
      "terser"
      "sql-formatter"
      "vls"
    ];
  };


  pythonWithPkgs = pkgs.python312.withPackages (p: with p; [
    pip
    pynvim
    isort
    black
    mypy
    flake8
    poetry-core
  ]);
in
{
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      /home/sayanarijit/.files/nixos/settings.nix

      # Home manager https://nix-community.github.io/home-manager
      <home-manager/nixos>
    ];

  networking.hostName = "kunai"; # Define your hostname.

  boot.initrd.secrets."/crypto_keyfile.bin" = null;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home-manager.users.sayanarijit.home.stateVersion = "21.03";
}
