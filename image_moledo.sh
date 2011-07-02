#!/bin/bash

path=/home/webcam
seq=1;
seq2=-19;

echo "var sequence = 1;" > $path/httpdocs/smoledo.js
rm -f $path/httpdocs/moledo*

while true; do 

	file=$(ls  $path/upload/moledo* | sort | sed '$d' | tail -n 1)

	if test $file -nt $path/tmpmoledo;
	then
		touch $path/tmpmoledo	
		/usr/bin/php convert_moledo.php $file > $path/httpdocs/moledo$(echo $seq).jpg 2> /dev/null
	        cp $path/httpdocs/moledo$(echo $seq).jpg $path/httpdocs/wmoledo.jpg	
		
		seq=$(($seq+1));
		if test $(($seq % 20)) -eq 0;
			then
				seq2=$(($seq2+20));
				echo "var sequence = $seq2;" > $path/httpdocs/smoledo.js
		fi
		sleep 3;
	else
		sleep 2;
	fi
	find $path/upload/moledo* -type f -mmin +5 -exec rm {} \; 2> /dev/null
done
