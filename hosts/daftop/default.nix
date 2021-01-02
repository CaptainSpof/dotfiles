# Shiro -- my laptop

{ ... }: {
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
          teamspeak.enable = true;
          telegram.enable = true;
          slack.enable = true; # you too slack, you too...
        };
        rofi.enable = true;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
      };
      media = {
        documents = {
          enable = true;
          pdf.enable = true;
        };
        graphics.enable = false;
        mpv.enable = true;
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
      emacs.enable = true;
      vim.enable = true;
    };
    dev = {
      # cc.enable = true;
      rust.enable = true;
      shell.enable = true;
      nix.enable = true;
    };
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      fs = {
        enable = true;
        ssd.enable = true;
      };
    };
    shell = {
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = false;
      # weechat.enable = true;
      pass.enable = true;
      tmux.enable = true;
      # ranger.enable = true;
      zsh.enable = true;
    };
    services = {
      syncthing.enable = true;
      docker.enable = true;
      ssh.enable = true;
      kdeconnect.enable = true;
      emacs.enable = false;
      touchegg.enable = true;
    };
    # theme.active = "alucard";
    theme = {
      active = "alucard";
      loginWallpaper = null;
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

  # systemd.services."touchegg" = {
  #   enable = true;
  #   description = "touchegg, libinput and stuff. The Daemon.";
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.Type = "simple";
  #   serviceConfig.Group = "input";
  #   serviceConfig.Restart = "on-failure";
  #   serviceConfig.RestartSec = 5;
  #   serviceConfig.ExecStart = "/usr/bin/touchegg --daemon";
  # };

  # time.timeZone = "Europe/Copenhagen";
}
