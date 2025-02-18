#!/bin/bash

detect_distro() {
    if [[ "$OSTYPE" == linux-android* ]]; then
            distro="termux"
    fi

    if [ -z "$distro" ]; then
        distro=$(ls /etc | awk 'match($0, "(.+?)[-_](?:release|version)", groups) {if(groups[1] != "os") {print groups[1]}}')
    fi

    if [ -z "$distro" ]; then
        if [ -f "/etc/os-release" ]; then
            distro="$(source /etc/os-release && echo $ID)"
        elif [ "$OSTYPE" == "darwin" ]; then
            distro="darwin"
        else 
            distro="invalid"
        fi
    fi
}

pause() {
    read -n1 -r -p "Free Key Gir..." key
}
banner() {
    clear
    echo -e "\e[1;31m"
    if ! [ -x "$(command -v figlet)" ]; then
        echo 'Introducing JTH Hack'
    else
        figlet JTH Hack
    fi
    if ! [ -x "$(command -v toilet)" ]; then
        echo -e "\e[4;34m This Bomber Was JOKER WEP \e[1;32mJoker \e[0m"
    else
        echo -e "\e[1;34mJOKER WEP \e[1;34m"
        toilet -f mono12 -F border SpeedX
    fi
    echo -e "\e[1;34mHerhangi Bir Sorunuz Varsa Bana Katılın!!! \e[0m"
    echo -e "\e[1;32m           Telegram: https://t.me/JTH_chat \e[0m"
    echo -e "\e[4;32m   İnstagram: https://ig.me/j/Abb1O_-ikTahnLgP/"
    echo " "
    echo "NOTE: Daha fazla istikrar için lütfen JTH Hack'un PIP sürümüne geçin ."
    echo " "
}

init_environ(){
    declare -A backends; backends=(
        ["arch"]="pacman -S --noconfirm"
        ["debian"]="apt-get -y install"
        ["ubuntu"]="apt -y install"
        ["termux"]="apt -y install"
        ["fedora"]="yum -y install"
        ["redhat"]="yum -y install"
        ["SuSE"]="zypper -n install"
        ["sles"]="zypper -n install"
        ["darwin"]="brew install"
        ["alpine"]="apk add"
    )

    INSTALL="${backends[$distro]}"

    if [ "$distro" == "termux" ]; then
        PYTHON="python"
        SUDO=""
    else
        PYTHON="python3"
        SUDO="sudo"
    fi
    PIP="$PYTHON -m pip"
}

install_deps(){
    
    packages=(openssl git $PYTHON $PYTHON-pip figlet toilet)
    if [ -n "$INSTALL" ];then
        for package in ${packages[@]}; do
            $SUDO $INSTALL $package
        done
        $PIP install -r requirements.txt
    else
        echo "Bağımlılıkları yükleyemedik ."
        echo "Lütfen git'inizin olduğundan emin olun,  python3, pip3 ve gereksinimleri kuruldu." 
        echo "Daha sonra çalıştırabilirsiniz  bomber.py ."
        exit
    fi
}

banner
pause
detect_distro
init_environ
if [ -f .update ];then
    echo "Tüm Gereksinimler Bulundu..." 
else
    echo 'Gereksinimler yükleniyor... .'
    echo .
    echo .
    install_deps
    echo This Script Was Made By Joker > .update
    echo 'Gereksinimler Yüklendi....' 
    pause
fi
while :
do
    banner
    echo -e "\e[4;31m Lütfen Talimatları Dikkatlice Okuyun !!! \e[0m"
    echo " "
    echo "[[1]]=SMS  Bomber♧ "
    echo "[[2]]CALL Bomber♤ "
    echo "[[3]]MAIL Bomber◇(Bakımda)"
    echo "[[4]] Update (Linux ve Linux Emülatörlerinde Çalışır) " 
    echo "[[5]] Çıkış "
    read ch
    clear
    if [ $ch -eq 1 ];then
        $PYTHON bomber.py --sms
        exit
    elif [ $ch -eq 2 ];then
        $PYTHON bomber.py --call
        exit
    elif [ $ch -eq 3 ];then
        $PYTHON bomber.py --mail
        exit
    elif [ $ch -eq 4 ];then
        echo -e "\e[1;34m Downloading Latest Files..."
        rm -f .update
        $PYTHON bomber.py --update
        echo -e "\e[1;34m RUN TBomb Again..."
        pause
        exit
    elif [ $ch -eq 5 ];then
        banner
        exit
    else
        echo -e "\e[4;32m Invalid Input !!! \e[0m"
        pause
    fi
done
