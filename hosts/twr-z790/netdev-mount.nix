{
  config,
  myvars,
  ...
}: {
  # supported file systems, so we can mount any removable disks with these filesystems
  boot.supportedFilesystems = [
    "cifs"
    "davfs"
    "sshfs"
  ];

  # DOES NOT WORK !!! - check /nixos-config/home/linux/gui/base/hm-sshfs-mounts.nix to make it work
  # without the folder pre created it does not start home-manager with it created throws this:
  # just plasma -> the following new units were started: home-sparkx-ops\x2ddockers.automount,
  # locate ops-dockers
  # /home/sparkx/ops-dockers
  # sudo ls -al /home/sparkx/ops-dockers
  # ls: cannot open directory '/home/sparkx/ops-dockers': No such device
  # mount vm remote home folder as sshfs on current host
  # fileSystems."/run/media/${myvars.username}/ops-dockers" = {
  #   device = "${myvars.username}@10.220.0.5:/";
  #   fsType = "sshfs";
  #   options =
  #     [ # Filesystem options
  #       "allow_other"          # for non-root access
  #       "_netdev"              # this is a network fs
  #       "x-systemd.automount"  # mount on demand

  #       # SSH options
  #       "reconnect"              # handle connection drops
  #       "ServerAliveInterval=15" # keep connections alive
  #       "IdentityFile=/etc/agenix/ssh/priv/ops-id-ed25519.priv"
  #     ];
  # };

  # mount a smb/cifs share
  # fileSystems."/home/${myvars.username}/SMB-Downloads" = {
  #   device = "//windows-server-nas/Downloads";
  #   fsType = "cifs";
  #   options = [
  #     # https://www.freedesktop.org/software/systemd/man/latest/systemd.mount.html
  #     "nofail,_netdev"
  #     "uid=1000,gid=100,dir_mode=0755,file_mode=0755"
  #     "vers=3.0,credentials=${config.age.secrets.smb-credentials.path}"
  #   ];
  # };

  # mount a webdav share
  # https://wiki.archlinux.org/title/Davfs2
  # fileSystems."/home/${myvars.username}/webdav-downloads" = {
  #   device = "https://webdav.writefor.fun/Downloads";
  #   fsType = "davfs";
  #   options = [
  #     # https://www.freedesktop.org/software/systemd/man/latest/systemd.mount.html
  #     "nofail,_netdev"
  #     "uid=1000,gid=100,dir_mode=0755,file_mode=0755"
  #   ];
  # };
  # davfs2 reads its credentials from /etc/davfs2/secrets
  # environment.etc."davfs2/secrets".source = config.age.secrets."davfs-secrets".path;
}
