#!/bin/bash

if [ $# -eq 0 ]
then
  echo "Enter domain"
  exit
fi

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
echo "Gathering information on $1"

echo -e "${GREEN}--- CHECKING FOR HEARTBEAT ---${NC}"
((count = 20))
while [ $count -ne 0 ]
do
	ping -c 1 $1
	rc=$?
	if [ $rc -eq 0 ]
	then
		echo -e "${BLUE}$1 HAS A STABLE CONNECTION${NC}"
		break
	fi
	(( count = count - 1 ))
done
if [ $count -eq 0 ]
then
	echo -e "${RED}$1 DOES NOT HAVE A STABLE CONNECTION${NC}"
	exit
fi

echo -e "${GREEN}----- RUNNING TRACEROUTE -----${NC}"
traceroute $1
echo -e "${GREEN}------- RUNNING WHOIS --------${NC}"
whois $1
echo -e "${GREEN}-------- RUNNING DIG ---------${NC}"
dig $1
echo -e "${GREEN}----------- end --------------${NC}"
