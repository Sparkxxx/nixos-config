{
  pkgs,
  pkgs-unstable,
  ...
}: {
  #############################################################
  #
  #  Basic settings for development environment
  #
  #  Please avoid to install language specific packages here(globally),
  #  instead, install them:
  #     1. per IDE, such as `programs.neovim.extraPackages`
  #     2. per-project, using https://github.com/the-nix-way/dev-templates
  #
  #############################################################

  home.packages = with pkgs; [
    colmena # nixos's remote deployment tool

    # db related
    mycli
    pgcli
    mongosh
    sqlite

    # embedded development
    minicom

    # AI related
    pkgs-unstable.oterm # https://github.com/ggozad/oterm  Text-based terminal client, after installing Ollama all you have to do is type oterm in the terminal.
    #ollama # https://wiki.nixos.org/wiki/Ollama
    lmstudio
    #shell-gpt - https://www.youtube.com/watch?v=FqOx_qOLPDM
    shell-gpt
    # # To communicate with local LLM backends, ShellGPT utilizes LiteLLM
    # python311Packages.litellm
    # python311Packages.huggingface-hub # huggingface-cli

    # misc
    pkgs-unstable.devbox
    bfg-repo-cleaner # remove large files from git history
    k6 # load testing tool
    protobuf # protocol buffer compiler

    # solve coding extercises - learn by doing
    exercism

    # Automatically trims your branches whose tracking remote refs are merged or gone
    # It's really useful when you work on a project for a long time.
    git-trim

    # need to run `conda-install` before using it
    # need to run `conda-shell` before using command `conda`
    # conda is not available for MacOS
    conda
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableZshIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
