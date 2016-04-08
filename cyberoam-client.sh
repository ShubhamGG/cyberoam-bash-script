#!/bin/bash

login_success=0
ack_success=0
conffile=~/.cyberoam_$1.conf
user=$1
function login {
	echo "Attempting login"
	response=`curl -s -k -d mode=191 -d username=$user -d password=$password https://$url:8090/login.xml`
	if [[ $response =~ "You have successfully logged in" ]]; then
		echo "Logged in successfully"
		login_success=1
	else
		echo "Login failed"
		login_success=0
	fi
}

function ack {
	echo "Sending keep-alive request `date +%H:%M:%S`"
	response=`curl -s -k -G -d mode=192 -d username=$user https://$url:8090/live`
	if [[ $response =~ "<ack><![CDATA[ack]]></ack>" ]]; then
		ack_success=1
	else
		ack_success=0
	fi
}

function logoutt {
	echo "Attempting logout"
	response=`curl -s -k -d mode=193 -d username=$user https://$url:8090/logout.xml`
	if [[ $response =~ "You have successfully logged off" ]]; then
		echo "Logged out successfully"
		exit 0
	else
		echo "Logout failed"
	fi
}
if [ ! -e $conffile ]
	then
	if [ $# -ne 1 ]
		then echo "Error: Illegal number of parameters.\n Usage: cyberoam_client <username>"
		exit 0
	fi
	echo -n "Cyberoam server ip address: "
	read url
	echo "url='$url'">>$conffile
	echo -n "Password for $1: "
	read -s password
	echo "password=$password">>$conffile
else . $conffile
fi

# attempt=0 means it will now attempt to login, 1 means ack
attempt=0
while [ 1 ]
do
	case $attempt in
		0)	login
			[[ $login_success == 1 ]] && attempt=1 && trap logoutt SIGINT
		;;
		1)	ack
			if [[ $ack_success == 1 ]]; then sleep 180;
			else
				echo "Acknowledgement failed"
				attempt=0
			fi
		;;
	esac
done
