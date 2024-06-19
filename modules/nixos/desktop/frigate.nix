{
  config,
  myvars,
  ...
}: {
  #https://github.com/rafaelsgirao/nixos-config/blob/c25f2e3d9a0ba8288d658540d31da247497c7f64/modules/archive/frigate.nix
  # STATE:
  # - h264 (h264+ disabled on Hikvision; Smart Codec disabled on Dahua)
  #
  # Main Stream (for Recording):
  # - Highest Resolution (1080p)
  # - 15 FPS
  # - I Frame Interval: 30
  #
  # Sub Stream (for Detection):
  # - Currently using 720p or highest below that
  #   - https://docs.frigate.video/frigate/camera_setup#choosing-a-detect-resolution
  # - 5 FPS
  # - I Frame Interval: 5
  #
  # - Static Network configuration:
  #     - 192.168.1.10 - Switch
  #     - 192.168.1.11 - Dahua
  #     - 192.168.1.12 - Hikvision
  #   - Default gateway: 192.168.1.254
  #   - DNS Servers: 1.1.1.1, 1.0.0.1

  # config with yml file and docker - https://github.com/mogorman/dotfiles/blob/6c45a55fbf94f85491854d4e92a7a37ced0f5175/services/frigate.nix
  # http://127.0.0.1:1984/

  # hwdec with gpu
  # systemd.services.frigate = {
  #   environment.LIBVA_DRIVER_NAME = "nvidia-vaapi-driver";
  #   serviceConfig = {
  #     SupplementaryGroups = ["render" "video"]; # for access to dev/dri/*
  #     AmbientCapabilities = "CAP_PERFMON";
  #   };
  # };

  services.frigate = {
    enable = false;
    hostname = "localhost";

    settings = {
      mqtt = {
        enabled = false;
        host = "http://192.168.1.16";
      };

      #detectors.ov = {
      #  type = "openvino";
      #  device = "AUTO";
      #  model.path = "/var/lib/frigate/openvino-model/ssdlite_mobilenet_v2.xml";
      #};

      ffmpeg.hwaccel_args = "preset-vaapi";

      record = {
        enabled = false;
        retain = {
          days = 2;
          mode = "all";
        };
      };

      snapshots = {
        enabled = true;
        retain = {
          days = 2;
        };
      };

      cameras = {
        "hala_fatza" = {
          ffmpeg.inputs = [
            {
              path = "rtsp://rtsp:1234qwer@10.5.0.2:554/cam/realmonitor?channel=5&subtype=0";
              #input_args = "preset-rtsp-restream"; preset-rtmp-generic
              #input_args: -avoid_negative_ts make_zero -fflags nobuffer -flags low_delay -strict experimental -fflags +genpts+discardcorrupt -use_wallclock_as_timestamps 1
              # output_args:
              #   rtmp: -c:v libx264 -f flv
              roles = [
                "detect"
                #"record"
              ];
            }
          ];
          detect = {
            enabled = true; # <---- disable detection until you have a working camera feed
            width = 704;
            height = 576;
          };
          record.enabled = false;
          snapshots.enabled = true;
          # audio.enabled = true; #only available in v13, nixpkgs 23.11 has v12
        };

        "dh-ipc-10503" = {
          ffmpeg.inputs = [
            {
              path = "rtsp://rtsp:1234qwer@10.5.0.2:554/cam/realmonitor?channel=15&subtype=0";
              input_args = "preset-rtsp-restream";
              roles = [
                "detect"
                #"record"
              ];
            }
          ];
          detect = {
            enabled = true; # <---- disable detection until you have a working camera feed
            width = 704;
            height = 576;
          };
          record.enabled = false;
          snapshots.enabled = true;
          # audio.enabled = true; #only available in v13, nixpkgs 23.11 has v12
        };
      };
    };
  };

  # Restream configuration
  # https://github.com/AlexxIT/go2rtc/tree/v1.8.3?tab=readme-ov-file#module-webrtc
  services.go2rtc = {
    enable = false;
    settings = {
      ## streams restreams what we write here
      streams = {
        "hala_fatza" = [
          "127.0.0.1:8555"
          #"stun:8555"
        ];
        "dh-ipc-10503" = [
          "127.0.0.1:8555"
          #"stun:8555"
        ];
      };

      rtsp.listen = ":8554";

      ## webrtc - we connect with our viewer to this port
      webrtc.listen = ":8555";
    };
  };
}
