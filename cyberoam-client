#!/bin/bash -e

login_success=0
ack_success=0
option=0
optcount=0
user=$1

function print_usage {
	echo "Usage: cyberoam-client [-d|-s] username"
	echo "-d : delete configuration file (if found) for username"
	echo "-s : save configuration file (override if already exists) for username"
	echo "If no option is specified, if config file for username exists it is then used otherwise no config file is used or created."
	echo "Press ctrl-c or send SIGINT to process to logout."
}

#parsing options
[[ $1 == "--help" ]] && print_usage && exit 0
while getopts ":d::s:" opt; do
	optcount= $[ $optcount + 1 ]
	[[ $optcount > 1 ]] && echo "Illegal number of options" >&2 && print_usage >&2 && exit -2
	case $opt in
		d)
			user=$OPTARG
			option=1
		;;
		s)
			user=$OPTARG
			option=2
		;;
		\?)
			echo "Invalid option: -$OPTARG" >&2 && print_usage >&2
			exit -2
		;;
		:)
			echo "Option -$OPTARG requires an argument." >&2 && print_usage >&2
			exit -2
	esac
done
[ $# -gt 3 ] && echo "Invalid number of arguments">&2 && print_usage>&2 && exit -2

conffile=~/.cyberoam_$user.conf
# processing option -d
if [ $option == 1 ]; then
	if [ -e $conffile ]; then
		rm $conffile && echo "Configuration file deleted succesfully"
	else
		echo "Specified Configuration file not found."
	fi
	exit 0
fi

function gather_details {
	echo -n "Cyberoam server ip address: "
	read url
	echo -n "Password for $user: "
	read -s password
	echo ""
}

# processing option -s and the lack of any option
if [ $option -eq 2 ]; then
	[ -e $conffile ] && echo "">$conffile
	gather_details
	echo "url='$url'">>$conffile
	echo "password=$password">>$conffile
elif [ -e $conffile ]; then
	. conffile
else
	gather_details
fi

function login {
	echo "Attempting login"
	response=`curl -s -k -d mode=191 -d username=$user -d password=$password https://$url:8090/login.xml`
	if [[ $response =~ "successfully logged in" ]]; then
		echo "Logged in successfully"
		login_success=1
	elif [[ $response =~ "Maximum Login Limit" ]]; then
		>&2 echo "Maximum Login Limit Reached"
		exit -1
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
	else
		echo "Logout failed"
	fi
	trap - SIGINT
	exit 0
}


# attempt=0 means it will attempt to login, 1 means ack
attempt=0
while [ 1 ]
do
	case $attempt in
		0)	login
			[[ $login_success == 1 ]] && attempt=1 && trap logoutt SIGINT
		;;
		1)	sleep 180
			ack
			[[ $ack_success == 0 ]] && echo "Acknowledgement failed" && attempt=0
		;;
	esac
done
