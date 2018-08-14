###########################################################################
# Module Name  : Dell_Switch_Configuration_Backup
# Script Name  : switch_config_backup.ps1
# Author       : Abhishek Agarwal
# Version      : 0.1
# Last Modified: 14/08/2018 (ddMMyyyy)
###########################################################################
<#
.SYNOPSIS
This script invokes Dell switch configuration using SSH
.EXAMPLE
PS>.\switch_config_backup.ps1
#>

$user = "admin"

try {   
    Write-Output "Collecting secure password"
    $secureStringPwd = Get-Content C:\Users\Administrator\Documents\PowershellScripts\switchautomationbackup\keyfile.txt | ConvertTo-SecureString 
}
catch{
    Write-Output "Failed to collect encrypted password."
}
    
$creds = New-Object System.Management.Automation.PSCredential ($user, $secureStringPwd)

try{
    Write-Output "Collecting IPs of switches"
    $list = Get-Content -Path C:\Users\Administrator\Documents\PowershellScripts\switchautomationbackup\switchip.txt
}

catch{
    $ErrorMessage = $_.Exception.Messagee
    Write-Output "Failed to collect IPs of switches"
    $ErrorMessage
}
    
foreach($ip in $list)
{
    if($ip)
    {
        try{
            Write-Output "Successfully received the IP $ip"
            $ssh = New-SshSession -ComputerName $ip -Credential $creds
        }
        catch{
            $ErrorMessage = $_.Exception.Message
            Write-Output "Not able to connect to IP $ip"
            $ErrorMessage
        }

    }
    
    try{
        $filename = (Get-Date).tostring("dd-MM-yyyy-hh-mm-ss")
        $command = "copy running-config tftp://xx.xx.xx.xx/$filename-$ip.txt"
        Write-Output "Connecting to switch $ip"
        Invoke-SSHCommand -SSHSession $ssh -EnsureConnection -Command $command
    }
    catch{
        $ErrorMessage = $_.Exception.Message
        Write-Output "Failed to execute the command to switch $ip"
        $ErrorMessage
    }
}
