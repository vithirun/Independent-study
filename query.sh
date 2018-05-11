if [ $# -lt 2 ]
then
    echo "*************************************************************************************"
    echo "       Usage - sh query.sh com.google.android.youtube video_playtime_in_minutes      "
    echo "*************************************************************************************"
    exit
fi
max_seq=`expr $2 \* 60 \* 1000`
# printf "$max_seq\n"
rm shellout.txt
rm apps.txt
rm Netstats.txt 

for i in `seq 1 $max_seq`
do

	# CPU usage
	tot_cpu=`adb shell top -b -n 1 | grep $1| awk -F" " '{print $9}'`
	cpu=`echo "scale=2; $tot_cpu/2" | bc -l`
	echo $cpu >> shellout.txt

#   Another command to fetch CPU usage of an application	
#	tot_cpu=`adb shell dumpsys cpuinfo | grep $1 | sed 's/:.*//' | awk -F" " '{ print $1 }' | head -1 | awk -F"%" '{print $1}'`
#	echo $tot_cpu
#	cpu=`expr $tot_cpu / 2`
#	echo $cpu >> shellout.txt

	# Memory Usage
	adb shell dumpsys meminfo | grep $1 | sed 's/:.*//' | awk -F" " '{ print $1 }' | head -1 >> shellout.txt
	adb shell dumpsys package > apps.txt
	user_id=`cat apps.txt | grep -A1 "Package \[$1\]" | grep "userId" | sed 's/.*userId=//'`
	echo $user_id
	
	# Network usage
	adb shell cat /proc/net/xt_qtaguid/stats > Netstats.txt
	cat Netstats.txt | grep $user_id | awk -F" " '{ print $6,$8 }' | tail -1 >> shellout.txt
	printf "\n" >> shellout.txt
	
	# wait time
	sleep 0.02s
done
