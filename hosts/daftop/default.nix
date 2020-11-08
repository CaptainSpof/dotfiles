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
        discord.enable = true;
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
        st.enable = true;
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
      # common-lisp.enable = true;
      rust.enable = true;
      # lua.enable = true;
      # lua.love2d.enable = true;
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
      gnupg.enable = true;
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
