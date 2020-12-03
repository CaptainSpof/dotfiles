# Shiro -- my laptop

{ ... }:
{
  imports = [
    ../personal.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      bspwm.enable = false;
      plasma.enable = true;
      apps = {
        chats = {
          teamspeak.enable = true;
          discord.enable = true;
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
      vm = {
        virtualbox.enable = false;
      };
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };
    dev = {
      # cc.enable = true;
      rust.enable = true;
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
      #syncthing.enable = true;
      ssh.enable = true;
      kdeconnect.enable = true;
    };
    theme.active = "alucard";
  };

  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;
  hardware.opengl.enable = true;

  # TODO Move to module ?
  services.xserver.libinput.enable = true;

  # time.timeZone = "Europe/Copenhagen";
}
