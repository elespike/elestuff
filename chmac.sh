#! /bin/bash

function get_byte {
    echo $(head /dev/urandom | tr -dc a-f0-9 | head -c 2)
}

function get_even_byte {
    echo $(head /dev/urandom | tr -dc ace02468 | head -c 2)
}

mac=""

for i in {1..3}
do
    mac="$mac$(get_even_byte):"
done

for i in {1..2}
do
    mac="$mac$(get_byte):"
done

mac="$mac$(get_byte)"

if [[ -n $1 ]] && [[ -n $(ip link show dev $1) ]]
then
    ip link set dev $1 down &&
    ip link set dev $1 address $mac &&
    ip link set dev $1 up &&
    echo "Changed $1's MAC to $mac!"
else
    echo "Invalid or no interface specified!"
fi
