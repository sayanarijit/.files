{ config, pkgs, ... }:

let
  # Let's use the nightly build for native LSP support.
  nvim-nightly = pkgs.stdenv.mkDerivation {
    name = "nvim-nightly";
    src = pkgs.fetchurl {
      url = "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz";
      sha256 = "1ckf02gbalb7hd62bx2rx387j0cdjff2cyfmgg1jqxn2mbjzxr7b";
    };
    phases = ["installPhase" "patchPhase"];
    installPhase = ''
      tar xzvf $src
      mkdir -p $out
      mv nvim-osx64/* $out/
    '';
  };

  # Python LSP requires a dedicated py env.
  pyEnv = pkgs.python38.withPackages (
    ps: with ps; [
      pynvim
      black
      mypy
      flake8
    ]
  );

  # Some language servers and global nodejs tools.
  yarnPkgs = pkgs.yarn2nix-moretea.mkYarnPackage {
    name = "yarnPkgs";
    src = ./yarn;
    packageJSON = ./yarn/package.json;
    yarnLock = ./yarn/yarn.lock;
    publishBinsFor = [
      "bash-language-server"
      "diagnostic-languageserver"
      "dockerfile-language-server-nodejs"
      "vim-language-server"
      "vscode-css-languageserver-bin"
      "vscode-html-languageserver-bin"
      "vscode-json-languageserver"
      "yaml-language-server"
    ];
  };

  # Make zsh's tab completion even better
  fzf-tab-completion = pkgs.fetchFromGitHub { 
     owner = "lincheney"; 
     repo = "fzf-tab-completion"; 
     rev= "a39091b6e903d34c53f5f259c6b66c40069c7986";
     sha256= "0df77k339im84z8x49q56s26bircyyn9dasz0s1xxb7q29dxix7z";
  };

in
{
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 1;
  nix.buildCores = 1;
  nix.useDaemon = false;
  nix.useSandbox = false;

  # Allow licensed binaries
  nixpkgs.config.allowUnfree = true;

  # make sure firewall is up & running
  system.defaults.alf.globalstate = 1;
  system.defaults.alf.stealthenabled = 1;

  # Personalization
  networking.hostName = "saber";
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "right";
  system.defaults.dock.tilesize = 0;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.loginwindow.GuestEnabled = true;
  system.defaults.trackpad.FirstClickThreshold = 0;
  system.defaults.trackpad.SecondClickThreshold = 0;
  system.keyboard.enableKeyMapping = true;
  # system.defaults.screencapture.disable-shadow = true;
  system.keyboard.remapCapsLockToEscape = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
      niv  #  Easy dependency management for Nix projects
      # neovim  # vscode replacement (I'll use the HEAD for now)
      nvim-nightly
      pyEnv  # Custom python env with language servers and tools
      yarnPkgs  # Global nodejs tools
      bat  # cat replacement
      lsd  # ls replacement
      sysctl
      xz
      thefuck  # fuck: correct previous command
      telnet
      sqlite
      skim  # sk: fzf alternative in rust
      scim  # spreadsheet
      readline
      pgcli  # postgres cli
      pandoc  # File converter
      p11-kit  # Terminal colors
      openssl
      nnn  # Terminal file browser
      cachix
      ncdu  # Disk utilization viewer
      jq  # JSON viewer
      httpie  # curl replacement
      heroku  # Heroku CLI
      git
      findutils  # find replacement for mac
      direnv  # ENV loader for projects
      universal-ctags  # Tags creator for vim
      coreutils  # GNU coreutils
      circleci-cli  # CircleCI CLI
      bash-completion
      asciinema  # Terminal session recorder
      ngrok
      gitAndTools.diff-so-fancy
      tldr
      unrar
      curl
      yarn
      nodejs
      fzf
      aria2
      tmuxinator
      tmuxPlugins.fzf-tmux-url
      tmuxPlugins.fpp
      tmuxPlugins.gruvbox
      tmuxPlugins.resurrect
      tmuxPlugins.copycat
      alacritty
      bandwhich
      gitAndTools.delta
      jpegoptim
      pstree
      ffmpeg
      nix-direnv
      elmPackages.elm
      elmPackages.elm-test
      elmPackages.elm-language-server
      elmPackages.elm-format
      starship  # oh-my-zsh replacement for speed
      zsh-autosuggestions  # No need of fish shell with this around
      oh-my-zsh  # Only for some selected plugins
      fzf-tab-completion
    ];

    # FiraCode font has everything a modern terminal needs.
    fonts = {
      enableFontDir = true;
      fonts = with pkgs; [
        (nerdfonts.override {
          fonts = [ 
            "FiraCode"
          ];
        })
      ];
    };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;

    # This makes the fzf-tab-completion work
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;

    # Disable the unnecessary prompt.
    promptInit = "";

    # Try keeping it to a bare minimun (don't want to inherit the oh-my-zsh slowness)
    interactiveShellInit = ''
      [ -f ~/.profile ] && source ~/.profile
      autoload -Uz compinit && compinit -i

      source ${fzf-tab-completion}/zsh/fzf-zsh-completion.sh
      source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"
    '';
  };
  
  # tmux + alacritty > iterm2
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -s escape-time 0
      set -g status-interval 5
      set -g status-keys emacs
      set -g focus-events on
      set -g history-limit 50000
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      setw -g aggressive-resize on

      set-option -g mouse on

      # set-option -g prefix C-Space
      # bind C-Space send-prefix

      bind-key C-b run -b ftwind  # ~/.bin/ftwind

      bind-key C-h select-pane -L
      bind-key C-j select-pane -D
      bind-key C-k select-pane -U
      bind-key C-l select-pane -R

      run-shell ${pkgs.tmuxPlugins.fzf-tmux-url}/share/tmux-plugins/fzf-tmux-url/fzf-url.tmux
      run-shell ${pkgs.tmuxPlugins.fpp}/share/tmux-plugins/fpp/fpp.tmux
      run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
      run-shell ${pkgs.tmuxPlugins.copycat}/share/tmux-plugins/copycat/copycat.tmux
      run-shell ${pkgs.tmuxPlugins.gruvbox}/share/tmux-plugins/gruvbox/gruvbox-tpm.tmux
    '';
  };

  services.yabai = {
    package = pkgs.yabai;
    enable = true;
    enableScriptingAddition = false;
    config = {
      focus_follows_mouse          = "autoraise";
      mouse_follows_focus          = "off";
      window_placement             = "second_child";
      window_opacity               = "off";
      window_opacity_duration      = "0.0";
      window_border                = "on";
      window_border_placement      = "inset";
      window_border_width          = 0;
      window_border_radius         = 0;
      active_window_border_topmost = "on";
      window_topmost               = "on";
      window_shadow                = "float";
      active_window_border_color   = "0xff5c7e81";
      normal_window_border_color   = "0xff505050";
      insert_window_border_color   = "0xffd75f5f";
      active_window_opacity        = "1.0";
      normal_window_opacity        = "1.0";
      split_ratio                  = "0.50";
      auto_balance                 = "on";
      mouse_modifier               = "fn";
      mouse_action1                = "move";
      mouse_action2                = "resize";
      layout                       = "bsp";
      top_padding                  = 0;
      bottom_padding               = 0;
      left_padding                 = 0;
      right_padding                = 0;
      window_gap                   = 5;
    };

    extraConfig = ''
      # rules
      yabai -m rule --add app='System Preferences' manage=off
    '';
  };

  services.skhd = {
    package = pkgs.skhd;
    enable = true;
    skhdConfig = ''
      # focus window
      shift + cmd - left : yabai -m window --focus west || yabai -m display --focus prev
      shift + cmd - down : yabai -m window --focus south
      shift + cmd - up : yabai -m window --focus north
      shift + cmd - right : yabai -m window --focus east || yabai -m display --focus next

      # move window
      shift + cmd - h : yabai -m window --warp west || { yabai -m window --display prev && yabai -m display --focus prev }
      shift + cmd - j : yabai -m window --warp south
      shift + cmd - k : yabai -m window --warp north
      shift + cmd - l : yabai -m window --warp east || { yabai -m window --display next && yabai -m display --focus next }

      # balance size of windows
      shift + cmd - 0 : yabai -m space --balance

      # toggle window split type
      shift + cmd - space : yabai -m window --toggle split

      # toggle zoom fullscreen
      shift + cmd - return : yabai -m window --toggle zoom-fullscreen

      # resize windows
      shift + cmd - u : yabai -m window --resize right:-50:0 || { yabai -m window --resize left:50:0 }
      shift + cmd - i : yabai -m window --resize bottom:0:-50 || { yabai -m window --resize top:0:50 }
      shift + cmd - o : yabai -m window --resize bottom:0:50 || { yabai -m window --resize top:0:-50 }
      shift + cmd - p : yabai -m window --resize right:50:0 || { yabai -m window --resize left:-50:0 }
    '';
  };
}
