{
  pkgs,
  lib,
  plasma,
  #nur-ryan4yin,
  ...
}: let
  package = plasma.packages.${pkgs.system}.plasma;
in {

services.xserver = {
		# Required by SDDM.
		enable = true;
		displayManager.sddm = {
			enable = true;
			wayland.enable = true;
		};
		# Enable Desktop Environment.
		desktopManager.plasma5.enable = true;
		# Configure keymap in X11.
		#layout = user.services.xserver.layout;
		#xkbVariant = user.services.xserver.xkbVariant;
		# Exclude default X11 packages I don't want.
		excludePackages = with pkgs; [ xterm ];
	};
}
