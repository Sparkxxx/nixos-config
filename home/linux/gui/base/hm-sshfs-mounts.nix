{
  config,
  myvars,
  ...
}: let
  mountdir_testhost = "${config.home.homeDirectory}/test";
in {
  systemd.user = {
    mounts = {
      mount-test = {
        Unit = {
          Description = "mount test home";
        };
        Mount = {
          What = "${myvars.username}@10.220.0.5:/home";
          Where = "${mountdir_testhost}";
          Type = "sshfs";
          Options = "x-systemd.automount,_netdev,reconnect,allow_other,identityfile=/home/${myvars.username}/.ssh/ops-id-ed25519.priv";
          #SloppyOptions=
          #LazyUnmount=
          #ReadWriteOnly=
          #ForceUnmount=
          #DirectoryMode=
          #TimeoutSec=
        };
      };
    };
  };
}
