{
  # https://jeppesen.io/git-commit-sign-nix-home-manager-ssh/
  home.file.".ssh/allowed_signers".text =
    "* ${builtins.readFile /home/\"${myvars.username}\"/.ssh/id_ed25519_github_sparkxxx.pub}";

  ## https://wiki.nixos.org/wiki/KDE
  modules.desktop = {
    hyprland = {
      nvidia = true;
      settings = {
        # Configure your Display resolution, offset, scale and Monitors here, use `hyprctl monitors` to get the info.
        #   highres:      get the best possible resolution
        #   auto:         position automatically
        #   1.5:          scale to 1.5 times
        #   bitdepth,10:  enable 10 bit support
        #monitor = "DP-2,highres,auto,1.5,bitdepth,10";
        monitor = "auto,highres,auto,auto,bitdepth,10";
      };
    };
    i3.nvidia = true;
  };
  modules.editors.emacs = {
    enable = true;
  };

  programs.ssh = {
    # enable = true;
    # extraConfig = ''
    #   Host github.com
    #       IdentityFile ~/.ssh/twr-z790
    #       # Specifies that ssh should only use the identity file explicitly configured above
    #       # required to prevent sending default identity files first.
    #       IdentitiesOnly yes
    # '';

    # https://jeppesen.io/git-commit-sign-nix-home-manager-ssh/
      enable = true;
      
      # extraConfig = ''
      # Host github-sparkx
      #     IdentityFile ~/.ssh/id_ed25519_github_sparkxxx
      #     # Specifies that ssh should only use the identity file explicitly configured above
      #     # required to prevent sending default identity files first.
      #     IdentitiesOnly yes
      # '';

      extraConfig = { 
        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        merge.conflictstyle = "zdiff3";
        user.signingkey = "~/.ssh/id_ed25519_github_sparkxxx.pub";

        url = {
          "git+ssh://git@github.com" = {
            insteadOf = "git+ssh://git@github-sparkx";
          };
        };

        pull = { ff = "only"; };
        push = { default = "current"; };

        # push = {
        #   default = "current";
        #   autoSetupRemote = true;
        # };
        # pull = {
        #   rebase = true;
        # };
        init = {
          defaultBranch = "main";
        };
        credential.helper = "store";
      };
      
      # aliases = {
      #   pfl = "push --force-with-lease";
      #   log1l = "log --oneline";
      # };
  };
}
