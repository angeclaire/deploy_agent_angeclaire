#!/bin/bash
# Get project name from user

echo "Enter project name"
read INPUT
#step 1: Store the full project directory name in a variable

PROJECT_DIR="attendance_tracker_${INPUT}"

# STEP 2: Define the trap cleanup function

handle_interrupt() {
    echo "Interrupt detected! Archiving and cleaning up..."
    tar -czf "${PROJECT_DIR}_archive.tar.gz" "$PROJECT_DIR"
    rm -rf "$PROJECT_DIR"
    echo "Archive saved as ${PROJECT_DIR}_archive.tar.gz"
    exit 1
}
# STEP 3: Register the trap BEFORE creating any files

trap handle_interrupt SIGINT
# STEP 4: Create the project directory structure

mkdir -p "${PROJECT_DIR}/Helpers"
mkdir -p "${PROJECT_DIR}/reports"
# STEP 5: Copy source files into correct locations

cp attendance_checker.py "${PROJECT_DIR}/attendance_checker.py"
cp assets.csv "${PROJECT_DIR}/Helpers/assets.csv"
cp config.json "${PROJECT_DIR}/Helpers/config.json"
cp reports.log "${PROJECT_DIR}/reports/reports.log"

echo "Do you want to update attendance thresholds? (yes/no)"
read ANSWER
# STEP 6: Dynamic configuration using sed

if [ "$ANSWER" == "yes" ]; then
    echo "Enter Warning threshold (default 75):"
    read WARNING

    echo "Enter Failure threshold (default 50):"
    read FAILURE

    sed -i "s/\"warning\": [0-9]*/\"warning\": $WARNING/" "${PROJECT_DIR}/Helpers/config.json"
    sed -i "s/\"failure\": [0-9]*/\"failure\": $FAILURE/" "${PROJECT_DIR}/Helpers/config.json"

    echo "Config updated successfully!"

elif [ "$ANSWER" == "no" ]; then
    echo "Keeping default thresholds (warning: 75, failure: 50)"
fi

# STEP 7: Environment validation (Health Check)

echo "Running health check "
if python3 --version &>/dev/null; then
    echo "Python3 is installed: $(python3 --version)"
else
    echo "Warning: Python3 is NOT installed."
fi

 #STEP 8: Final success message

echo  " Project ${PROJECT_DIR} created successfully!"
