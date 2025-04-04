# NOTE Made by FKF
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

let
  # add unstable channel declaratively
  unstableTarball = fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";

in
#landmark
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

  ];

  nixpkgs.config = {
    packageOverrides = pkgs: { unstable = import unstableTarball { config = config.nixpkgs.config; }; };
  };

  # Bootloader.

  boot.loader.systemd-boot.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;

  # boot.plymouth = {
  #   enable = true;
  #   theme = "rings";
  #   themePackages = [(pkgs.adi1090x-plymouth-themes.override {selected_themes = ["rings"];})];
  # };
  #
  boot.initrd.verbose = false;

  boot.consoleLogLevel = 0;

  boot.kernelParams = [
    "quiet"
    "udev.log_level=0"
  ];

  networking.hostName = "thonkpad"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  # TODO change it to someplace random next week
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # NOTE enable GNOMEEEEEEE 
  services.xserver.enable = true;

  # services.displayManager.sddm.theme = "catppuccin-sddm";

  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # NOTE Enable the KDE PLASMA LESGOOO Desktop Environment.

  # services.xserver.enable = true; 
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.fish.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # users.users.fkf.shell = pkgs.fish;
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fkf = {
    isNormalUser = true;
    description = "FKF";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "uinput"
      "input"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    vim
    yazi
    unstable.neovim
    bottom
    fish
    git
    # ulauncher
    stow
    polybar
    waybar
    rofi-wayland
    fastfetch
    kitty
    kitty-themes
    kitty-img
    jetbrains-mono
    spotify
    vesktop
    cowsay
    nodejs
    pipx
    zoxide
    gnome.gnome-tweaks
    hugo
    tldr
    fzf
    zellij
    pulseaudioFull
    starship
    eza
    ripgrep
    bat
    less
    wget
    swaybg
    waypaper
    slurp
    grim
    gh
    catppuccin-gtk
    catppuccin-cursors
    catppuccin-papirus-folders
    wl-clipboard
    unzip
    unrar
    github-desktop
    gcc
    clang
    clang-tools
    lua-language-server
    prettierd
    nwg-look
    stylua
    nodePackages.bash-language-server
    nixd
    helix
    brightnessctl
    marksman
    zig
    zls
    rust-analyzer
    bibata-cursors
    prismlauncher
    lxqt.lxqt-policykit
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    # kdePackages.breeze-gtk
    # kdePackages.breeze-icons
    # kdePackages.breeze.qt5
    # kdePackages.breeze
    catppuccin-cursors # Mouse cursor theme
    catppuccin-papirus-folders # Icon theme, e.g. for pcmanfm-qt
    papirus-folders # For the catppucing stuff work
    papirus-folders
    # catppuccin-kde
    # sweet-nova
    # nordic
    nil
    ffmpeg
    obs-studio
    pcmanfm
    lazygit
    swaynotificationcenter
    fd
    vscode
    home-manager
    neovide
    sxiv
    zathura
    mpv
    base16-schemes
    bluez
    bluez-tools
    hyprcursor
    nixd
    nixfmt-rfc-style
    sxiv
    # brave
    unstable.joplin-desktop
    krita
    pinta
    gimp
    blender
    godot_4
    tilix
    wofi
    playerctl
    pipes
    lolcat
    figlet
    emacs
    coreutils
    man-pages
    man-pages-posix
    pavucontrol
    lsp-plugins
    easyeffects
    gnome.gnome-keyring
    zsh

  ];
  # NOTE PackageEnd

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  environment.variables.EDITOR = "vim";
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # environment.variables = {
  #   # This will become a global environment variable
  #  "QT_STYLE_OVERRIDE"="kvantum";
  #     XDG_CURRENT_DESKTOP = "Hyprland";
  #     XDG_SESSION_DESKTOP = "Hyprland";
  #     XDG_SESSION_TYPE = "wayland";
  #     GDK_BACKEND = "wayland";
  #     GTK_USE_PORTAL = "1";
  #     QT_QPA_PLATFORMTHEME = "qt5ct";
  #     QT_QPA_PLATFORM = "wayland";
  #     QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  #     QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  #     MOZ_ENABLE_WAYLAND = "1";
  #
  #
  # };
  #
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      nerdfonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Source Han Serif"
      ];
      sansSerif = [
        "Noto Sans"
        "Source Han Sans"
      ];
    };
  };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
  };

  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  #environment.systemPackages = with pkgs; [bluez5-experimental bluez-tools];
  services.blueman.enable = true;

  services.emacs = {
    enable = true;
    package = pkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    #package = pkgs.bluez5-experimental;
    package = pkgs.bluez;
    settings.Policy.AutoEnable = "true";
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Name = "Hello";
      ControllerMode = "dual";
      FastConnectable = "true";
      Experimental = "true";
      KernelExperimental = "true";
    };
  };

  programs.tmux.enable = true;
  programs.hyprland.enable = true; # enable Hyprland
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
