{
  pkgs,
  lib,
  plasma,
  #nur-ryan4yin,
  ...
}: let
  package = plasma.packages.${pkgs.system}.plasma;
in {

<<<<<<< HEAD
services.xserver = {
=======
services.xserver.plasma = {
>>>>>>> 34d307f3f190bdda63888478d175eaf90f0ee60f
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
