#deploy_agent_angeclaire

## What my script does 

gitclone https://github.com/angeclaire/deploy_agent_angeclaire.git
cd deploy_agent_angeclaire
chmod +x setup_project.sh
./setup_project.sh
 
## What my script does
when you start to run the script, it will prompt you to enter the project name . It will the automatically build the full project directory named "attendance_tracker_{ name }" and place all the necessary files inside their correct folders. During the setup you will be given the choice to either update the attendance thresholds or leave them at their default values which are 75% for warning and 50% for failure. Simply type `yes` to enter your own values or `no` to keep the defaults. Before running the script ensure that all the required files which are "attendance_checker.py", "assets.csv", "config.json", "reports.log"" and "setup_project.sh" are all located in the same folder.

Once the setup is complete the script will verify whether `python3` is available on your machine and confirm that all files have been placed in their correct locations.
## Project structure it creates

attendance_tracker_{name}/
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
    └── reports.log

## How to trigger the archive (Ctrl+C)

If you hit `Ctrl+C` at any point while the script is running, it will not simply 
terminate. Instead it will intercept the signal, compress everything that has 
been created so far into a file called `attendance_tracker_{name}_archive.tar.gz` 
and then remove the incomplete folder so your workspace stays clean and nothing 
is left in a broken state.

## Video that explain it well


