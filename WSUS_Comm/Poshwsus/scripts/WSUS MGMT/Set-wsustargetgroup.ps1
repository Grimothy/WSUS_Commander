
Function Set-WSUSTargetGroup
{
    Param (
    [Parameter(Mandatory=$true)]
    [string]$WsusServer,
    [Parameter(Mandatory=$true)]
    [string]$TargetGroup,
    [string]$ListPath,
    [Parameter(Mandatory=$true)]
    [string]$LogPath


)
    #Global Vars
    $date = (Get-Date -Format MM-dd-yyyy)
    
    #Creating Log Paths
    New-Item -ItemType Directory -Path $LogPath\$date"_Log" -ErrorAction SilentlyContinue
    New-Item -ItemType File -Path $LogPath\$date"_Log\ComputersNoWSUS.log"

    
    #Connect to WSUS
    Write-Host -ForegroundColor Magenta Connecting to WSUS server $Wsusserver
    Start-Sleep -Seconds 3 #
   Connect-PSWSUSServer -WsusServer $WsusServer -Port 8530
    Write-Host -ForegroundColor Green Connected to WSUS!!
    Start-Sleep -Seconds 3
   
   #Script Blocks

    $Machine = Get-Content -Path $ListPath
    Foreach ($i in $Machine) {
        
        if ($(Get-PSWSUSClient | Where {$_.FullDomainName -like "$i"} -EQ $null )){
            Write-Host -ForegroundColor Red not in wsus
            $i |Add-Content $LogPath\$date"_Log\ComputersNoWSUS.log"
            Write-Host -ForegroundColor Yellow Added to Log for review


        }else{
            
            Get-WsusComputer -NameIncludes $i | Add-WsusComputer -TargetGroupName "$TargetGroup"
            Write-Host -ForegroundColor Green Added to Target Group


        }
        
    }

   

}
