cp /etc/apt/sources.list /etc/apt/sources.list.back

num=`cat /etc/apt/sources.list | grep aliyun | wc -l`
if [ $num -ne 0 ];then
	echo "
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
	">/etc/apt/sources.list
	apt-get update
	apt-get upgrade
fi

apt-get install vim git minicom terminator zsh docker.io umake
echo vim git terminator zsh docker have been downloaded!
umake ide visual-studio-code

github=https://github.com/lifahao
cd ..
folders=(nvme-cli smart_grouping_tpcc smart_grouping)

for f in $folders;do
	if [ ! -d $f ];then
		git clone $github/$f
	fi
done

cd nvme-cli
make install


