#!/bin/sh

###ruroot 
###functions
mount_device(){

	mount /dev/sda$input /tmp/mydevice ### if the device is mounted
		if [ $? -eq 0 ]; then
			echo -n 'sda'$input 'mounted on /tmp/mydevice'
			echo
			cd /tmp/mydevice
			ls -l
		else
			echo 'mount operation failed'
		fi

}



clear;

echo 

lsblk |  awk '{print $1 ,"    ",$4, "  ", $7}' | grep -v sr0

echo
echo
echo '1. mount'
echo '2. unmount'
echo '--------------'
echo -n 'make your choice: '
read choice

while true
do
	if [ $choice = "1" ];
	then
			echo -n 'mount device sda'

			read input

			while true
			do
				if [  $input -le 1 ] || [ $input -ge 5 ];
				then
					echo -n 'mount device sda'
					read $input
				else
					break
				fi
			done



			mkdir /tmp/mydevice

			if [ $? -eq 0 ]; then ### if the directory is created
				clear
				mount_device
				
				break
			else 
				clear
				echo 'there is already a directory /tmp/mydevice'
				echo 'trying to mount it again...'
				cd
				umount /tmp/mydevice
				mount_device
				break 
			fi
	elif [ $choice = 2 ];
	then
		cd
		echo -n 'unmount device sda'
		read u_mount
		umount /dev/sda$u_mount
		if [ $? -eq 0 ]; then
			echo 'sda'$u_mount 'unmounted successfully.'
		else
			clear
			echo 'sda'$u_mount "couldn't unmounted. It may be already unmounted." 
		fi
		break
	else
		echo
		echo '1. mount'
		echo '2. unmount'
		echo '--------------'
		echo -n 'make your choice: '
		read choice
	fi

done

	
	
