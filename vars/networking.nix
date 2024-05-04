{lib}: rec {
  
  mainGateway = "10.111.0.1"; # main router
  # use t0mm-gw as the default gateway
  # it's a subrouter with a transparent proxy
  defaultGateway = "10.111.0.1";
  nameservers = [
    "10.111.0.1" # t0mm-gw
    "10.215.0.1" # opnsfw.ops.t0mm.iotec.ro:65456
  ];
  prefixLength = 24;

  hostsAddr = {
    # ============================================
    # Homelab's Physical Machines (KubeVirt Nodes)
    # ============================================
    # kubevirt-shoryu = {
    #   iface = "eno1";
    #   ipv4 = "192.168.5.181";
    # };
    # kubevirt-shushou = {
    #   iface = "eno1";
    #   ipv4 = "192.168.5.182";
    # };
    # kubevirt-youko = {
    #   iface = "eno1";
    #   ipv4 = "192.168.5.183";
    # };

    # ============================================
    # Other VMs and Physical Machines
    # ============================================
    # ## https://nixos.org/manual/nixos/stable/index.html#sec-ipv4
    # systemd.network.links."10-mobolan" = {
    #   matchConfig.PermanentMACAddress = "74:56:3c:c3:e5:3b";
    #   linkConfig.Name = "mobolan";
    # };

    # systemd.network.links."20-pcielan" = {
    #   matchConfig.PermanentMACAddress = "1c:86:0b:21:08:54";
    #   linkConfig.Name = "pcielan";
    # };

    # networking.enableIPv6 = false;
 
    # networking.interfaces.mobolan.ipv4.addresses = [ {
    #   address = "10.111.0.220";
    #   prefixLength = 24;
    # } ];
 
    # networking.defaultGateway = "10.111.0.1";
    # networking.nameservers = [ "10.111.0.1" ];

    twr-z790 = {
      # Desktop sparkx
        iface = "enp3s0";
        ipv4 = "10.111.0.220";


      # #iface_1 = "enp5s0";
      # iface_1_mac = "74:56:3c:c3:e5:3b";
      # iface_1_linkconfig_name = "mobolan";
      # iface_1_enableIPv6 = false;
      # iface_1_ipv4 = "10.111.0.220";
      # iface_1_defaultGateway = "10.111.0.1";
      # iface_1_nameservers = [
      #   "10.111.0.1" # t0mm-gw
      #   "10.215.0.1" # opnsfw.ops.t0mm.iotec.ro:65456
      # ];
      # iface_1_prefixLength = 24;


      # #iface_2 = "enp5s0";
      # iface_2_mac = "1c:86:0b:21:08:54";
      # iface_2_linkconfig_name = "pcielan";
      # iface_2_enableIPv6 = false;
      # # iface_2_ipv4 = "10.111.0.220";
      # # iface_2_prefixLength = 24;
    };

    # aquamarine = {
    #   # VM
    #   iface = "enp2s0";
    #   ipv4 = "192.168.5.101";
    # };
  };

  hostsInterface =
    lib.attrsets.mapAttrs
    (
      key: val: {
        interfaces."${val.iface}" = {
          useDHCP = false;
          ipv4.addresses = [
            {
              inherit prefixLength;
              address = val.ipv4;
            }
          ];
        };
      }
    )
    hostsAddr;

  # hostsInterface =
  #   lib.attrsets.mapAttrs
  #   (
  #     key: val: {
  #       interfaces."${val.iface_1_linkconfig_name}" = {
  #         useDHCP = false;
  #         ipv4.addresses = [
  #           {
  #             address = val.iface_1_ipv4;
  #             prefixLength = val.iface_1_prefixLength;
  #           }
  #         ];
  #       };
  #       defaultGateway = "${val.iface_1_defaultGateway}";
  #       nameservers = "${val.iface_1_nameservers}";
  #       enableIPv6 = "${val.iface_1_enableIPv6}";
  #     }
  #   )
  #   hostsAddr;

  ssh = {
    # define the host alias for remote builders
    # this config will be written to /etc/ssh/ssh_config
    # ''
    #   Host ruby
    #     HostName 192.168.5.102
    #     Port 22
    #
    #   Host kana
    #     HostName 192.168.5.103
    #     Port 22
    #   ...
    # '';
    extraConfig =
      lib.attrsets.foldlAttrs
      (acc: host: val:
        acc
        + ''
          Host ${host}
            HostName ${val.ipv4}
            Port 22
        '')
      ""
      hostsAddr;

    # define the host key for remote builders so that nix can verify all the remote builders
    # this config will be written to /etc/ssh/ssh_known_hosts
    knownHosts =
      # Update only the values of the given attribute set.
      #
      #   mapAttrs
      #   (name: value: ("bar-" + value))
      #   { x = "a"; y = "b"; }
      #     => { x = "bar-a"; y = "bar-b"; }
      lib.attrsets.mapAttrs
      (host: value: {
        hostNames = [host hostsAddr.${host}.ipv4];
        publicKey = value.publicKey;
      })
      {
        twr-z790.publickey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMC33NsH9i4yxyBDCqphoLIi3/8Bo617FBR2NHzAuCjn sparkx@twr-z790";
        #aquamarine.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJrHY3BZRTu0hrlsKxqS+O4GDp4cbumF8aNnbPCGKji root@aquamarine";
        #ruby.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAMmGni8imcaS40cXgLbVQqPYnDYKs8MSbyWL91RV98 root@ruby";
        #kana.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcINkxU3KxPsCpWltfEBjDYtKEeCmgrDxyUadl1iZ1D root@kana";
      };
  };
}
