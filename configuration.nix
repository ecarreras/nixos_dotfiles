# Edit this configuration file which defines what would be installed on the
# system.  To Help while choosing option value, you can watch at the manual
# page of configuration.nix or at the last chapter of the manual available
# on the virtual console 8 (Alt+F8).

{config, pkgs, ...}:

{
  require = [
    # Include the configuration for part of your system which have been
    # detected automatically.
    ./hardware-configuration.nix
    ./nixos/modules/programs/virtualbox.nix
  ];

  boot.initrd.kernelModules = [
    # Specify all kernel modules that are necessary for mounting the root
    # file system.
    #
    "ext4" 
    #"ata_piix"
  ];

  boot.loader.grub = {
    # Use grub 2 as boot loader.
    enable = true;
    version = 2;

    # Define on which hard drive you want to install Grub.
    device = "/dev/sda";
  };

  boot.blacklistedKernelModules = [ "pcspkr" ];

  networking = {
    hostName = "nixos"; # Define your hostname.
    wireless.enable = true;  # Enables Wireless.
    wireless.interfaces = [ "wlan0" ];
    wireless.userControlled.enable = true;
  };

  # Add file system entries for each partition that you want to see mounted
  # at boot time.  You can add filesystems which are not mounted at boot by
  # adding the noauto option.
  fileSystems = [
    # Mount the root file system
    #
    { mountPoint = "/";
       device = "/dev/sda2";
       fsType = "ext4";
    }

    # Copy & Paste & Uncomment & Modify to add any other file system.
    #
    # { mountPoint = "/data"; # where you want to mount the device
    #   device = "/dev/sdb"; # the device or the label of the device
    #   # label = "data";
    #   fsType = "ext3";      # the type of the partition.
    #   options = "data=journal";
    # }
  ];

  swapDevices = [
    # List swap partitions that are mounted at boot time.
    #
    { device = "/dev/sda1"; }
  ];

  # Select internationalisation properties.
   i18n = {
  #   consoleFont = "lat9w-16";
     consoleKeyMap = "qwerty/es";
     defaultLocale = "ca_ES.UTF-8";
  };

  # List services that you want to enable:

  # Add an OpenSSH daemon.
  services.openssh.enable = true;

  # Postgres
  services.postgresql.enable = true;

  # Add CUPS to print documents.
  services.printing.enable = true;

  # Add XServer (default if you have used a graphical iso)
   services.xserver = {
     enable = true;
     defaultDepth = 24;
     videoDriver = "nvidia";
     layout = "es";
     xkbOptions = "eurosign:e";
     desktopManager = {
       default = "xfce";
       xfce = {
         enable = true;
       };
     };
     displayManager = {
       slim = {
         enable = true;
         hideCursor = true;
       };
     };
   };

  # Add the NixOS Manual on virtual console 8
  services.nixosManual.showManual = true;

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = ["8.8.8.8" "8.8.4.4"];

  environment = {
    systemPackages = with pkgs; [
      acpitool
      alsaLib
      alsaPlugins
      alsaUtils
      audacious
      colordiff
      chromium
      cpufrequtils
      dvdplusrwtools
      eject
      eclipses.eclipse_sdk_42
      gcc
      gimp
      git
      glibcLocales
      gnupg
      google_talk_plugin
      htop
      libreoffice
      libxml2
      netcat
      nmap
      openvpn
      pgadmin
      powertop
      pulseaudio
      pwgen
      python
      tmux
      transmission
      unrar
      unzip
      vim
      vlc
      xchat
#      xfce.xfce4_systemload_plugin
      xorg.xf86inputsynaptics
      zip
    ];
    x11Packages = with pkgs; [
      rdesktop
      wpa_supplicant_gui
    ];
  };

  powerManagement.enable = true;
}

