echo 选择apt或者ukuu方式升级内核
echo 当前内核版本：`uname -r`
select var in "apt" "ukuu"
do
    if [ $var == "ukuu" ];then
        sudo add-apt-repository ppa:teejee2008/ppa 
        sudo apt-get update
        sudo apt-get install ukuu
        ukuu --version
        ukuu-gtk
    elif [ $var == "apt" ];then
        sudo apt update
        sudo apt upgrade
        apt-get install linux-image-4.4.0-15-generic
        dpkg --get-selections | grep linux-image
        update-grub
        echo 需要重启
    else
        echo 输入错误
    fi
done
