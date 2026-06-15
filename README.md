
 How to Run the Script

1. Clone the repository:
git clone https://github.com/Umwarichrista1/deploy_agent_Umwarichrista1.git

2. Enter the directory:
cd deploy_agent_Umwarichrista1

3. Make the script executable:
chmod +x setup_project.sh

4. Run the script:
./setup_project.sh

5. Follow the prompts:
- Type in a project title
- Make the decision to update thresholds
The structure of the project will be created automatically by Script.

 How to Use the Archive Feature

During the operation of the script, press Ctrl+C to stop it.
The script will automatically:
- Zip the directory which contains only the incomplete one into a .tar.gz file
Remove unwanted directories (such as unfinished directories).
- Exit cleanly

 Project Structure Created

attendance_tracker_{input}/
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
    └── reports.log

 Author
Christa Umwari
GitHub: Umwarichrista1
