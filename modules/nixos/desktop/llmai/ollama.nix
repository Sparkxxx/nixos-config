{
  config,
  myvars,
  ...
}: {
  # https://fictionbecomesfact.com/nixos-ollama-oterm-openwebui
  # journalctl -u ollama.service

  # https://wiki.nixos.org/wiki/Ollama
  services.ollama = {
    #package = pkgs.unstable.ollama; # Uncomment if you want to use the unstable channel, see https://fictionbecomesfact.com/nixos-unstable-channel
    enable = true;
    acceleration = "cuda"; # Or "rocm"
    #environmentVariables = { # I haven't been able to get this to work myself yet, but I'm sharing it for the sake of completeness
    # HOME = "/home/ollama";
    # OLLAMA_MODELS = "/home/ollama/models";
    # OLLAMA_HOST = "0.0.0.0:11434"; # Make Ollama accessible outside of localhost
    # OLLAMA_ORIGINS = "http://localhost:8080,http://192.168.0.10:*"; # Allow access, otherwise Ollama returns 403 forbidden due to CORS
    #};
  };

  # Create directories and run scripts for the containers
  # IMPORTANT: make sure the folders are created with the root user and group else the container will not work properly
  # system.activationScripts = {
  #   script.text = ''
  #     install -d -m 755 /home/"${myvars.username}"/_work_/_ai/open-webui/data -o root -g root
  #   '';
  # };

  # virtualisation = {
  #   oci-containers = {
  #     backend = "docker";
  #     containers = {
  #       open-webui = import ./llmai/open-webui.nix;
  #     };
  #   };
  # };
}
