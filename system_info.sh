#!/bin/bash

# Function to display CPU information
function display_cpu_info {
	echo "CPU Information: "
	cat /proc/cpuinfo | grep "Model Name: " | uniq | awk -F: '{print $2}'
	if command -v mpstat &> /dev/null; then
		mpstat | awk'/all/ {print"CPU Usage: " "100 - $NF"%"}'
	else 
		echo "mpstat command not found, skipping CPU useage display."
	fi
}

# Function to display memory useage
function display_memory_info {
	echo -e "\nMemory Information: "
	free -h | grep "Mem: " | awk '{print "Total: " $2 ", Used: " $ 3 ", Free: " $4}'
}

# Function to display disk space info
function display_disk_info {
	echo -e "\nDisk Space Information:"
	df -h | grep "/dev/root" | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4}'

}

# Function to network  info 
function display_network_info {
	echo -e "\nNetwork Information: "
	if command -v ifconfig &> /dev/null;then
		ifconfig | awk '/inet / {print "IP Address: " $2'
	else
		echo "ifconfig command not found, skipping network information display."
	fi
	if command -v iwconfig &> /dev/null; then 
		iwconfig 2>/dev/null | awk '/ESSID/ {print "Wi-Fi Network: " $NF}'
	else
		echo "iwconfig command not found, skipping Wi-Fi network display."
	fi
}

function main { 
	display_cpu_info
	display_memory_info
	display_disk_info
	display_network_info
}

# Execute the main function
main
