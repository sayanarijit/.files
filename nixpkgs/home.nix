{ config, pkgs, ... }:
let
  # Personal Info
  # Stolen from https://github.com/JonathanReeve/dotfiles
  name = "Arijit Basu";
  email = "sayanarijit@gmail.com";
  username = "sayanarijit";
  githubUsername = "sayanarijit";
  homedir = "/home/${username}";
  maildir = "${homedir}/Mail";

  vimPlug = builtins.fetchurl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
  # Python LSP requires a dedicated py env.
  pyEnv =
    pkgs.python38.withPackages (ps: with ps; [ pynvim black mypy flake8 jedi ]);

  yarnPkgs = pkgs.yarn2nix-moretea.mkYarnPackage {
    name = "yarnPkgs";
    src = ./files/yarn;
    packageJSON = ./files/yarn/package.json;
    yarnLock = ./files/yarn/yarn.lock;
    publishBinsFor = [
      "bash-language-server"
      "diagnostic-languageserver"
      "dockerfile-language-server-nodejs"
      "vim-language-server"
      "vscode-css-languageserver-bin"
      "vscode-html-languageserver-bin"
      "vscode-json-languageserver"
      "yaml-language-server"
      "typescript-language-server"
    ];
  };

in
{

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = homedir;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  accounts.email = {
    maildirBasePath = "${maildir}";
    accounts = {
      gmail = {
        address = "${email}";
        userName = "${email}";
        flavor = "gmail.com";
        passwordCommand = "${pkgs.pass}/bin/pass gmail";
        primary = true;
        mbsync = {
          enable = true;
          expunge = "both";
          patterns = [ "*" "![Gmail]*" "[Gmail]/Sent Mail" ];
        };
        realName = "Arijit Basu";
      };
    };
  };

  home.file = {
    ".config/alacritty/alacritty.yml".source = ./files/alacritty/alacritty.yml;
    ".config/tmuxinator/kai.yml".source = ./files/tmuxinator/kai.yml;
    ".config/nvim/init.vim".source = ./files/nvim/init.vim;
    ".vim/autoload/plug.vim".source = vimPlug;
    ".local/bin/ftwind" = {
      source = ./files/bin/ftwind;
      executable = true;
    };
  };

  home.packages = with pkgs; [
    pyEnv
    yarnPkgs
    niv # Easy dependency management for Nix projects
    # neovim  # Using nightly for now
    bat # cat replacement
    lsd # ls replacement
    sysctl
    xz
    thefuck # fuck: correct previous command
    telnet
    sqlite
    skim # sk: fzf alternative in rust
    scim # spreadsheet
    readline
    pgcli # postgres cli
    mycli # mysql cli
    pandoc # File converter
    p11-kit # Terminal colors
    openssl
    nnn # Terminal file browser
    cachix
    ncdu # Disk utilization viewer
    jq # JSON viewer
    httpie # curl replacement
    heroku # Heroku CLI
    findutils # find replacement for mac
    universal-ctags # Tags creator for vim
    coreutils # GNU coreutils
    circleci-cli # CircleCI CLI
    bash-completion
    asciinema # Terminal session recorder
    ngrok
    tldr
    unrar
    curl
    yarn
    nodejs
    fzf
    aria2
    alacritty
    gitAndTools.gh
    jpegoptim
    pstree
    ffmpeg
    nix-direnv
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-language-server
    elmPackages.elm-format
    # fzf-tab-completion
    lua
    luarocks
    act # Run GitHUb actions locally
    tmate # Instant terminal sharing
    lazygit # Git TUI
    hyperfine # A command-line benchmarking tool
    wrk #  Modern HTTP benchmarking tool
    geckodriver
    openjdk11
    maven
    # openapi-generator-cli-unstable
    # mpv
    gcc
    nixpkgs-fmt
    rnix-lsp # Nix language server
    docker-compose
  ];

  programs = {
    mbsync = { enable = true; };
    direnv = { enable = true; };

    tmux = {
      enable = true;
      tmuxp = { enable = true; };
      tmuxinator = { enable = true; };
      plugins = with pkgs; [
        tmuxPlugins.fzf-tmux-url
        tmuxPlugins.fpp
        tmuxPlugins.gruvbox
        tmuxPlugins.resurrect
        tmuxPlugins.copycat
      ];
      extraConfig = builtins.readFile ./files/tmux.conf;
    };

    git = {
      enable = true;
      userName = username;
      userEmail = name;
      signing = {
       key = "A3585E2E7A6EE457";
      };
      delta = {
        enable = true;
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      initExtra = builtins.readFile ./files/zshrc;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "python"
        ];
      };
    };
  };
}