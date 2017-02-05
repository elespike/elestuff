#! /bin/bash

ip link show dev ${1} &> /dev/null
if [[ ${?} != 0 ]]
then
    echo "Usage: chmac.sh <ifname>"
    exit
fi

function get_byte {
    echo $(head /dev/urandom | tr -dc a-f0-9 | head -c 2)
}

function get_even_byte {
    echo $(head /dev/urandom | tr -dc ace02468 | head -c 2)
}

mac=""

for i in {1..3}
do
    mac="${mac}$(get_even_byte):"
done

for i in {1..2}
do
    mac="${mac}$(get_byte):"
done

mac="${mac}$(get_byte)"

ip link set dev "${1}" down
[[ ${?} == 0 ]] && ip link set dev "${1}" address ${mac}
[[ ${?} == 0 ]] && ip link set dev "${1}" up
[[ ${?} == 0 ]] && echo "Changed ${1}'s MAC to ${mac}!"
[[ ${?} == 0 ]] || echo "Error changing MAC on ${1}!"
