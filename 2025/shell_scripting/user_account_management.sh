#!/bin/bash

<<info

Author: Aditi Jain
Desc: This is a user account management script.

info

function create_user_account {

echo -e "############# Account Creation #################\n"
read -p "Enter Username => " username

count=$(cat /etc/passwd | grep $username | wc | awk '{print $1}')

echo "Checking if the username already exists -----------> "

if [[ $count -eq "0" ]];
then
	echo -e "############### User does not exist, Creating new user ###############"
	read -p "Enter Password for $username => " user_password
	sudo useradd -m $username
	echo -e "$user_password\n$user_password" | sudo passwd $username > /dev/null 2>&1
	echo -e "###############  User $username Created successfully #################"
else
	echo "################## $username Already Exists ################"
fi

}


function delete_user {

echo -e "############## Account Deletion ################\n"

read -p "Enter Username => " username

count=$(cat /etc/passwd | grep $username | wc | awk '{print $1}')

echo -e "Checking if username exists or not ------------> \n"

if [[ $count -eq 0 ]];
then
	echo "User does not exists"
else
	echo "User Exists, Initiating Deletion =>"
	
	sudo deluser $username >> /dev/null 2>&1
	echo "User Deleted Successfully"

fi

}


function reset_password {

echo "############## Reset Password ################"

read -p "Enter Username => " username

count=$(cat /etc/passwd | grep $username | wc | awk '{print $1}')

echo -e "Checking if username exists or not ------------> \n"

if [[ $count -eq 0 ]];
then
        echo "User does not exists"
else
        read -p "Enter New Password => " new_password

        echo -e "$new_password\n$new_password" | sudo passwd $username >> /dev/null 2>&1
        echo " Password Reset for $username Completed Successfully"

fi

}

function show_all_users {

	echo -e "############# Displaying all current users ################# \n\n"

	cat /etc/passwd | sed 's/:/ /g' | awk '{print $1,$3 }'

}


function display_menu {

#echo -e "######### Help and Usage Information ######### \n\n"
echo -e "Write -c or --create for Account Creation"
echo -e "Write -d or --delete for Account Deletion"
echo -e "Write -r or --reset for Password Reset"
echo -e "Write -l or --list for List User Accounts"
echo -e "Write -h or --help for Help and Usage Information\n"
echo -e "Write -exit to end"

}



while true; do
	display_menu

	read -p "Enter choice " choice

	case $choice in
		-c|--create)
			#echo "Creation"
			create_user_account
			;;
		-d|--delete)
			#echo "Delete"
			delete_user
			;;
		-r|--reset)
			#echo "Reset"
			reset_password
			;;
		-l|--list)
			#echo "List"
			show_all_users
			;;
		-h|--help)
			#echo "Menu"
			echo -e "######### Help and Usage Information ######### \n\n"
			display_menu
			;;
		-exit)
			echo "Exiting..."
			exit 0
			;;
		*)
			echo "Choose a valid option"
			;;

	esac
done

