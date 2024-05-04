{lib}: {
  username = "sparkx";
  userfullname = "io sparkx";
  useremail = "io@iotec.ro";
  networking = import ./networking.nix {inherit lib;};
}
