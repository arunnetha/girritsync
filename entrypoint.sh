#!/bin/bash

printf "Checking for config_inc.php..."
if [ -f "/config/config_inc.php" ]
then 
	chown www-data:www-data /config/config_inc.php
	printf "Found\n"
	printf "  Checking for instalation folder..."
	if [ -d "/var/www/html/admin" ]
	then 
		printf "Found\n"
		printf "    Atempting to remove..."
		rm -rf /var/www/html/admin
		if [ -d "/var/www/html/admin" ]
		then
			printf "Failed\n"
		else
			printf "Removed\n"
		fi
	else
		printf "Missing - Good\n"
	fi
else
	printf "Missing\n"
	printf "Please use setup /admin/install.php \n"
fi

printf "\n\n"


exec apache2-foreground