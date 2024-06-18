{
  pkgs,
  #nix-vscode-extensions,
  myvars,
  ...
}: {
  # refer to https://codeberg.org/dnkl/foot/src/branch/master/foot.ini
  # xdg.configFile."foot/foot.ini".text =
  #   ''
  #     [main]
  #     dpi-aware=yes
  #     font=JetBrainsMono Nerd Font:size=13
  #     shell=${pkgs.bash}/bin/bash --login -c 'nu --login --interactive'
  #     term=foot
  #     initial-window-size-pixels=3840x2160
  #     initial-window-mode=windowed
  #     pad=0x0                             # optionally append 'center'
  #     resize-delay-ms=10

  #     [mouse]
  #     hide-when-typing=yes
  #   ''
  #   + (builtins.readFile "${nur-ryan4yin.packages.${pkgs.system}.catppuccin-foot}/catppuccin-mocha.conf");

  programs = {
    # source code: https://github.com/nix-community/home-manager/blob/master/modules/programs/chromium.nix
    # google-chrome = {
    #   enable = true;

    #   # https://wiki.archlinux.org/title/Chromium#Native_Wayland_support
    #   commandLineArgs = [
    #     "--ozone-platform-hint=auto"
    #     "--ozone-platform=wayland"
    #     # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
    #     # (only supported by chromium/chrome at this time, not electron)
    #     "--gtk-version=4"
    #     # make it use text-input-v1, which works for kwin 5.27 and weston
    #     "--enable-wayland-ime"

    #     # enable hardware acceleration - vulkan api
    #     # "--enable-features=Vulkan"
    #   ];
    # };

    # firefox = {
    #   enable = true;
    #   enableGnomeExtensions = false;
    #   package = pkgs.firefox-wayland; # firefox with wayland support
    # };

    # https://nixos.wiki/wiki/Visual_Studio_Code
    # https://mynixos.com/options/programs.vscode

    #     vscode = {
    #       enable = true;
    #       # let vscode sync and update its configuration & extensions across devices, using github account.
    #       userSettings = {};
    #       package =
    #         (pkgs.vscode.override
    #           {
    #             isInsiders = false;
    #             # https://wiki.archlinux.org/title/Wayland#Electron
    #             commandLineArgs = [
    #               "--ozone-platform-hint=auto"
    #               "--ozone-platform=wayland"
    #
    #               # TODO: fix https://github.com/microsoft/vscode/issues/187436
    #               # still not works...
    #               #"--password-store=gnome" # use gnome-keyring as password store
    #             ];
    #           });
    #         # .overrideAttrs (oldAttrs: rec {
    #         #   # Use VSCode Insiders to fix crash: https://github.com/NixOS/nixpkgs/issues/246509
    #         #   src = builtins.fetchTarball {
    #         #     url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
    #         #     sha256 = "1pp5hzcz326hww4qr6bl8p0ndp1fmjd0lnazc3j31sbkcbwr0v1w";
    #         #   };
    #         #   version = "latest";
    #         # });
    #     };

    vscode = {
      enable = true;

      # changing mutable from true/false or back will need reboot - home manager process will fail to start
      mutableExtensionsDir = true;
      # enableUpdateCheck = false;
      # enableExtensionUpdateCheck = false;

      # Using settings sync service https://vscode-sync.trafficmanager.net/ ???

      # Use packages declared in https://github.com/nix-community/home-manager/blob/master/modules/programs/vscode.nix
      # Available here are Default:vscode scode-insiders vscodium openvscode-server
      package = pkgs.vscodium;

      # https://github.com/nix-community/nix-vscode-extensions
      # We don't automatically handle extension packs. You should look up extensions in a pack and explicitly write all necessary extensions.
      # open-vsx vscode-marketplace - https://github.com/nix-community/nix-vscode-extensions?tab=readme-ov-file#release-extensions
      extensions = with pkgs.vscode-extensions; [
        # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json

        mikestead.dotenv

        continue.continue
        # privy.privy-vscode - Real time code completion
        # rjmacarthy.twinny - Locally hosted AI code completion plugin for vscode

        #pinage404.nix-extension-pack #not working for some reason can't find it - components below

        editorconfig.editorconfig
        jnoortheen.nix-ide
        mkhl.direnv
        arrterian.nix-env-selector

        eamodio.gitlens
        ms-vscode-remote.remote-ssh
        seatonjiang.gitmoji-vscode
        yzhang.markdown-all-in-one

        jnoortheen.nix-ide

        # Not available from here for me YET !!!
        #esphome.esphome-vscode
        #kelvin.vscode-sshfs
        #keesschollaart.vscode-home-assistant
        #ms-vscode.notepadplusplus-keybindings
      ];
      #       ++ (with pkgs.vscode-marketplace; [
      #         # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json

      #       ])
      #       ++ (with pkgs.vscode-utils.extensionsFromVscodeMarketplace; [
      # #         {
      # #           name = "continue.continue";
      # #           publisher = "Continue";
      # #           version = "v0.8.40";
      # #           sha256 = "sha256-agJfEc4JqxKaNQhto0BfVx2Pxk809G0Ne3TqaR8mlxo=";
      # #         }
      #       ]);

      # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.vscode.userSettings
      # inspiration from https://discourse.nixos.org/t/home-manager-vscode-extension-settings-mutableextensionsdir-false/33878
      userSettings = {
        "files.autoSave" = "off";
        "[nix]"."editor.tabSize" = 2;
        "nix.enableLanguageServer" = true;
        "telemetry.telemetryLevel" = "off";

        # Whitespace
        "files.trimTrailingWhitespace" = true;
        "files.trimFinalNewlines" = true;
        "files.insertFinalNewline" = true;
        "diffEditor.ignoreTrimWhitespace" = false;

        # Git
        "git.enableCommitSigning" = true;
        "git-graph.repository.sign.commits" = true;
        "git-graph.repository.sign.tags" = true;
        "git-graph.repository.commits.showSignatureStatus" = true;

        # Gitmoji
        "gitmoji.onlyUseCustomEmoji" = true;
        "gitmoji.addCustomEmoji" = [
          {
            "emoji" = "📦 NEW:";
            "code" = ":package: NEW:";
            "description" = "... Add new code/feature";
          }
          {
            "emoji" = "👌 IMPROVE:";
            "code" = ":ok_hand: IMPROVE:";
            "description" = "... Improve existing code/feature";
          }
          {
            "emoji" = "❌ REMOVE:";
            "code" = ":x: REMOVE:";
            "description" = "... Remove existing code/feature";
          }
          {
            "emoji" = "🐛 FIX:";
            "code" = ":bug: FIX:";
            "description" = "... Fix a bug";
          }
          {
            "emoji" = "📑 DOC:";
            "code" = ":bookmark_tabs: DOC:";
            "description" = "... Anything related to documentation";
          }
          {
            "emoji" = "🤖 TEST:";
            "code" = ":robot: TEST:";
            "description" = "... Anything related to tests";
          }
        ];
        "sshfs.configs" = [
          {
            "name" = "dockers";
            "label" = "dockers";
            "host" = "10.220.0.5";
            "username" = "${myvars.username}";
            "agent" = "$SSH_AUTH_SOCK";
            "privateKeyPath" = "/home/${myvars.username}/.ssh/ops-id-ed25519.priv";
            "root" = "/root";
            "hop" = "dockers";
          }
        ];
      };

      #     userTasks = {
      #       version = "2.0.0";
      #       tasks = [
      #         {
      #           type = "shell";
      #           label = "Hello task";
      #           command = "hello";
      #         }
      #       ];
      #     };
    };
  };
}
