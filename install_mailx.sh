#download
wget http://ftp.debian.org/debian/pool/main/h/heirloom-mailx/heirloom-mailx_12.5.orig.tar.gz

gzfile=`ll | grep mailx | awk'{print $9'}

#extract
extract_dir=/usr/src/mailx-12.5
tar xzvf $gzfile -C /usr/src && cd  $extract_dir 

#make
make install  UCBINSTALL=/usr/bin/install 
make -V



