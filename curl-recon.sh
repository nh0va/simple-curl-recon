#!/bin/bash

function result {
	url=$1
	responlen=$(curl -Is $1 | grep 'HTTP\|Content-Length')
	response=$(echo "$responlen" | grep HTTP | cut -d " " -f 2)
	length=$(echo "$responlen" | grep Content-Length | cut -d " " -f 2)
	output="$url, $response, $length"
	
	echo "$output"
}

function loop {
	for i in `cat $1`;do
		result $i
	done
}

function incorrectArguments {
	echo "Incorrect quantity of arguments"
	exit
}

## START ARGUMENT CONTROL

if [ $# -ne 1 ]; then
	incorrectArguments
fi

## END ARGUMENT CONTROL

## MAIN

echo "Do you want a .csv output? [y/n]"
read option

if [[ $option = "y" ]] || [[ $option = "Y" ]]; then
	echo "Working..."
	output=$(loop $1)
	echo "$output"
	echo "$output" > output.csv
	exit
fi

echo "Working..."
echo "$(loop $1)"

## END MAIN
