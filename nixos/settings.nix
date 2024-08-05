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
    src = ./files/yarn;
    packageJSON = ./files/yarn/package.json;
    yarnLock = ./files/yarn/yarn.lock;
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
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "sayanarijit" ];
  };

  boot = {
    # Clean /tmp on reboot
    tmp.cleanOnBoot = true;

    # Bootloader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Kernel
    kernel.sysctl."vm.overcommit_memory" = "1";

    # For Elasticsearch
    kernel.sysctl."vm.max_map_count" = "262144";
  };

  networking = rec {
    # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Manual DNS servers
    nameservers = [
      "1.1.1.1"
      "8.8.4.4"
      "8.8.8.8"
      "9.9.9.9"
    ];

    # Enable networking
    networkmanager = {
      enable = true;
      insertNameservers = nameservers;
    };

    # Disable resolvconf auto update
    resolvconf.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  # Enable the X11 windowing system.

  # Enable the KDE Plasma Desktop Environment.

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    avahi.enable = true;
    # Important to resolve .local domains of printers, otherwise you get an error
    # like  "Impossible to connect to XXX.local: Name or service not known"
    avahi.nssmdns4 = true;

    pcscd.enable = true;

    # Configure keymap in X11
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      desktopManager.plasma5.enable = true;

      # Key repeat
      displayManager.sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 200 50
      '';
    };

    displayManager.sddm = {
      enable = true;
      settings = {
        Autologin = {
          User = "sayanarijit";
          Session = "plasma.desktop";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  # Bluetooth
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;

    # OpenGL
    opengl = {
      enable = true;
      # driSupport = true;
    };



  };

  users.users.sayanarijit = {
    isNormalUser = true;
    description = "Arijit Basu";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" ];
    shell = pkgs.zsh;
    # packages = with pkgs; [
    #   firefox
    # ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      vim
      curl
      # wireshark
    ];

    etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    zsh.enable = true;
    nix-ld.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    # wireshark.enable = true;

    hyprland.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = false;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    docker.enable = true;
  };

  # Security
  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home-manager.users."${username}" = {
    home = {
      username = username;
      homeDirectory = homedir;

      file = {
        ".config/i3/config".source = ./files/i3/config;
        ".config/i3status/config".source = ./files/i3status/config;
        ".config/alacritty/alacritty.yml".source =
          ./files/alacritty/alacritty.yml;
        ".config/wezterm/wezterm.lua".source = ./files/wezterm/wezterm.lua;
        ".config/nvim/lua/options.lua".source = ./files/nvim/lua/options.lua;
        ".config/nvim/lua/plugins.lua".source = ./files/nvim/lua/plugins.lua;
        ".config/nvim/lua/util.lua".source = ./files/nvim/lua/util.lua;
        ".config/nvim/lua/keys.lua".source = ./files/nvim/lua/keys.lua;
        # ".config/xplr/init.lua".source = ./files/xplr/init.lua;
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
        # eza # ls replacement
        # jitsi-meet
        # nnnWithIcons
        # poetry
        # rnix-lsp # Nix language server
        # sc-im # spreadsheet
        # transmission
        # unstable.devbox
        # unstable.wrangler
        # unstable.xplr
        # unstable.youtube-dl
        # zoom-us
        act # Run GitHUb actions locally
        alacritty
        amfora # A fancy terminal browser for the Gemini protocol.
        android-studio
        aria2
        asciinema # Terminal session recorder
        audio-recorder
        awscli2
        bandwhich
        bash-completion
        bat # cat replacement
        bitwarden-cli
        blender
        bottom
        broot
        btop
        cachix
        circleci-cli # CircleCI CLI
        coreutils # GNU coreutils
        curl
        datasette
        discord
        diskonaut
        distrobox
        dmidecode
        dnsutils
        docker-compose
        easyeffects
        elmPackages.elm
        elmPackages.elm-format
        elmPackages.elm-language-server
        elmPackages.elm-live
        elmPackages.elm-test
        exiftool
        fd
        feh
        ffmpeg
        firefox
        fish
        flyctl
        frp
        fselect
        fzf
        gcc
        geckodriver
        gimp
        git
        gitAndTools.gh
        glow
        glxinfo
        gnumake
        gnuplot # benchmark tests
        google-chrome
        google-cloud-sdk
        gpp
        gradle
        graphviz
        helix
        heroku # Heroku CLI
        highlight
        http-prompt
        httpie # curl replacement
        hugo
        hunspell
        hyperfine # A command-line benchmarking tool
        imagemagick
        imgp
        inetutils
        inotify-tools
        irssi
        jf
        jpegoptim
        jq # JSON viewer
        jrnl
        kakoune
        killall
        kitty
        krita
        lazygit # Git TUI
        libreoffice-qt
        lsd # ls replacement
        lshw
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
        nil
        niv # Easy dependency management for Nix projects
        nix-direnv
        nix-index
        nixfmt-classic
        nixpkgs-fmt
        nmap
        nodejs
        nushell
        openapi-generator-cli
        openssl
        ouch
        p11-kit # Terminal colors
        pandoc # File converter
        pass
        peek
        pgcli # postgres cli
        pistol
        pistol
        podman-compose
        pstree
        pueue
        pyright
        pythonWithPkgs
        qrcp
        ranger # A VIM-inspired filemanager for the console
        rdfind
        redis
        ripgrep
        ronn # convert markdown files to manpages
        sd # sed replacement
        shfmt
        simplescreenrecorder
        skim # sk: fzf alternative in rust
        slack
        sqlite
        sshs
        statix
        stylua
        swagger-codegen
        sxiv
        sysctl
        tabbed
        tcpdump
        tdesktop
        texlive.combined.scheme-basic
        tldr
        tmate # Instant terminal sharing
        tor-browser-bundle-bin
        transmission-gtk
        trash-cli
        tree
        tree-sitter
        ttyd
        txt2man
        universal-ctags # Tags creator for vim
        unrar
        unstable.cargo
        unstable.cargo-edit
        unstable.clippy
        unstable.cmake
        unstable.copilot-cli
        unstable.f2
        unstable.lua-language-server
        unstable.mprocs
        unstable.numbat
        unstable.progress
        unstable.qrscan
        unstable.rust-analyzer
        unstable.rustc
        unstable.rustfmt
        unstable.slides
        unstable.vhs
        unstable.yarn
        unstable.zig
        unzip
        upx
        vifm
        vim
        viu
        vivid
        vlc
        vulkan-tools
        wasm-pack
        websocat
        websocketd
        wezterm
        wget
        wrk # Modern HTTP benchmarking tool
        xclip
        xdotool
        xdragon
        xterm
        xz
        yank
        yarnPkgs
        yq # YAML viewer
        zathura
        zip
        zoxide
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

        package = unstable.neovim-unwrapped;

        # See https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix
        plugins = with pkgs.vimPlugins; [
          # cmp-buffer
          # cmp-calc
          # cmp-cmdline
          # cmp-conjure
          # cmp-conventionalcommits
          # cmp-copilot
          # cmp-dictionary
          # cmp-digraphs
          # cmp-emoji
          # cmp-fuzzy-buffer
          # cmp-fuzzy-path
          # cmp-git
          # cmp-neosnippet
          # cmp-nvim-lsp
          # cmp-nvim-lsp-document-symbol
          # cmp-nvim-lsp-signature-help
          # cmp-nvim-lua
          # cmp-nvim-tags
          # cmp-nvim-ultisnips
          # cmp-omni
          # cmp-path
          # cmp-snippy
          # cmp-spell
          # cmp-treesitter
          # cmp-zsh
          # cmp_luasnip
          # comment-nvim
          # diffview-nvim
          # friendly-snippets
          # git-messenger-vim
          # luasnip
          # neoscroll-nvim
          # nginx-vim
          # nnn-vim
          # null-ls-nvim
          # nvim-colorizer-lua
          # nvim-lightbulb
          # nvim-lightbulb
          # nvim-lspconfig
          # nvim-surround
          # nvim-treesitter
          # nvim-treesitter-textobjects
          # nvim-ts-autotag
          # open-browser-github-vim
          # playground
          # registers-nvim
          # splitjoin-vim
          # surround-nvim
          # telescope-nvim
          # vim-expand-region
          # vim-fugitive
          # vim-gitgutter
          # vim-nix
          # vim-protobuf
          # vim-startify
          # vim-test
          # vim-toml
          # which-key-nvim
          packer-nvim
        ];
        extraConfig = ''
          packadd! packer.nvim
          luafile ${./files/nvim/lua/util.lua}
          luafile ${./files/nvim/lua/options.lua}
          luafile ${./files/nvim/lua/plugins.lua}
          luafile ${./files/nvim/lua/keys.lua}
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
        signing = {
          signByDefault = true;
          key = "0F8EF5258DC38077";
        };
        ignores = [ ".DS_Store" "*~" "*.swp" ".null-ls_*.md" ];
        extraConfig.init.defaultBranch = "main";

        # Extensions
        delta.enable = true;
        lfs.enable = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
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

      java = {
        enable = true;
        package = pkgs.jdk11;
      };

      obs-studio = {
        enable = true;
      };

      xplr = {
        enable = true;
        plugins = {
          xpm = pkgs.fetchFromGitHub {
            owner = "dtomvan";
            repo = "xpm.xplr";
            rev = "main";
            sha256 = "sha256-L41RBzOf7YvmYLeeSUQrh6fqMmRxxFR66arLPnty65s=";
          };
        };

        extraConfig = builtins.readFile ./files/xplr/init.lua;
      };
    };
  };
}
