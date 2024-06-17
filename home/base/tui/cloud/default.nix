{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # aws
    awscli2
    ssm-session-manager-plugin # Amazon SSM Session Manager Plugin
    aws-iam-authenticator
    eksctl

    # aliyun
    aliyun-cli
    # cloud tools that nix do not have cache for.

    #IaC
    opentofu
    terraform
    terraformer # generate terraform configs from existing cloud resources
    # infrastructure as code
    # pulumi
    # pulumictl
    # tf2pulumi
    # crd2pulumi
    # pulumiPackages.pulumi-random
    # pulumiPackages.pulumi-command
    # pulumiPackages.pulumi-aws-native
    # pulumiPackages.pulumi-language-go
    # pulumiPackages.pulumi-language-python
    # pulumiPackages.pulumi-language-nodejs

    # Boot Image generators
    packer # machine image builder
  ];
}
