{myvars, ...}: {
  #https://discourse.nixos.org/t/systemd-mounts-and-systemd-automounts-options-causing-an-error/13796/9
  # environment.systemPackages = [pkgs.sshfs]; has to be installed on the system
  # Programs provided: mount.sshfs mount.fuse.sshfs sshfs
  # ls -al /etc/systemd/system/*.mount
  # ls -al $HOME/.config/systemd/user
  # https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
  # https://www.freedesktop.org/software/systemd/man/latest/systemd.mount.html
  # https://unix.stackexchange.com/questions/283442/systemd-mount-fails-where-setting-doesnt-match-unit-name
  # systemctl --user
  # systemctl list-unit-files
  # systemctl --user list-unit-files
  # systemctl --user list-units |grep dockers
  # systemctl list-units - To see a list of all of the active units that systemd knows about
  # systemctl list-units --all - To see a list of all of the active units that systemd knows about
  # systemctl list-units --all --state=inactive
  # systemctl list-units --type=mount
  # systemctl get-default -> default.target
  # systemctl list-unit-files --type=target - get all available targets for Wants, After, WantedBy
  # systemctl --user start home-sparkx-opsdockers
  # systemctl --user start home-sparkx-opsdockers.mount
  # Failed to start home-sparkx-opsdockers.mount: Unit home-sparkx-opsdockers.mount has a bad unit file setting.
  # See user logs and 'systemctl --user status home-sparkx-opsdockers.mount' for details.
  # systemd[5271]: home-sparkx-opsdockers.mount: Where= setting doesn't match unit name. Refusing.
  # journalctl --user should show the log

  ## After changing this file do:
  # 1. rebuild switch
  # 2. sudo systemctl daemon-reload
  # 3. check the files in ls -al $HOME/.config/systemd/user should be 2 like systemd-unit-name.mount and default.target.wants (or whatever)
  # 4. systemctl --user status home-sparkx-opsdockers.mount
  # 5. systemctl --user start home-sparkx-opsdockers.mount
  # 6. in case of error to start journalctl --user |grep systemd OR journalctl -xe

  ## Can't find a way to show it when is not mounted in Dolphin to connect - do a systemctl start from above !!!

  systemd.user = {
    # enable STATE true/false - if false state becomes linked-runtime - related to WantedBy?
    # if false it will disable systemd for userspace and you don't want that
    enable = true;

    #automounts = {
    mounts = {
      # systemd-unit-name has to be like the Where path EG: if Where = "/home/sparkx/opsdockers"  -->> unit-name is home-sparkx-opsdockers
      # for other than letters and numbers file names read systemd-mount-fails-where-setting-doesnt-match-unit-name above
      home-sparkx-opsdockers = {
        Unit = {
          Description = "sshfs sparks@dockers";
          Wants = "network-online.target";
          After = "network-online.target";
        };
        #Automount = {
        Mount = {
          What = "sparkx@10.220.0.5:/home/sparkx";
          Where = "/home/sparkx/opsdockers";
          Type = "fuse.sshfs";
          #Options = "x-systemd.automount,noauto,_netdev,reconnect,allow_other,IdentityFile=/home/${myvars.username}/.ssh/ops-id-ed25519.priv";
          Options = "nofail,reconnect,IdentityFile=/home/${myvars.username}/.ssh/ops-id-ed25519.priv";
          # fusermount3: option allow_other only allowed if 'user_allow_other' is set in /etc/fuse.conf
          #SloppyOptions=
          #LazyUnmount=
          #ReadWriteOnly=
          #ForceUnmount=
          #DirectoryMode=
          #TimeoutSec=
        };
        # "multi-user.target"
        Install.WantedBy = ["default.target"];
      };
    };
  };
}
