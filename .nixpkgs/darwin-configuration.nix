{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.vim
      pkgs.neovim  # vscode replacement
      pkgs.yarn
      pkgs.bat  # cat replacement
      pkgs.lsd  # ls replacement
      pkgs.sysctl
      pkgs.yarn
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
      pkgs.nodejs
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
      pkgs.tmuxPlugins.fzf-tmux-url
    ];

  # https://github.com/NixOS/nixpkgs/issues/5713#issuecomment-69523355

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
# List of plugins
set -g @plugin 'odedlaz/tmux-onedark-theme'
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
# set -g @plugin 'tmux-plugins/tmux-urlview'
set -g @plugin 'wfxr/tmux-fzf-url'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run -b '~/.tmux/plugins/tpm/tpm'

set-option -g mouse on
set -ga terminal-overrides ",xterm-256color:Tc"
# set-option -g prefix C-Space
# bind C-Space send-prefix
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