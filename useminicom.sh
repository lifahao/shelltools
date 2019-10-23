#########################################################################
# File Name: useminicom.sh
# Author: lfh
# mail:lifahao@dputech.com
# Created Time: 2019年08月06日 星期二 17时58分14秒
#########################################################################
#!/bin/bash
sudo echo KERNEL=="ttyUSB[0-9]*", MODE="0666" | tee -a /etc/udev/rules.d/70-ttyusb.rules
sudo echo 'source ~/myminicom.sh'>>~/.zshrc
source ~/.zshrc
