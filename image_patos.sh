#!/bin/bash

path=/home/webcam
seq=1;
seq2=-19;

echo "var sequence = 1;" > $path/httpdocs/spatos.js
rm -f $path/httpdocs/patos*

while true; do 

	file=$(ls  $path/upload/newwebcam* | sort | sed '$d' | tail -n 1)

	if test $file -nt $path/tmppatos;
	then
		touch $path/tmppatos	
		/usr/bin/php convert_patos.php $file > $path/httpdocs/patos$(echo $seq).jpg 2> /dev/null
	        cp $path/httpdocs/patos$(echo $seq).jpg $path/httpdocs/wpatos.jpg	
		
		seq=$(($seq+1));
		if test $(($seq % 20)) -eq 0;
			then
				seq2=$(($seq2+20));
				echo "var sequence = $seq2;" > $path/httpdocs/spatos.js
		fi
		sleep 3;
	else
		sleep 2;
	fi
	find $path/upload/newwebcam* -type f -mmin +5 -exec rm {} \; 2> /dev/null
done
