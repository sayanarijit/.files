{ config, pkgs, ... }:

{
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
  environment.systemPackages =
    [
      pkgs.vim
      pkgs.neovim  # vscode replacement
      pkgs.bat  # cat replacement
      pkgs.lsd  # ls replacement
      pkgs.sysctl
      pkgs.xz
      pkgs.thefuck  # fuck: correct previous command
      pkgs.telnet
      pkgs.sqlite
      pkgs.skim  # scim: fzf alternative in rust
      pkgs.scim  # sk: spreadsheet
      pkgs.readline
      pkgs.pgcli  # postgres cli
      pkgs.pandoc  # File converter
      pkgs.p11-kit  # Terminal colors
      pkgs.openssl
      pkgs.nnn  # Terminal file browser
      pkgs.cachix
      pkgs.ncdu  # Disk utilization viewer
      pkgs.jq  # JSON viewer
      pkgs.httpie  # curl replacement
      pkgs.heroku  # Heroku CLI
      pkgs.git
      pkgs.findutils  # find replacement for mac
      pkgs.direnv  # ENV loader for projects
      pkgs.ctags  # Tags creator for vim
      pkgs.coreutils  # GNU coreutils
      pkgs.circleci-cli  # CircleCI CLI
      pkgs.bash-completion
      pkgs.asciinema  # Terminal session recorder
      pkgs.ngrok
      pkgs.gitAndTools.diff-so-fancy
      pkgs.tldr
      pkgs.unrar
      pkgs.curl
      pkgs.yarn
      pkgs.nodejs
      pkgs.fzf
      pkgs.tmuxPlugins.fzf-tmux-url
      pkgs.tmuxPlugins.fpp
      pkgs.tmuxPlugins.resurrect
      pkgs.alacritty
      pkgs.bandwhich
      pkgs.gitAndTools.delta
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.bash.enable = true;
  programs.zsh.enable = true;
  # programs.fish.enable = true;
  
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -s escape-time 0
      set -g status-interval 5
      set -g utf8 on
      set -g default-command "reattach-to-user-namespace -l $SHELL"
      set -g status-keys emacs
      set -g focus-events on
      set -g status-utf8 on
      set -g history-limit 50000
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      setw -g aggressive-resize on
      
      set-option -g mouse on
      
      # set-option -g prefix C-Space
      # bind C-Space send-prefix

      run-shell ${pkgs.tmuxPlugins.fzf-tmux-url}/share/tmux-plugins/fzf-tmux-url/fzf-url.tmux
      run-shell ${pkgs.tmuxPlugins.fpp}/share/tmux-plugins/fpp/fpp.tmux
      run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 1;
  nix.buildCores = 1;
  nix.useDaemon = false;
  nix.useSandbox = false;
}
