#!/bin/bash

#####################################
# Author : Sahil
# date   : 26/11/2024
# This script demonstrates Loops and conditionals
#####################################

echo "if loop"

read -p "enter value for a:" a
read -p "enter value for b:" b

if [ $a -gt $b ]
then
	echo "a is greater than b"
else
	echo "b is greater than a"
fi
echo
echo "##############################################"
echo

echo "For loop"

#for i in {1..10};
for i in $(seq $a $b);
do
	echo -n "$i";
	echo;
done;
echo

