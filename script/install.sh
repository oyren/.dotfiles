#!/bin/sh
#Ascii Standard
RED='\033[0;31m'
NC='\033[0m' # No Color
cat <<"EOF"

---------------------------------------------------------------------------------
  ___           _        _ _ _               ____        _    __ _ _
 |_ _|_ __  ___| |_ __ _| | (_)_ __   __ _  |  _ \  ___ | |_ / _(_) | ___  ___
  | || '_ \/ __| __/ _` | | | | '_ \ / _` | | | | |/ _ \| __| |_| | |/ _ \/ __|
  | || | | \__ \ || (_| | | | | | | | (_| | | |_| | (_) | |_|  _| | |  __/\__ \
 |___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/
                                     |___/
---------------------------------------------------------------------------------
EOF
echo -e "${RED}Attention:${NC} Input is not checked${RED}!!!${NC}"
echo "Example (/home/user)"
read -p "Enter the path to Home: " HOMEDIR
echo $HOMEDIR
USERNAME=${HOMEDIR##*/}
echo $USERNAME
if [ "$EUID" -e 0 ]
then mkdir $HOMEDIR
     exit
fi
mv dotfiles/ $HOMEDIR/.dotfiles
cat <<"EOF"
--------------------------
  _   _ _
 | \ | (_)_  _____  ___
 |  \| | \ \/ / _ \/ __|
 | |\  | |>  < (_) \__ \
 |_| \_|_/_/\_\___/|___/
--------------------------
EOF
echo "If you do not want to copy the configuration.nix file or do not use Nixos select Quit."
PS3='Please select for which Device you want to install nixos: '
options=("P50" "HP_Pro_430" "Quit")
select opt in "${options[@]}"
do
    case $opt in
                 "P50")
                    if [ "$EUID" -ne 0 ]
                       then echo "If you want to install Nixos, please run as root"
                       exit
                    fi
                    DEVICE="p50"
                    echo "Installing Dotfiels for "$DEVICE
                    echo "---------------------------"
                    echo "link configuration.nix to /etc/nixos/"
                    ln -f $HOMEDIR/.dotfiles/nixos/$DEVICE/configuration.nix /etc/nixos/configuration.nix
                    mkdir $HOMEDIR/.nixpkgs
                    echo "link config.nix to ~/.nixpkgs/config.nix"
                    ln -f $HOMEDIR/.dotfiles/nixos/$DEVICE/config.nix $HOMEDIR/.nixpkgs/config.nix
                    chown -R root:root /etc/nixos
                    echo "---------------------------"
                    echo "---------------------------"
                    break
                    ;;
                 "HP_Pro_430")
                     if [ "$EUID" -ne 0 ]
                     then echo "If you want to install Nixos, please run as root"
                          exit
                     fi
                     DEVICE="HP_Pro_430"
                     echo "Installing Dotfiels for "$DEVICE
                     echo "---------------------------"
                     echo "link configuration.nix to /etc/nixos/"
                     ln -f $HOMEDIR/.dotfiles/nixos/$DEVICE/configuration.nix /etc/nixos/configuration.nix
                     mkdir $HOMEDIR/.nixpkgs
                     echo "link config.nix to ~/.nixpkgs/config.nix"
                     ln -f $HOMEDIR/.dotfiles/nixos/$DEVICE/config.nix $HOMEDIR/.nixpkgs/config.nix
                     chown -R root:root /etc/nixos
                     echo "---------------------------"
                     echo "---------------------------"
                     break
                    ;;
                 "Quit")
                    echo "Without configuration.nix"
                    break
                    ;;
        *) echo invalid option;;
    esac
done
cat <<"EOF"
------------------------------------------------
__  __                                _
\ \/ /_ __ ___   ___  _ __   __ _  __| |
 \  /| '_ ` _ \ / _ \| '_ \ / _` |/ _` |
 /  \| | | | | | (_) | | | | (_| | (_| |
/_/\_\_| |_| |_|\___/|_| |_|\__,_|\__,_|
------------------------------------------------
EOF

read -n1 -p "Install Xmonad Dotfiles [y,n]" doit
case $doit in
    y|Y)
        PS3='Please select for which Device you want to install Xmobar: '
        options=("P50" "HP_Pro_430" "Quit")
        select opt in "${options[@]}"
        do
            case $opt in
                "P50")
                    $DEVICE="p50"
                    echo "Installing dotfiels for "$DEVICE
                    echo "------------ Xmonad ---------------"
                    mkdir $HOMEDIR/.xmonad
                    perl -p -i.bak -e "~s|/home/user|"$HOMEDIR"|" $HOMEDIR/.dotfiles/xmonad/P50/xmobarrc
                    ln -f $HOMEDIR/.dotfiles/xmonad/$DEVICE/xmobarrc $HOMEDIR/.xmonad/xmobarrc
                    ln -f $HOMEDIR/.dotfiles/xmonad/$DEVICE/xmonad.hs $HOMEDIR/.xmonad/xmonad.hs
                    break
                    ;;
                "HP_Pro_430")
                    $DEVICE="HP_Pro_430"
                    echo "Installing dotfiels for "$DEVICE
                    echo "------------ Xmonad ---------------"
                    mkdir $HOMEDIR/.xmonad
                    perl -p -i.bak -e "~s|/home/user|"$HOMEDIR"|" $HOMEDIR/.dotfiles/xmonad/P50/xmobarrc
                    ln -f $HOMEDIR/.dotfiles/xmonad/$DEVICE/xmobarrc $HOMEDIR/.xmonad/xmobarrc
                    ln -f $HOMEDIR/.dotfiles/xmonad/$DEVICE/xmonad.hs $HOMEDIR/.xmonad/xmonad.hs
                    break
                    ;;
                "Quit")
                    echo "Without xmobar"
                    break
                    ;;
                *) echo invalid option;;
            esac
        done
        echo -e
        ;;
    n|N)
        echo -e
        echo "no"
        echo -e
        ;;
    *) echo invalid option ;;
esac
cat <<"EOF"
-------------------------------------------------------
 ____
/ ___| _ __   __ _  ___ ___ _ __ ___   __ _  ___ ___
\___ \| '_ \ / _` |/ __/ _ \ '_ ` _ \ / _` |/ __/ __|
 ___) | |_) | (_| | (_|  __/ | | | | | (_| | (__\__ \
|____/| .__/ \__,_|\___\___|_| |_| |_|\__,_|\___|___/
      |_|
-------------------------------------------------------
EOF
read -n1 -p "Install Spacemacs [y,n]" doit
case $doit in
    y|Y)
        echo "Installing Spacemacs"
        rm ~/.emacs
        git clone https://github.com/syl20bnr/spacemacs $HOMEDIR/.emacs.d
        echo "link spacemacs configfile to ~/.spacemacs"
        ln -f $HOMEDIR/.dotfiles/.spacemacs ~/.spacemacs
        echo -e
        ;;
    n|N)
        echo -e
        echo "no"
        echo -e
        ;;
  *) echo invalid option ;;
esac
chown -R $USERNAME:users $HOMEDIR

chmod 750 $HOMEDIR/.dotfiles/script/brightness_dec.sh
chmod 750 $HOMEDIR/.dotfiles/script/brightness_inc.sh
chmod 750 $HOMEDIR/.dotfiles/script/webdav.sh
chown root:users $HOMEDIR/.dotfiles/script/brightness_dec.sh
chown root:users $HOMEDIR/.dotfiles/script/brightness_inc.sh
chown root:users $HOMEDIR/.dotfiles/script/webdav.sh

echo -e "${RED}Attention:${NC} Installation completed ${RED}!!!${NC}"
echo -e "${RED}Attention:${NC} You may need to change the rights and owner of the home directory ${RED}!!!${NC}"
# echo -e "chown -R user:users /home/user"
