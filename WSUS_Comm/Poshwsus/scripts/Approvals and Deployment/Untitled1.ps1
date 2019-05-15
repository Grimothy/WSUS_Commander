Function Generate-AllGroupCompliance
{
    Param (
    [Parameter(Mandatory=$true)]
    [string]$WsusServer,
    [Parameter(Mandatory=$true)]
    [string]$CSVPath



)

Import-Module poshwsus
Connect-PSWSUSServer -WsusServer $WsusServer -Port 8530
#Target groups - will need to modify if adding additional groups
$TargetGroups = "Dev Wave","Wave 1 A Domain Controllers_Staggered","Wave 2 A_7PM-10PM","Wave 2 B_930PM-11PM","Wave 2 C_11PM-5AM","Wave 3 A_10PM-6AM","Wave 3 B_12AM-3AM","Wave 4 A_10PM-11PM","Wave 4 B_TruMark Manual Reboot","WSUS"

Foreach ($i in $TargetGroups) { 
    #Create Folder paths
    New-Item -ItemType Directory -Path $CSVPath\$i -ErrorAction SilentlyContinue -Verbose
    
    #Generate Compliance
    Write-Host -ForegroundColor Cyan "Running Compliance check on $i"
    Import-Module Generate-ServersComplianceReportGroupv2
    .\Generate-ServersComplianceReportGroupv2 -WsusServer $WsusServer -TargetGroup $i -CSVPath $CSVPath\$i -ReportName $i"-$(Get-Date -Format MMddyyy)"
    }



    Function Generate-ServersComplianceReportGroupv2
        { 
        Param (
        [Parameter(Mandatory=$true)]
        [string]$WsusServer,
        [Parameter(Mandatory=$true)]
        [string]$TargetGroup,
        [Parameter(Mandatory=$true)]
        [string]$CSVPath,
        [Parameter(Mandatory=$true)]
        [string]$ReportName
        )


    #Import-Module poshwsus
    #Connect-PSWSUSServer -WsusServer $WsusServer -Port 8530
    #$firstDayMonth = Get-Date -Day 1 -Hour 0 -Minute 0 -Second 0
    
    $list = Get-PSWSUSClientsInGroup -Name $TargetGroup| select -ExpandProperty fulldomainname

    "{0},{1},{2},{3},{4}" -F "Computername","InstalledCount","InstalledPendingReboot","ApprovedNotInstalled","ApprovedDownloaded" |Add-Content -Path $CSVPath"\"$ReportName.csv
    foreach ($i in $list) {

    $clientperupdate=Get-PSWSUSUpdatePerClient -UpdateScope (New-PSWSUSUpdateScope -ApprovedStates Any) -ComputerName $I | Where-Object -Property Updateapprovalaction -Like install | Where -Property UpdateInstallationstate -NotLike "NotApplicable" -Debug | select computername, updatekb, updateinstallationstate,updateapprovalaction

    $installedcount = $($clientperupdate | Where-Object {$_.UpdateInstallationState -like "Installed"} | select updateinstallationstate).count
    $InstalledPendingRebootCount = $($clientperupdate | Where-Object {$_.UpdateInstallationState -like "InstalledPendingReboot"} | select updateinstallationstate).count
    $NotInstalledCount = $($clientperupdate | Where-Object {$_.UpdateInstallationState -like "NotInstalled"} | select updateinstallationstate).count
    $DownloadedCount = $($clientperupdate | Where-Object {$_.UpdateInstallationState -eq "Downloaded"} | select updateinstallationstate).count


    $firstDayMonth = Get-Date -Day 1 -Hour 0 -Minute 0 -Second 0
    "{0},{1},{2},{3},{4}" -F $i, $installedcount, $InstalledPendingRebootCount, $NotInstalledCount,$DownloadedCount |Add-Content -Path $CSVPath"\"$ReportName.csv

        }

Disconnect-PSWSUSServer
    }


Foreach ($i in $TargetGroups) { 
    #Create Folder paths
    New-Item -ItemType Directory -Path $CSVPath\$i -ErrorAction SilentlyContinue -Verbose
    
    #Generate Compliance
    Write-Host -ForegroundColor Cyan "Running Compliance check on $i"
    #Import-Module Generate-ServersComplianceReportGroupv2
    Generate-ServersComplianceReportGroupv2 -WsusServer $WsusServer -TargetGroup $i -CSVPath $CSVPath\$i -ReportName $i"-$(Get-Date -Format MMddyyy)"
    }

}