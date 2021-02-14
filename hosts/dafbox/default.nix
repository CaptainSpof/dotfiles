# dafbox -- my desktop

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
          teamspeak.enable = true;
          telegram.enable = true;
        };
        office.libreoffice.enable = true;
        rofi.enable = true;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
      };
      gaming = {
        steam.enable = true;
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
        videos = {
          mpv.enable = false;
          vlc.enable = true;
          recording.enable = false;
        };
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
      shell.enable = true;
      nix.enable = true;
    };
    shell = {
      aws.enable = false;
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
      nginx.enable = true;
      ssh.enable = true;
      syncthing.enable = true;
    };
    theme = {
      active = "lightly";
      prompt.enable = false;
      browsersTheme.enable = false;
    };
  };

  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  hardware.opengl.enable = true;

  # TODO Move to module ?
  services.xserver.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
  };
}
