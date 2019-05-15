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


Import-Module poshwsus
Connect-PSWSUSServer -WsusServer $WsusServer -Port 8530
#$firstDayMonth = Get-Date -Day 1 -Hour 0 -Minute 0 -Second 0
$list = Get-PSWSUSClientsInGroup -Name $TargetGroup| select -ExpandProperty fulldomainname

"{0},{1},{2},{3},{4}" -F "Computername","InstalledCount","InstalledPendingReboot","ApprovedNotInstalled","ApprovedDownloaded" |Add-Content -Path $CSVPath"\"$ReportName.csv
foreach ($i in $list) {

$clientperupdate=Get-PSWSUSUpdatePerClient -UpdateScope (New-PSWSUSUpdateScope -ApprovedStates Any) -ComputerName $I | Where-Object -Property Updateapprovalaction -Like install | Where -Property UpdateInstallationstate -NotLike "NotApplicable" -Debug | select computername, updatekb, updateinstallationstate,updateapprovalaction

$installedcount = $($clientperupdate | Where-Object {$_.UpdateInstallationState -like "Installed"} | select updateinstallationstate).count
$InstalledPendingRebootCount = $($clientperupdate | Where-Object {$_.UpdateInstallationState -like "InstalledPendingReboot"} | select updateinstallationstate).count
$NotInstalledCount = $($clientperupdate | Where-Object {$_.UpdateInstallationState -like "NotInstalled"} | select updateinstallationstate).count
$DownloadedCount = $($clientperupdate | Where-Object {$_.UpdateInstallationState -eq "Downloaded"} | select updateinstallationstate).count

#$installedcount
#$InstalledPendingRebootCount
#$NotInstalledCount
$firstDayMonth = Get-Date -Day 1 -Hour 0 -Minute 0 -Second 0
 "{0},{1},{2},{3},{4}" -F $i, $installedcount, $InstalledPendingRebootCount, $NotInstalledCount,$DownloadedCount |Add-Content -Path $CSVPath"\"$ReportName.csv


    }
}