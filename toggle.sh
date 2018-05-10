if [ $# -lt 2 ]
then
    echo "*************************************************************************************"
    echo "*       Usage - sh toggle.sh 500        										  	  *"
	echo "*       count - Toggle Times                                                        *"
    echo "*************************************************************************************"
    exit
fi
max_seq=$1

# Finding Screen resolution size
x=`adb shell wm size | awk -F": " '{ print $2 }' | awk -F"x" '{ print $1 }'`
y=`adb shell wm size | awk -F": " '{ print $2 }' | awk -F"x" '{ print $2 }'`


# Random co-ordinates to initiate swipe function
for i in `seq 1 $max_seq`
do
	x1=`shuf -i 10-$x -n 1`
	x2=`shuf -i 10-$y -n 1`
	y1=`shuf -i 10-$x -n 1`
	y2=`shuf -i 10-$y -n 1`
	
	# Swipe function
	adb shell input touchscreen swipe $x1 $y1 $x2 $y2
	# Default No sleep time
    # sleep 1s
done
