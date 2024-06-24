{
  config,
  pkgs,
  ...
}: let
  ROOT = "/var/lib/portainer";
in {
  ## Services are created with <backend>-<name>.service
  ## EG: sudo systemctl status podman-portainer.service
  virtualisation.oci-containers = {
    ## Specify backend otherwise portainer is used by default
    backend = "docker";
    containers = {
      portainer = {
        autoStart = true;
        image = "portainer/portainer-ce";
        volumes = [
          "${ROOT}/data:/data"
          "/var/run/docker.sock:/var/run/docker.sock"
        ];
        ports = ["8000:8000" "9000:9000"];
      };
    };
  };
}
