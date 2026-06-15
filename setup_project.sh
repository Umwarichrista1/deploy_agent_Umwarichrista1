#!/bin/bash

echo "enter your string name"
read input

if [ -d "attendance_tracker_${input}" ]; then
	echo " name already exist!"
	exit 1
fi	

mkdir -p attendance_tracker_${input}/helpers || { echo " input failed "; exit 1; }
mkdir -p attendance_tracker_${input}/reports || { echo " input failed "; exit 1; }

cp attendance_checker.py attendance_tracker_${input}/

cp helpers/assets.csv attendance_tracker_${input}/Helpers/
cp helpers/config.json attendance_tracker_${input}/Helpers/
cp reports/reports.log attendance_tracker_${input}/reports/

echo "done"
