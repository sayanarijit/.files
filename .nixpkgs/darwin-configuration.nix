{ config, pkgs, ... }:

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
      vim
      neovim  # vscode replacement
      bat  # cat replacement
      lsd  # ls replacement
      sysctl
      xz
      thefuck  # fuck: correct previous command
      telnet
      sqlite
      skim  # scim: fzf alternative in rust
      scim  # sk: spreadsheet
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
      ctags  # Tags creator for vim
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
}
