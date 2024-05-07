


# NOTE: `cat shoukei.md | egrep "create-btrfs"  > create-btrfs.sh` to generate this script
# format the root partition with btrfs and label it
# mkfs.btrfs -L encrypted-nixos /dev/mapper/crypted-nixos  # create-btrfs
# mount the root partition and create subvolumes
# mount /dev/mapper/crypted-nixos /mnt  # create-btrfs
# btrfs subvolume create /mnt/@nix  # create-btrfs
# btrfs subvolume create /mnt/@guix  # create-btrfs
# btrfs subvolume create /mnt/@tmp  # create-btrfs
# btrfs subvolume create /mnt/@swap  # create-btrfs
# btrfs subvolume create /mnt/@persistent  # create-btrfs
# btrfs subvolume create /mnt/@snapshots  # create-btrfs
# btrfs subvolume create /mnt/@fulldisk  # create-btrfs
# btrfs subvolume list /mnt  # create-btrfs
# umount -R /mnt  # create-btrfs

# open(unlock) the device with the passphrase you just set
# cryptsetup luksOpen /dev/nvme0n1p2 crypted-nixos
# mount /dev/mapper/crypted-nixos /mnt
# umount -R /mnt
# cryptsetup close /dev/mapper/crypted-nixos

# With btrfs partition open and subvolumes in place AND /mnt is not mounted anywhere go forward !!!

echo "1. Mount the in-ram ROOT partition"  # mount-1
mount -t tmpfs -o noatime,mode=755 tmpfs /mnt  # mount-1

echo "2. Create persistent directories on which to mount partitions"  # mount-1
# TODO check if folders have been created  # mount-1
mkdir -p /mnt/{nix,gnu,tmp,swap,persistent,snapshots,fulldisk,boot}  # mount-1

echo "3. Mount the folders to their btrfs subvolume"  # mount-1
# TODO check mounts  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@nix /dev/mapper/crypted-nixos /mnt/nix  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@guix /dev/mapper/crypted-nixos /mnt/gnu  # mount-1
mount -o compress-force=zstd:1,subvol=@tmp /dev/mapper/crypted-nixos /mnt/tmp  # mount-1
mount -o subvol=@swap /dev/mapper/crypted-nixos /mnt/swap  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@persistent /dev/mapper/crypted-nixos /mnt/persistent  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@snapshots /dev/mapper/crypted-nixos /mnt/snapshots  # mount-1
mount -o compress-force=zstd:1,noatime,subvol=@fulldisk /dev/mapper/crypted-nixos /mnt/fulldisk  # mount-1

echo "4. Mount the ESP partition"  # mount-1
mount /dev/nvme0n1p1 /mnt/boot  # mount-1

# echo "5. Create the swapfile in the btrfs subvolume"  # create-btrfs
# mkdir -p /mnt/swap/
btrfs filesystem mkswapfile --size 64g --uuid clear /mnt/swap/swapfile  # create-btrfs
# check whether the swap subvolume has CoW disabled
# the output of `lsattr` for the swap subvolume should be:
#    ---------------C------ /swap/swapfile
# if not, delete the swapfile, and rerun the commands above.
 lsattr /mnt/swap  # mount-1



mount 
ls -alh /mnt
lsblk -f  # mount-1
swapon -s  # mount-1
# mount the swapfile as swap area
swapon /mnt/swap/swapfile  # mount-1
swapon -s  # mount-1
free  # mount-1