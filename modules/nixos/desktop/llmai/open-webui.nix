{
  # image = "ghcr.io/open-webui/open-webui:main";

  # environment = {
  #   # "TZ" = "${config.time.timeZone}"
  #   "TZ" = "Europe/Bucharest";
  #   "OLLAMA_API_BASE_URL" = "http://127.0.0.1:11434/api";
  #   "OLLAMA_BASE_URL" = "http://127.0.0.1:11434";
  # };

  # volumes = [
  #   "/home/sparkx/open-webui/data:/app/backend/data"
  # ];

  # ports = [
  #   "127.0.0.1:3000:8080" # Ensures we listen only on localhost
  # ];

  # # ”–network=host” It is also possible to use net_macvlan. For an example please see the note about MariaDB - https://fictionbecomesfact.com/mariadb-nixos-container

  # extraOptions = [
  #   "--pull=newer" # Pull if the image on the registry is newer
  #   "--name=open-webui"
  #   "--hostname=open-webui"
  #   "--network=host"
  #   "--add-host=host.containers.internal:host-gateway"
  # ];
}
