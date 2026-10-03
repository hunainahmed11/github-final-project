#!/usr/bin/env bash
set -eu

is_non_negative_number() {
	[[ $1 =~ ^[0-9]+([.][0-9]+)?$ ]]
}

read -r -p "Enter the principal amount: " principal
read -r -p "Enter the annual rate of interest (%): " rate
read -r -p "Enter the time period (years): " time

for value in "$principal" "$rate" "$time"; do
	if ! is_non_negative_number "$value"; then
		echo "Please enter non-negative numbers for principal, rate, and time." >&2
		exit 1
	fi
done

interest=$(awk -v principal="$principal" -v rate="$rate" -v time="$time" \
	'BEGIN { printf "%.2f", principal * rate * time / 100 }')

printf 'Simple interest: %s\n' "$interest"
