Since I always seem to forget how I installed Grub in the first place
(in my defense, there's always a big delay between each reinstall).

```sh
# Mount the correct partition, mount point is /boot/EFI on my installations
sudo mount /dev/nvme0n1p1 /boot/EFI
# Reinstall grub
sudo grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB --recheck --verbose
# Regenerate Grub config file
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
