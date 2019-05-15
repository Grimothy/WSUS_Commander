Function Generate-NeededTGUpdates
{
    Param (
    [Parameter(Mandatory=$true)]
    [string]$WsusServer,
    [Parameter(Mandatory=$true)]
    [string]$TargetGroup,
    [Parameter(Mandatory=$true)]
    [string]$CSVPath



)

   $date = Get-Date -Format MM-dd-yy
   $ReportName = "$TargetGroup-$date"
   #Import Modules
   Write-Host -ForegroundColor Cyan Importing modules
   Import-Module PoshWSUS

    #Creating Log Paths
    New-Item $CSVPath"\"$Reportname.csv -ItemType File -ErrorAction SilentlyContinue 



    #Connect to WSUS
    Write-Host -ForegroundColor Magenta Connecting to WSUS server $Wsusserver
    #Start-Sleep -Seconds 3 #
    Connect-PSWSUSServer -WsusServer $WsusServer -Port 8530
    Write-Host -ForegroundColor Green Connected to WSUS!!
    #Start-Sleep -Seconds 3

    #Get-PSWSUSClientsInGroup -Name $TargetGroup| Get-PSWSUSUpdatePerClient | where -Property UpdateInstallationState -Like NotInstalled | Select Computername,UpdateKB,UpdateTitle
    Get-PSWSUSClientsInGroup -Name $TargetGroup| Get-PSWSUSUpdatePerClient | where -Property UpdateInstallationState -Like NotInstalled | Select Computername,UpdateKB,UpdateTitle | Export-Csv $CSVPath"\"$Reportname.csv
    Get-PSWSUSClientsInGroup -Name $TargetGroup| Get-PSWSUSUpdatePerClient | where -Property UpdateInstallationState -Like NotInstalled | Select UpdateKB,UpdateTitle -Unique | Export-Csv $CSVPath"\"$Reportname-"NeededUpdates-RAW".csv -NoTypeInformation


    #scrub file
    Write-Host -ForegroundColor Yellow Scrubbing Report
    $scrub = Import-csv $CSVPath"\"$Reportname.csv
    $scrub | ForEach-Object {
    
        $_.UpdateTitle = $_.UpdateTitle -replace ',','-'
    }
    $scrub | Export-Csv $CSVPath"\"$Reportname.csv-temp -NoTypeInformation
    Remove-Item $CSVPath"\"$Reportname.csv -Force
    move $CSVPath"\"$Reportname.csv-temp $CSVPath"\"$Reportname"-Detailed".csv
    Start-Sleep 1
    Write-Host -ForegroundColor Yellow Removing Monthly Rollups
    Import-Csv -Path $CSVPath"\"$Reportname-"NeededUpdates-RAW".csv | where {$_.UpdateTitle -notlike "*Security Monthly Quality Rollup for Windows Server*"} | Export-Csv -Path $CSVPath"\"$Reportname-"NeededUpdates".csv -NoTypeInformation
    Remove-Item $CSVPath"\"$Reportname-"NeededUpdates-RAW".csv -Force
    Start-Sleep 1
    Write-Host -ForegroundColor Green Completed Reports are available at $CSVPath

}