Function Generate-ServersComplianceReportGroup
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



    #Import Modules
    Write-Host -ForegroundColor Cyan Importing modules
    Import-Module PoshWSUS

    #Creating Log Paths
    New-Item $CSVPath"\"$Reportname.csv -ItemType File -ErrorAction SilentlyContinue 
    
    #Format Headers
    "{0},{1},{2},{3},{4},{5}" -F "ComputerName","TargetGroup","Installed","Needed","Failed","PendingReboot" | Add-Content $CSVPath"\"$Reportname.csv



    #Connect to WSUS
    Write-Host -ForegroundColor Magenta Connecting to WSUS server $Wsusserver
    Start-Sleep -Seconds 1 #
    Connect-PSWSUSServer -WsusServer $WsusServer -Port 8530
    Write-Host -ForegroundColor Green Connected to WSUS!!
    Start-Sleep -Seconds 1

    Write-Host -ForegroundColor Cyan Building Compliance report for group $TargetGroup
   
    $list = Get-PSWSUSClientsInGroup -Name $targetgroup| select -ExpandProperty fulldomainname

        foreach ($i in $list){
            $clientsummary = Get-PSWSUSUpdateSummaryPerClient -UpdateScope (New-PSWSUSUpdateScope -ExcludedInstallationStates NotApplicable -UpdateApprovalActions Install) -ComputerScope (New-PSWSUSComputerScope -NameIncludes "$i") | select Computer, Installed, Needed, Failed, PendingReboot 
            "{0},{1},{2},{3},{4},{5}" -F $($clientsummary | select -ExpandProperty computer),$targetgroup,$($clientsummary | select -ExpandProperty installed),$($clientsummary | select -ExpandProperty Needed),$($clientsummary | select -ExpandProperty Failed), $($clientsummary | select -ExpandProperty PendingReboot)|Add-Content -Path $CSVPath"\"$Reportname.csv

        }
   


    #Generating Detailed List
    
    Write-Host -ForegroundColor Cyan Generating a Detailed report of updates required on non-compliant machines.
    Write-Host -ForegroundColor Cyan This may take some time...
    Get-PSWSUSClientsInGroup -Name $TargetGroup| Get-PSWSUSUpdatePerClient | where -Property UpdateInstallationState -NotLike "NotApplicable"| Where-Object {$_.UpdateApprovalAction -like "Install"} | Select Computername,UpdateKB,UpdateTitle | Where-Object -Property Updateapprovalaction -Like install | Where -Property UpdateInstallationstate -NotLike "NotApplicable" Export-Csv $CSVPath"\"$Reportname-Detailed.csv

    
    #scrub file
    Write-Host -ForegroundColor Yellow Scrubbing File Pass 1
    $scrub = Import-csv $CSVPath"\"$Reportname-Detailed.csv
    $scrub | ForEach-Object {
    
        $_.UpdateTitle = $_.UpdateTitle -replace ',','-'
    }
    $scrub | Export-Csv $CSVPath"\"$Reportname-Detailed-Temp.csv
    Remove-Item $CSVPath"\"$Reportname-Detailed.csv -Force
    move $CSVPath"\"$Reportname-Detailed-Temp.csv $CSVPath"\"$Reportname-Detailed.csv


    Write-Host -ForegroundColor Yellow Scrubbing File Pass 2
    get-content $CSVPath"\"$Reportname-Detailed.csv | select -Skip 1 | set-content $CSVPath"\"$Reportname-Detailed-Temp.csv
    Remove-Item $CSVPath"\"$Reportname-Detailed.csv -Force
    Move-Item $CSVPath"\"$Reportname-Detailed-Temp.csv $CSVPath"\"$Reportname-Detailed.csv -Force


 }