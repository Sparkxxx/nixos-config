{config, ...}: let
  consulAgent = "localhost:8500";

  scrapeConfigs = [
    {
      job_name = "consul";
      static_configs = [
        {
          targets = [
            "nuc:8500"
            "rp3:8500"
          ];
        }
      ];
      metrics_path = "/v1/agent/metrics";
      params.format = ["prometheus"];
    }
    {
      job_name = "consul_catalog";
      consul_sd_configs = [
        {
          server = consulAgent;
          services = [
            "grafana"
            "grafana-image-renderer"
            "hydra"
            "loki"
            "node-exporter"
            "prometheus"
            "promtail"
            "telegraf"
          ];
        }
      ];
      relabel_configs = [
        {
          source_labels = ["__meta_consul_node"];
          target_label = "hostname";
        }
        {
          source_labels = ["__meta_consul_service"];
          target_label = "service";
        }
      ];
    }
    {
      job_name = "node";
      static_configs = [
        {
          targets = [
            "wrt:9100"
          ];
        }
      ];
    }
  ];

  alertmanagers = [
    {
      static_configs = [
        {
          targets = ["nuc:9093"];
        }
      ];
    }
  ];
in {
  imports = [./consul-catalog.nix];

  services.prometheus = {
    enable = true;
    inherit alertmanagers scrapeConfigs;
  };

  services.consul.catalog = [
    {
      name = "prometheus";
      port = config.services.prometheus.port;
      tags = (import ./lib/traefik.nix).tagsForHost "prometheus";
      check = {
        name = "Health endpoint";
        http = "http://localhost:${toString config.services.prometheus.port}/-/healthy";
        interval = "10s";
      };
    }
  ];

  networking.firewall.allowedTCPPorts = [config.services.prometheus.port];
}
