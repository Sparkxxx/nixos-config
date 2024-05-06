mkdir -p /mnt/{nix,gnu,tmp,swap,persistent,snapshots,fulldisk,boot}  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@nix /dev/mapper/crypted-nixos /mnt/nix  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@guix /dev/mapper/crypted-nixos /mnt/gnu  # mount-1
mount -o compress-force=zstd:1,subvol=@tmp /dev/mapper/crypted-nixos /mnt/tmp  # mount-1
mount -o subvol=@swap /dev/mapper/crypted-nixos /mnt/swap  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@persistent /dev/mapper/crypted-nixos /mnt/persistent  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@snapshots /dev/mapper/crypted-nixos /mnt/snapshots  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@fulldisk /dev/mapper/crypted-nixos /mnt/fulldisk  # mount-1
mount -t tmpfs tmpfs /mnt  # mount-1
mount /dev/nvme0n1p1 /mnt/boot  # mount-1
btrfs filesystem mkswapfile --size 96g --uuid clear /mnt/swap/swapfile  # mount-1
lsblk -f
swapon -s
