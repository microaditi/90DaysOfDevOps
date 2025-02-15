#!/bin/bash


<<info 

Author => Aditi Jain
Desc => This scripts take a directory as an argument, which needs to be backed up, and keeps only recent 3 backups in the dir and removes the older version of backup

info

function take_backup(){
        
	src=/home/ubuntu/scripts/rancho
	backup_dest=$1
	timestamp=$(date '+%Y-%m-%d_%H-%M-%S') 

	echo "Destionation => $backup_dest"	
	echo $timestamp
	
	cd $backup_dest && tar -cvf "backup_$timestamp.tar" $src

	pwd

	ls


}


function delete_all_except_3(){
 
	cd  "$1"
	pwd
	ls -t backup* | tail -n +4 | xargs rm -v --
	ls -t

}

take_backup $1
delete_all_except_3 $1
