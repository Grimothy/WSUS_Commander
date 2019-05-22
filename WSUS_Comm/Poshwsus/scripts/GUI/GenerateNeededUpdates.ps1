<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    neededupdates
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$NeededUpdatesForm               = New-Object system.Windows.Forms.Form
$NeededUpdatesForm.ClientSize    = '400,400'
$NeededUpdatesForm.text          = "Generate Needed Updates"
$NeededUpdatesForm.TopMost       = $false

$WSUSServerLabel                 = New-Object system.Windows.Forms.Label
$WSUSServerLabel.text            = "Wsus Server"
$WSUSServerLabel.AutoSize        = $true
$WSUSServerLabel.width           = 25
$WSUSServerLabel.height          = 10
$WSUSServerLabel.location        = New-Object System.Drawing.Point(160,10)
$WSUSServerLabel.Font            = 'Microsoft Sans Serif,10'

$WSUSServerTextBox               = New-Object system.Windows.Forms.TextBox
$WSUSServerTextBox.multiline     = $false
$WSUSServerTextBox.width         = 321
$WSUSServerTextBox.height        = 20
$WSUSServerTextBox.location      = New-Object System.Drawing.Point(42,40)
$WSUSServerTextBox.Font          = 'Microsoft Sans Serif,10'

$TargetGroupLabel                = New-Object system.Windows.Forms.Label
$TargetGroupLabel.text           = "Target Group"
$TargetGroupLabel.AutoSize       = $true
$TargetGroupLabel.width          = 25
$TargetGroupLabel.height         = 10
$TargetGroupLabel.location       = New-Object System.Drawing.Point(155,80)
$TargetGroupLabel.Font           = 'Microsoft Sans Serif,10'

$TargetGroupComboBox             = New-Object system.Windows.Forms.ComboBox
$TargetGroupComboBox.text        = "Please enter TargetGroup"
$TargetGroupComboBox.width       = 321
$TargetGroupComboBox.height      = 20
$TargetGroupComboBox.location    = New-Object System.Drawing.Point(41,106)
$TargetGroupComboBox.Font        = 'Microsoft Sans Serif,10'

$ReportPathLabel                 = New-Object system.Windows.Forms.Label
$ReportPathLabel.text            = "Report Path"
$ReportPathLabel.AutoSize        = $true
$ReportPathLabel.width           = 25
$ReportPathLabel.height          = 10
$ReportPathLabel.location        = New-Object System.Drawing.Point(155,147)
$ReportPathLabel.Font            = 'Microsoft Sans Serif,10'

$ReportPathTextBox               = New-Object system.Windows.Forms.TextBox
$ReportPathTextBox.multiline     = $false
$ReportPathTextBox.width         = 333
$ReportPathTextBox.height        = 20
$ReportPathTextBox.location      = New-Object System.Drawing.Point(35,215)
$ReportPathTextBox.Font          = 'Microsoft Sans Serif,10'

$GenerateButton                  = New-Object system.Windows.Forms.Button
$GenerateButton.BackColor        = "#7ed321"
$GenerateButton.text             = "Get Needed Updates"
$GenerateButton.width            = 267
$GenerateButton.height           = 30
$GenerateButton.location         = New-Object System.Drawing.Point(52,249)
$GenerateButton.Font             = 'Microsoft Sans Serif,10'
$GenerateButton.ForeColor        = "#ffffff"

$BrowseReportPathButton          = New-Object system.Windows.Forms.Button
$BrowseReportPathButton.BackColor  = "#f8e71c"
$BrowseReportPathButton.text     = "Browse for Path"
$BrowseReportPathButton.width    = 170
$BrowseReportPathButton.height   = 30
$BrowseReportPathButton.location  = New-Object System.Drawing.Point(103,171)
$BrowseReportPathButton.Font     = 'Microsoft Sans Serif,10'

$StatusLabel                     = New-Object system.Windows.Forms.Label
$StatusLabel.text                = "Status"
$StatusLabel.AutoSize            = $true
$StatusLabel.width               = 25
$StatusLabel.height              = 10
$StatusLabel.location            = New-Object System.Drawing.Point(160,296)
$StatusLabel.Font                = 'Microsoft Sans Serif,11'

$ResultsLabel                    = New-Object system.Windows.Forms.Label
$ResultsLabel.BackColor          = "#4a90e2"
$ResultsLabel.AutoSize           = $true
$ResultsLabel.width              = 25
$ResultsLabel.height             = 10
$ResultsLabel.location           = New-Object System.Drawing.Point(125,350)
$ResultsLabel.Font               = 'Microsoft Sans Serif,10'

$NeededUpdatesForm.controls.AddRange(@($WSUSServerLabel,$WSUSServerTextBox,$TargetGroupLabel,$TargetGroupComboBox,$ReportPathLabel,$ReportPathTextBox,$GenerateButton,$BrowseReportPathButton,$StatusLabel,$ResultsLabel))



$BrowseReportPathButton.Add_Click({Get-ReportFolder})
$GenerateButton.Add_Click({Generate-NeededTGUpdates -WsusServer $WSUSServerTextBox.Text -TargetGroup $TargetGroupComboBox.Text -CSVPath $ReportPathTextBox.Text})

#Write your logic code here

#Import Modules
Write-Host -ForegroundColor Cyan Importing modules
Import-Module PoshWSUS
if ($(Get-Module).Name -like "*PoshWSUS*") {$ResultsLabel.Text = "Posh Model Loaded" }
#Fill in WSUS Server information
$WSUSServerTextBox.Text = ($(Get-Content Env:\COMPUTERNAME))

#Connect to WSUS Server
Connect-PSWSUSServer -WsusServer $WSUSServerTextBox.Text -Port 8530

#Generate WSUS Group List
$TGList = Get-PSWSUSGroup | sort name

#Add to Combo Box Drop Down
Foreach ($G in $TGList) {$TargetGroupComboBox.Items.Add($G.Name) | Out-Null}

#Button function for report save location

function Get-ReportFolder
{
     $ReportPathTextbox.Text = Get-Folder
}

Function Get-Folder
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null
    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder"
    $foldername.rootfolder = "MyComputer"
    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}




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
    $ResultsLabel.Text  = "Generating Reports for the Select Target Group, Please wait"
    $date = Get-Date -Format MM-dd-yy
    $ReportName = $TargetGroupComboBox.Text
    
    
    #Get-PSWSUSClientsInGroup -Name $TargetGroup| Get-PSWSUSUpdatePerClient | where -Property UpdateInstallationState -Like NotInstalled | Select Computername,UpdateKB,UpdateTitle
    Get-PSWSUSClientsInGroup -Name $TargetGroup| Get-PSWSUSUpdatePerClient -UpdateScope (New-PSWSUSUpdateScope -ApprovedStates Any -IncludedInstallationStates NotInstalled,Downloaded)| Select Computername,UpdateKB,UpdateTitle |Export-Csv $CSVPath"\"$Reportname-$date.csv
    Get-PSWSUSClientsInGroup -Name $TargetGroup| Get-PSWSUSUpdatePerClient -UpdateScope (New-PSWSUSUpdateScope -ApprovedStates Any -IncludedInstallationStates NotInstalled,Downloaded) | Select UpdateKB,UpdateTitle -Unique | Export-Csv $CSVPath"\"$Reportname-$date-"NeededUpdates-RAW".csv -NoTypeInformation


    #scrub file
    Write-Host -ForegroundColor Yellow Scrubbing Report
    $scrub = Import-csv $CSVPath"\"$Reportname-$date.csv
    $scrub | ForEach-Object {
    
        $_.UpdateTitle = $_.UpdateTitle -replace ',','-'
    }
    $scrub | Export-Csv $CSVPath"\"$Reportname.csv-temp -NoTypeInformation
    Remove-Item $CSVPath"\"$Reportname-$date.csv -Force
    move $CSVPath"\"$Reportname.csv-temp $CSVPath"\"$Reportname-$date"-Detailed".csv
    Start-Sleep 1
    Write-Host -ForegroundColor Yellow Removing Security Monthly Quality Rollup for Windows Server
    Import-Csv -Path $CSVPath"\"$Reportname-$date-"NeededUpdates-RAW".csv | where {$_.UpdateTitle -notlike "*Security Monthly Quality Rollup for Windows Server*"} | Export-Csv -Path $CSVPath"\"$Reportname-$date-"NeededUpdatesP1".csv -NoTypeInformation
    Remove-Item $CSVPath"\"$Reportname-$date-"NeededUpdates-RAW".csv -Force
    Start-Sleep 1
    Write-Host -ForegroundColor Yellow Removing Security Monthly Quality Rollup for .Net Framework
    Write-Host -ForegroundColor Green Completed Reports are available at $CSVPath
    Import-Csv -Path $CSVPath"\"$Reportname-$date-"NeededUpdatesP1".csv | where {$_.UpdateTitle -notlike "*Security and Quality Rollup for .Net*"} | Export-Csv -Path $CSVPath"\"$Reportname-$date-"NeededUpdates".csv -NoTypeInformation
    Remove-Item -Path $CSVPath"\"$Reportname-$date-"NeededUpdatesP1".csv
    $ResultsLabel.Text = "Completed Reports"

    }

[void]$NeededUpdatesForm.ShowDialog()