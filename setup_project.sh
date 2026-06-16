#!/bin/bash
# Trap function
cleanup() {
    echo "Script interrupted!"
    if [ -d "attendance_tracker_${input}" ]; then
        tar -czf attendance_tracker_${input}_archive.tar.gz attendance_tracker_${input}/
        echo "Archived to attendance_tracker_${input}_archive.tar.gz"
        rm -rf attendance_tracker_${input}
        echo "Incomplete directory deleted"
    fi
    exit 1
}

trap cleanup SIGINT

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


# Ask user if they want to update thresholds
echo "Do you want to update attendance thresholds?:yes or no"
read answer

if [ "$answer" == "yes" ]; then
    echo "Enter new Warning threshold (default 75):"
    read warning

    if ! [ "$warning" -eq "$warning" ] 2>/dev/null; then
        echo "Warning threshold must be a number!"
        exit 1
    fi


    echo "Enter new Failure threshold (default 50):"
    read failure

    if ! [ "$failure" -eq "$failure" ] 2>/dev/null; then
        echo "Failure threshold must be a number!"
        exit 1
    fi

    sed -i "s/\"warning\": 75/\"warning\": ${warning}/" attendance_tracker_${input}/Helpers/config.json
    sed -i "s/\"failure\": 50/\"failure\": ${failure}/" attendance_tracker_${input}/Helpers/config.json

    echo "Thresholds updated! Warning: ${warning}% Failure: ${failure}%"
else
    echo "Keeping default thresholds. Warning: 75% Failure: 50%"
fi

# Health Check
echo "Running health checking"

# Check python3
if command -v python3 &>/dev/null; then
    echo "Python3 is installed: $(python3 --version)"
else
    echo "Python3 is not installed"
fi

# Check directory structure
if [ -f "attendance_tracker_${input}/attendance_checker.py" ] && \
   [ -f "attendance_tracker_${input}/Helpers/assets.csv" ] && \
   [ -f "attendance_tracker_${input}/Helpers/config.json" ] && \
   [ -f "attendance_tracker_${input}/reports/reports.log" ]; then
    echo "Directory verified!"
else
    echo " Directory failied"
fi
echo "created successfully"
