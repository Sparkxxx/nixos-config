{
  config,
  myvars,
  ...
}: {
  services.frigate = {
    enable = true;
    hostname = "localhost";

    settings = {
      mqtt.enabled = false;

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

      cameras."t0mm-xvr" = {
        ffmpeg.inputs = [
          {
            path = "rtsp://rtsp:1234qwer@10.5.0.2:554/cam/realmonitor?channel=5&subtype=0";
            input_args = "preset-rtsp-restream";
            roles = [
              "detect"
              #"record"
            ];
          }
        ];
      };
      # cameras."test2" = {
      #   ffmpeg.inputs = [ {
      #     path = "rtsp://localaccount:localaccount@172.20.65.103:554/stream1";
      #     roles = [
      #       "record"
      #       "detect"
      #     ];
      #   } ];
      # };
    };
  };

  # hwdec for amdgpu
  systemd.services.frigate = {
    environment.LIBVA_DRIVER_NAME = "nvidia-vaapi-driver";
    serviceConfig = {
      SupplementaryGroups = ["render" "video"]; # for access to dev/dri/*
      AmbientCapabilities = "CAP_PERFMON";
    };
  };

  services.go2rtc = {
    enable = true;
    settings = {
      streams = {
        "t0mm-xvr" = [
          "10.116.0.2:8555"
          #"stun:8555"
        ];
      };
      rtsp.listen = ":8554";
      webrtc.listen = ":8555";
    };
  };
}
