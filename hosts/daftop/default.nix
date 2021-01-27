# daftop -- my laptop

{ inputs, ... }: {
  imports = [ ../personal.nix ./hardware-configuration.nix ];

  ## Modules
  modules = {
    desktop = {
      plasma = {
        enable = true;
        polybar.enable = false;
        sxhkd.enable = true;
      };
      apps = {
        chats = {
          discord.enable = true;
          teams.enable = true; # can't wait to disable that memory hogging app
          teamspeak.enable = false;
          telegram.enable = true;
          slack.enable = true; # you too slack, you too...
        };
        office.libreoffice.enable = true;
        rofi.enable = true;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
      };
      gaming = {
        steam.enable = false;
        emulators = {
          ds.enable = true;
        };
      };
      media = {
        documents = {
          enable = true;
          pdf.enable = false;
          ebook.enable = true;
        };
        graphics = {
          enable = true;
          sprites.enable = false;
        };
        mpv.enable = false;
        vlc.enable = true;
        recording.enable = false;
      };
      term = {
        default = "alacritty";
        alacritty.enable = true;
      };
      vm = {
        qemu = {
          enable = true;
        };
        virt-manager.enable = true;
      };
    };
    editors = {
      default = "emacs";
      emacs = {
        enable = true;
        doom = {
          user.config = {
            src = "git@github.com:CaptainSpof/doom-conf.git";
          };
        };
      };
      vim.enable = true;
    };
    dev = {
      rust.enable = true;
      lua.enable = true;
      shell.enable = true;
      nix.enable = true;
    };
    hardware = {
      audio.enable = true;
      bluetooth = {
        enable = true;
        audio.enable = true;
      };
      fs = {
        enable = true;
        ssd.enable = true;
      };
      nvidia = {
        enable = false;
        prime.enable = false;
      };
      sensors.enable = true;
    };
    shell = {
      aws.enable = true;
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = true;
      pass.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
    services = {
      docker.enable = true;
      emacs.enable = false;
      email.enable = true;
      kdeconnect.enable = true;
      ssh.enable = true;
      syncthing.enable = true;
      touchegg.enable = true;
    };
    theme = {
      active = "qogir-light";
      prompt.enable = false;
    };
  };

  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;
  hardware.opengl.enable = true;

  # Offload builds
#   nix.distributedBuilds = false;
#   nix.buildMachines = [
#     {
#       hostName = "builder";
#       systems = [ "x86_64-linux" "aarch64-linux" ];
#       maxJobs = 4;
#       speedFactor = 2;
#       supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
#     }
#   ];

#   programs.ssh.extraConfig = ''
# Host builder
#   HostName 192.168.0.24
#   Port 22
#   User daf
#   IdentitiesOnly yes
#   IdentityFile /root/.ssh/root@daftop-builder.pem
#   '';

  # TODO Move to module ?
  # services.xserver.libinput.enable = true;
  services.xserver.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
    touchpad = {
      naturalScrolling = true;
    };
  };
  services.tlp.enable = true;
}
