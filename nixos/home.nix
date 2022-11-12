{ config, pkgs, ... }:
let
  # Personal Info
  # Stolen from https://github.com/JonathanReeve/dotfiles
  name = "Arijit Basu";
  email = "sayanarijit@gmail.com";
  username = "sayanarijit";
  homedir = "/home/${username}";

  unstable = import <nixpkgs-unstable> { };

  nnnWithIcons = pkgs.nnn.override { withNerdIcons = true; };

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
      "vscode-langservers-extracted"
      "yaml-language-server"
      "typescript-language-server"
      "svelte-language-server"
      "typescript"
      "prettier"
      "@fsouza/prettierd"
      "terser"
      "sql-formatter"
      "@prisma/language-server"
      "graphql-language-service-cli"
    ];
  };


  pythonWithPkgs = pkgs.python310.withPackages (p: with p; [
    pip
    pynvim
    isort
    black
    mypy
    flake8
  ]);

in
{

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = username;
    homeDirectory = homedir;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "21.03";

    file = {
      ".config/i3/config".source = ./files/i3/config;
      ".config/i3status/config".source = ./files/i3status/config;
      ".config/alacritty/alacritty.yml".source =
        ./files/alacritty/alacritty.yml;
      ".config/wezterm/wezterm.lua".source = ./files/wezterm/wezterm.lua;
      ".config/nvim/lua/plugins.lua".source = ./files/nvim/lua/plugins.lua;
      ".config/nvim/lua/options.lua".source = ./files/nvim/lua/options.lua;
      ".config/nvim/lua/util.lua".source = ./files/nvim/lua/util.lua;
      ".config/nvim/lua/keys.lua".source = ./files/nvim/lua/keys.lua;
      ".config/xplr/init.lua".source = ./files/xplr/init.lua;
      ".config/xplr/plugins/fennel.lua".source = ./files/xplr/plugins/fennel.lua;
      ".gnupg/gpg.conf".source = ./files/gnupg/gpg.conf;
      ".newsboat/urls".source = ./files/newsboat/urls;
      ".local/bin/ftwind" = {
        source = ./files/bin/ftwind;
        executable = true;
      };
      ".local/bin/lipsum" = {
        source = ./files/bin/lipsum;
        executable = true;
      };
      ".local/bin/elmtags.py" = {
        source = ./files/bin/elmtags.py;
        executable = true;
      };
    };

    packages = with pkgs; [
      # jitsi-meet
      # zoom-us
      act # Run GitHUb actions locally
      amfora
      amfora # A fancy terminal browser for the Gemini protocol.
      aria2
      asciinema # Terminal session recorder
      bandwhich
      bash-completion
      bat # cat replacement
      bitwarden-cli
      bottom
      bpytop
      broot
      cachix
      circleci-cli # CircleCI CLI
      coreutils # GNU coreutils
      curl
      discord
      diskonaut
      dnsutils
      docker-compose
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.elm-language-server
      elmPackages.elm-live
      elmPackages.elm-test
      exa # ls replacement
      exiftool
      feh
      ffmpeg
      firefox
      fselect
      fzf
      gcc
      geckodriver
      gitAndTools.gh
      glow
      gnumake
      gnuplot # benchmark tests
      google-chrome
      gpp
      gradle
      helix
      heroku # Heroku CLI
      http-prompt
      httpie # curl replacement
      hugo
      hyperfine # A command-line benchmarking tool
      imgp
      inetutils
      inotify-tools
      irssi
      jpegoptim
      jq # JSON viewer
      jrnl
      kakoune
      killall
      lazygit # Git TUI
      lsd # ls replacement
      luajit
      luarocks
      massren
      maven
      mdbook
      mmv-go
      mpv
      navi
      ncdu # Disk utilization viewer
      neofetch
      netcat
      newsboat
      ngrok
      niv # Easy dependency management for Nix projects
      nix-direnv
      nixfmt
      nixpkgs-fmt
      nnnWithIcons
      nodejs-16_x
      openapi-generator-cli-unstable
      openssl
      p11-kit # Terminal colors
      pandoc # File converter
      pass
      peek
      pgcli # postgres cli
      pistol
      pistol
      podman-compose
      poetry
      pstree
      pueue
      pythonWithPkgs
      ranger # A VIM-inspired filemanager for the console
      rdfind
      redis
      ripgrep
      rnix-lsp # Nix language server
      rust-analyzer
      sc-im # spreadsheet
      sd # sed replacement
      skim # sk: fzf alternative in rust
      slack
      sqlite
      sxiv
      sysctl
      tabbed
      tdesktop
      tldr
      tmate # Instant terminal sharing
      trash-cli
      tree
      tree-sitter
      universal-ctags # Tags creator for vim
      unrar
      unstable.cargo
      unstable.mprocs
      unstable.progress
      unstable.rustc
      unstable.clippy
      unstable.vhs
      unstable.wezterm
      unstable.xplr
      unstable.zig
      upx
      vifm
      vim
      websocat
      websocketd
      wget
      wrk # Modern HTTP benchmarking tool
      xclip
      xdotool
      xdragon
      xterm
      xz
      yank
      yarn
      yarnPkgs
      youtube-dl
      yq # YAML viewer
      zathura
      zsh-syntax-highlighting
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ packer-nvim ];
      extraConfig = ''
        packadd! packer.nvim
        luafile ${./files/nvim/lua/plugins.lua}
        luafile ${./files/nvim/lua/options.lua}
        luafile ${./files/nvim/lua/keys.lua}
        luafile ${./files/nvim/lua/util.lua}
      '';
    };

    tmux = {
      enable = true;
      # tmuxp = { enable = true; };
      tmuxinator = { enable = true; };
      plugins = with pkgs.tmuxPlugins; [
        fzf-tmux-url
        fpp
        gruvbox
        resurrect
        copycat
      ];
      extraConfig = builtins.readFile ./files/tmux.conf;
    };

    git = {
      enable = true;
      userName = name;
      userEmail = email;
      extraConfig = { init = { defaultBranch = "main"; }; };
      signing = {
        signByDefault = true;
        key = "0F8EF5258DC38077";
      };
      delta = { enable = true; };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      initExtra = builtins.readFile ./files/zshrc;
      initExtraBeforeCompInit = ''
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      '';
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "python" ];
      };
    };
  };
}
