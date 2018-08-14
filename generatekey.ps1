$credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Out-File "C:\Users\Administrator\Documents\PowershellScripts\switchautomationbackup\keyfile.txt"