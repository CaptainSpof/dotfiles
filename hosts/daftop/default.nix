# daftop -- my laptop

{ inputs, ... }: {
  imports = [ ../home.nix ./hardware-configuration.nix ];

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
          gba.enable = true;
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
      lua.enable = true;
      shell.enable = true;
      nix.enable = true;
      node.enable = true;
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
      chromecast.enable = true;
      docker.enable = true;
      emacs.enable = false;
      email.enable = true;
      kdeconnect.enable = true;
      nginx.enable = true;
      ssh.enable = true;
      syncthing.enable = true;
      touchegg.enable = true;
    };
    theme = {
      active = "lightly";
      prompt.enable = false;
      browsersTheme.enable = false;
    };
  };

  # Caps lock is now Ctrl
  # services.xserver.xkbOptions = "ctrl:swapcaps,ctrl:ctrl";

  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
}
