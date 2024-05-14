#/usr/bin/env bash
#
set -e
exec > >(tee bootstrap_labs.out)
exec 2>&1

read -r -p "How many labs: " number

# Make sure input is provided else die with an error
if [[ "$number" == "" ]]
then
    echo "$0 - Input is missing."
    exit 1
fi


# The regular expression matches digits only
if [[ "$number" =~ ^[0-9]+$ || "$number" =~ ^[-][0-9]+$  ]]
then
  date
  lab=0
  while [ $lab -ne $number ]
  do
    lab=$(($lab+1))
    echo "cfl-lab${lab}:"
    ./workspace.sh "cfl-lab${lab}" apply | tee "bootstrap_lab${lab}.log" &
  done
  date
else
    echo "$0 - $number is NOT an integer. Please enter integers only."
fi
