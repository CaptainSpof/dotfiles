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
        office.libreoffice.enable = false;
        rofi.enable = true;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
      };
      gaming = {
        emulators = {
          ds.enable = true;
        };
      };
      media = {
        documents = {
          enable = true;
          pdf.enable = true;
        };
        graphics.enable = false;
        mpv.enable = false;
        vlc.enable = true;
        recording.enable = false;
      };
      term = {
        default = "alacritty";
        alacritty.enable = true;
      };
      vm = { virtualbox.enable = false; };
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
      email.enable = true;
      syncthing.enable = true;
      docker.enable = true;
      ssh.enable = true;
      kdeconnect.enable = true;
      emacs.enable = true;
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

  # TODO Move to module ?
  services.xserver.libinput.enable = true;
  services.tlp.enable = true;

  # time.timeZone = "Europe/Copenhagen";
}
