#Pulls a list of updates that have been approved via CCR

#Deadline is optional but must be enter as 24 hour time  MMddyyy_HHmm
    # example: 05172018_2205



Function Approve-NeededTGUpdates

{
  
    
    Param (
    [Parameter(Mandatory=$true)]
    [string]$WsusServer,
    [Parameter(Mandatory=$true)]
    [string]$TargetGroup,
    [Parameter(Mandatory=$true)]
    [string]$CCRListFilePath,
    #[Parameter(Mandatory=$true)]
    [string]$Deadline

)
 
   #Import Modules
   Write-Host -ForegroundColor Cyan Importing modules
   Import-Module PoshWSUS
   
    #Global Vars
    #$deadlinedate = ([datetime]::ParseExact($date,"MMddyyyy_HHmm", [System.Globalization.CultureInfo]::CurrentCulture))
    
    #Creating Log Paths

    #Connect to WSUS
    Write-Host -ForegroundColor Magenta Connecting to WSUS server $Wsusserver
    #Start-Sleep -Seconds 3 #
    Connect-PSWSUSServer -WsusServer $WsusServer -Port 8530
    Write-Host -ForegroundColor Green Connected to WSUS!!
    #Start-Sleep -Seconds 3
   
   #Script Blocks

   #Get content from CCR approved Updates from Vertex

  
   #$list = Import-Csv -path "$CCRListFilePath"
   #$list = $list | select UpdateKB

   if ($Deadline -ine '' ){
        
        Write-Host $Deadline
        $list = Import-Csv "$CCRListFilePath" | select -ExpandProperty updateKB -Unique
        #Convert string to time 
        $deadlinedate = ([datetime]::ParseExact($Deadline,"MMddyyyy_HHmm", [System.Globalization.CultureInfo]::CurrentCulture))
        write-host -ForegroundColor Yellow Approving $list.Count Updates with an Installation Deadline of $deadlinedate
        foreach ($i in $list){
        Get-PSWSUSUpdate -Update "kb$i" | Approve-PSWSUSUpdate -Action Install -Group $(Get-PSWSUSGroup | where -Property Name -EQ $TargetGroup) -Deadline $deadlinedate.AddHours(4) -Verbose
        }
  
   
    }else{
    
        #$deadlinedate = ([datetime]::ParseExact($date,"MMddyyyy_HHmm", [System.Globalization.CultureInfo]::CurrentCulture))
        $list = Import-Csv "$CCRListFilePath" | select -ExpandProperty updateKB -Unique
        write-host -ForegroundColor Yellow Approving $list.Count Updates without a deadline
        foreach ($i in $list){
            Get-PSWSUSUpdate -Update "kb$i" | Approve-PSWSUSUpdate -Action Install -Group $(Get-PSWSUSGroup | where -Property Name -EQ $TargetGroup) -Verbose
        }

    }
}