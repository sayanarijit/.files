# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      # Home manager https://nix-community.github.io/home-manager
      <home-manager/nixos>
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "sayanarijit" ];
  };

  boot = {
    # Setup keyfile
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

    # Clean /tmp on reboot
    tmp.cleanOnBoot = true;

    # Bootloader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };

    # Kernel
    kernel.sysctl."vm.overcommit_memory" = "1";

    # For Elasticsearch
    kernel.sysctl."vm.max_map_count" = "262144";
  };

  networking = rec {
    hostName = "katana"; # Define your hostname.
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
  i18n.defaultLocale = "en_IN";

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
    # openssh.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # OpenGL
  hardware.opengl = {
    enable = true;
    # driSupport = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Security
  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sayanarijit = {
    isNormalUser = true;
    description = "Arijit Basu";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" ];
    shell = pkgs.zsh;
    # packages = with pkgs; [
    #   firefox
    # ];
  };

  home-manager.users.sayanarijit = import ./home.nix;

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
