# INSTALACJA ARCH + PLASMA na IDEAPAD 100S-14IBR


Poniżej znajduje się instrukcja instalacji czystego Linux Arch + środowiska graficznego KDE Plasma oraz używanego przeze mnie oprogramowania na komputerze Lenovo Ideapad 100S-14IBR. Wykonuj komendy po kolei zgodne z poniższymi wskazówkami oraz opisem. Poniższą instrukcję oraz skrypt można bardzo łątwo dostosować do instalacji na dowolnym komputerze.

1. Ściągnij i nagraj na Pendrive ISO z systemem Linux Arch (np. używające Balena Etcher) - [https://archlinux.org/](https://archlinux.org/download/)

2. Uruchom komputer z przygotowanego ISO.

3. Ustaw układ klawiatury i wyświetlanie polskich znaków:

   ```sh
   loadkeys pl
   setfont Lat2-Terminus16.psfu.gz -m 8859-2
   ```
   
4. Podłącz się do sieci (słowo *haslodowifi* zastąp prawdziwym hasłem:

   ```sh
   bash
   iwctl station wlan0 scan
   iwctl --passphrase haslodowifi station wlan0 connect MM5
   ping archlinux.org (CTRL+C - żeby przerwać)
   ```

5. Zaktualizuj zegar systemowy:

   ```sh
   timedatectl set-ntp true
   ```
   
6. Formatowanie i montowanie partycji (są już stworzone):

   ```sh
   mkfs.fat -F32 /dev/mmcblk1p1
   mkswap /dev/mmcblk1p4
   swapon /dev/mmcblk1p4
   mkfs.ext4 /dev/mmcblk1p2
   mount /dev/mmcblk1p2 /mnt
   ```

7. Aktualizacja mirrorów (do szybszej instalacji):

   ```sh
   reflector -c Poland -a 12 --sort rate --save /etc/pacman.d/mirrorlist
   ```

8. Instalacja systemu Arch - kernel i podstawowy system:

   ```sh
   pacstrap /mnt base linux linux-firmware
   ```

9. Generowanie fstab i wejście do chroot:

   ```sh
   genfstab -U /mnt >> /mnt/etc/fstab
   arch-chroot /mnt
   ```

10. Ustawianie strefy czasowej i języka:

   ```sh
   ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
   hwclock --systohc
   pacman -S micro
   micro /etc/locale.gen - usuń znak # w linijkach en_US.UTF-8 UTF-8 i pl_PL.UTF-8 UTF-8
   locale-gen
   micro /etc/locale.conf  - dodaj: LANG=pl_PL.UTF-8
   micro /etc/vconsole.conf - dodaj: KEYMAP=pl
   ```

11. Ustawianie nazwy hosta i tworzenie użytkownika:

   ```sh
   micro /etc/hostname - dodaj archLenovo
   micro /etc/hosts - dodaj:
   	127.0.0.1		localhost
   	::1				localhost
   	127.0.1.1		archLenovo.localdomain	archLenovo
   passwd - ustaw hasło root'a
   useradd -m mm
   passwd mm - ustaw hasło dla mm
   usermod -aG wheel,audio,video,optical,storage mm
   pacman -S sudo
   EDITOR=micro visudo - usuń # przy linijce %wheel ALL=(ALL) ALL
   ```

12. Instalacja i ustawienie grub:

    ```sh
    pacman -S grub efibootmgr dosfstools os-prober mtools
    mkdir /boot/EFI
    mount /dev/mmcblk1p1 /boot/EFI
    grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
    grub-mkconfig -o /boot/grub/grub.cfg
    ```

13. Instalacja i uruchomienie Network Manager'a:

    ```sh
    pacman -S networkmanager
    systemctl enable NetworkManager
    ```

14. Wyjście i restart komputera:

    ```sh
    exit
    umount -R /mnt
    shutdown now
    ```

15. Po restarcie i zalogowaniu się podłączenie się do sieci:

    ```sh
    nmtui
    ```

16. Aktualizacja systemu:

    ```sh
    sudo pacman -Syu
    ```
17. Pobranie i uruchomienie skryptu do instalacji KDE Plasma i oprogramowania:

    ```sh
    curl -LO https://raw.githubusercontent.com/elkrien/arch-plasma/main/plasma-install.sh
    ./plasma-install.sh
    ```
