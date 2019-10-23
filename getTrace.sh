#!/bin/bash
#.cal.sh blkparse_0 6
#$1:解析文件
#$2:cpu数目
TMP_DIR=".blktrace_cal"

# extend the blktrace log to "blockid R/W"
extend()
{   #$1       $2       $3    $4          $5     $6  $7  $8       $9 $10
    #259,0    3        2     0.000000871 27752  Q   R 168036672  +  32  [mysqld]
    #第6列有D，里面有R或者W
    #max=$2 mod=$3中的$2是指extend参数parrel最大并行度6，$3代表第几个任务

    awk -v max=$2 -v mod=$3 '{
        if ( NR%max==mod && $6 == "D" && (index($7, "R") || index($7, "W")) ) {
            print $4,$7,$8,$10
        }
    }' $1 | sort -k1 > $TMP_DIR/.tmp.$1.$3
    touch $TMP_DIR/$3.ok
}

usage()
{
    echo "Usage: $1 input_log [parallel_num]"
    exit
}

rm -rf $TMP_DIR
mkdir $TMP_DIR

if [ "$1" == "" ]; then
    usage $0
fi

# does input_log exists?
if [ ! -f $1 ]; then
    echo "($1) not exists"
    exit
fi

parallel=$2

if [ "$2" == "" ]; then
    parallel=4
fi

echo "[input: $1]"

max=`expr $parallel - 1`
files=""
filename=`basename $1`

echo "[run $parallel process]"

for i in `seq 0 $max`
do
    extend $filename $parallel $i &
    files=$files" $TMP_DIR/.tmp.$filename.$i"
done
echo "processing...."

nr=0
# awk will finish if all *.ok created.
while [ $nr -ne "$parallel" ]
do
    nr=`find $TMP_DIR -maxdepth 1 -name "*.ok"|wc -l`
    echo -n "."
    sleep 1
done
echo "merge sort begin"
#sort -m -k1 -nr:合并排好序的LBA
#uniq -c :统计行数，增加前缀计数
#sort -k1 -nr：根据计数再排序
sort -m -k1 -nr $files | sort -k1 > result.$1.tmp
echo "merge sort finish"