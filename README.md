# SwitchBackupAutomation
This project focuses on how to automate the configuration backup of Dell switches.
There are four files in this repository :-
1. generatekey.ps1
2. keyfile.txt
3. switch_config_backup.ps1
4. switchip.txt

generatekey.ps1 has the command to get the switch credentials (password) and convert it into encrypted key and store it in a keyfile.txt for switch_config_backup.ps1 to fetch the password of the switch.

keyfile.txt is the output encrypted key of generatekey.ps1.

switch_config_backup.ps1 is the main powershell file which is automating the configuration backup of Dell switches. We can trigger a tas using Task scheduler to run this script everyday so that all the new changes, if done, to the switch will be saved to the local folder using tftp server.

switchip.txt mentions about the switch IPs which needs a configuration backup. Just add the IPs of the switch and the script is good to take the backup.


