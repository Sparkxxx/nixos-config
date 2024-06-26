{
  config,
  pkgs,
  ...
}: {
  # TODO Clarify subject More work is needed to get Nvidia Prime
  # https://discourse.nixos.org/t/docker-nvidia-container-runtime-not-detected/36733/2
  # https://medium.com/@social.iodols/managing-docker-containers-in-nixos-fbda0f666dd1

  ## Services are created with <backend>-<name>.service
  ## EG: sudo systemctl status podman-portainer.service
  virtualisation.oci-containers = {
    ## Specify backend otherwise portainer is used by default
    backend = "docker";
    containers = {
      shinobi = {
        autoStart = true;
        image = "shinobisystems/shinobi:dev";
        volumes = [
          # /var/lib/ is added to impermanence for twr-z790
          "/dev/shm/Shinobi/streams:/dev/shm/streams:rw"
          "/var/lib/Shinobi/config:/config:rw"
          "/var/lib/Shinobi/customAutoLoad:/home/Shinobi/libs/customAutoLoad:rw"
          "/var/lib/Shinobi/database:/var/lib/mysql:rw"
          "/var/lib/Shinobi/videos:/home/Shinobi/videos:rw"
          "/var/lib/Shinobi/plugins:/home/Shinobi/plugins:rw"
          "/etc/localtime:/etc/localtime:ro"
        ];
        ports = ["8080:8080/tcp"];
      };
    };
  };
}
