<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    ApproveNeededUpdates
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ApproveNeededUpdatesForm        = New-Object system.Windows.Forms.Form
$ApproveNeededUpdatesForm.ClientSize  = '548,493'
$ApproveNeededUpdatesForm.text   = "Approve Needed Updates"
$ApproveNeededUpdatesForm.TopMost  = $false

$WSUSServerLabel                 = New-Object system.Windows.Forms.Label
$WSUSServerLabel.text            = "Wsus Server"
$WSUSServerLabel.AutoSize        = $true
$WSUSServerLabel.width           = 25
$WSUSServerLabel.height          = 10
$WSUSServerLabel.location        = New-Object System.Drawing.Point(214,36)
$WSUSServerLabel.Font            = 'Microsoft Sans Serif,12'

$WSUSServerTextBox               = New-Object system.Windows.Forms.TextBox
$WSUSServerTextBox.multiline     = $false
$WSUSServerTextBox.width         = 395
$WSUSServerTextBox.height        = 20
$WSUSServerTextBox.location      = New-Object System.Drawing.Point(68,67)
$WSUSServerTextBox.Font          = 'Microsoft Sans Serif,10'

$UpdateListLabel                 = New-Object system.Windows.Forms.Label
$UpdateListLabel.text            = "Update Approval List"
$UpdateListLabel.AutoSize        = $true
$UpdateListLabel.width           = 25
$UpdateListLabel.height          = 10
$UpdateListLabel.location        = New-Object System.Drawing.Point(206,182)
$UpdateListLabel.Font            = 'Microsoft Sans Serif,10'

$BrowseforApprovalListButton     = New-Object system.Windows.Forms.Button
$BrowseforApprovalListButton.BackColor  = "#f8e71c"
$BrowseforApprovalListButton.text  = "Browse for approval list"
$BrowseforApprovalListButton.width  = 163
$BrowseforApprovalListButton.height  = 30
$BrowseforApprovalListButton.location  = New-Object System.Drawing.Point(193,214)
$BrowseforApprovalListButton.Font  = 'Microsoft Sans Serif,10'


$ApprovalOptionsGroupbox         = New-Object system.Windows.Forms.Groupbox
$ApprovalOptionsGroupbox.height  = 97
$ApprovalOptionsGroupbox.width   = 517
$ApprovalOptionsGroupbox.text    = "Approval Options"
$ApprovalOptionsGroupbox.location  = New-Object System.Drawing.Point(8,285)

$TargetGroupLabel                = New-Object system.Windows.Forms.Label
$TargetGroupLabel.text           = "Target Group"
$TargetGroupLabel.AutoSize       = $true
$TargetGroupLabel.width          = 25
$TargetGroupLabel.height         = 10
$TargetGroupLabel.location       = New-Object System.Drawing.Point(224,116)
$TargetGroupLabel.Font           = 'Microsoft Sans Serif,11'

$TargetGroupComboBox             = New-Object system.Windows.Forms.ComboBox
$TargetGroupComboBox.text        = "Please select a target group"
$TargetGroupComboBox.width       = 398
$TargetGroupComboBox.height      = 20
$TargetGroupComboBox.location    = New-Object System.Drawing.Point(63,140)
$TargetGroupComboBox.Font        = 'Microsoft Sans Serif,10'

$ApprovalListTextBox            = New-Object system.Windows.Forms.TextBox
$ApprovalListTextBox.multiline  = $false
$ApprovalListTextBox.width      = 454
$ApprovalListTextBox.height     = 20
$ApprovalListTextBox.enabled    = $true
$ApprovalListTextBox.location   = New-Object System.Drawing.Point(51,256)
$ApprovalListTextBox.Font       = 'Microsoft Sans Serif,10'

$AboutButton                     = New-Object system.Windows.Forms.Button
$AboutButton.BackColor           = "#b8e986"
$AboutButton.text                = "About"
$AboutButton.width               = 60
$AboutButton.height              = 30
$AboutButton.location            = New-Object System.Drawing.Point(239,455)
$AboutButton.Font                = 'Microsoft Sans Serif,10'
$AboutButton.add_click({
    <# 
    .NAME
    AboutApproveNeededUpdatesForm
    #>

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $AboutApproveNeededUpdatesForm   = New-Object system.Windows.Forms.Form
    $AboutApproveNeededUpdatesForm.ClientSize  = '507,191'
    $AboutApproveNeededUpdatesForm.text  = "About Approve needed Updates"
    $AboutApproveNeededUpdatesForm.TopMost  = $false
    
    $InfromationLabel1               = New-Object system.Windows.Forms.Label
    $InfromationLabel1.text          = "This program is used to approve previously generated needed updates"
    $InfromationLabel1.AutoSize      = $true
    $InfromationLabel1.width         = 25
    $InfromationLabel1.height        = 10
    $InfromationLabel1.location      = New-Object System.Drawing.Point(47,23)
    $InfromationLabel1.Font          = 'Microsoft Sans Serif,10'

    $InfromationLabel2               = New-Object system.Windows.Forms.Label
    $InfromationLabel2.text          = "If you have not done so, please run the Generate Needed Updates function"
    $InfromationLabel2.AutoSize      = $true
    $InfromationLabel2.width         = 25
    $InfromationLabel2.height        = 10
    $InfromationLabel2.location      = New-Object System.Drawing.Point(36,52)
    $InfromationLabel2.Font          = 'Microsoft Sans Serif,10'

    $createdLabel                    = New-Object system.Windows.Forms.Label
    $createdLabel.text               = "Arraya 2019"
    $createdLabel.AutoSize           = $true
    $createdLabel.width              = 25
    $createdLabel.height             = 10
    $createdLabel.location           = New-Object System.Drawing.Point(144,164)
    $createdLabel.Font               = 'Microsoft Sans Serif,10'

    $AboutApproveNeededUpdatesForm.controls.AddRange(@($InfromationLabel1,$InfromationLabel2,$createdLabel))

    #Write your logic code here

    [void]$AboutApproveNeededUpdatesForm.ShowDialog()

    })

$WithDeadlineButton              = New-Object system.Windows.Forms.Button
$WithDeadlineButton.BackColor    = "#f5a623"
$WithDeadlineButton.text         = "Approve with deadline"
$WithDeadlineButton.width        = 162
$WithDeadlineButton.height       = 45
$WithDeadlineButton.location     = New-Object System.Drawing.Point(27,36)
$WithDeadlineButton.Font         = 'Microsoft Sans Serif,10'
$WithDeadlineButton.add_click({

    Add-Type -AssemblyName System.Windows.Forms
    # Main Form
    $mainForm = New-Object System.Windows.Forms.Form
    $font = New-Object System.Drawing.Font(“Consolas”, 13)
    $mainForm.Text = ”Set Deadline”
    $mainForm.Font = $font
    $mainForm.ForeColor = “Black”
    $mainForm.BackColor = “#ECEAEA"
    $mainForm.Width = 600
    $mainForm.Height = 200


    # TimePicker Label
    $DeadlineDatePickerLabel = New-Object System.Windows.Forms.Label
    $DeadlineDatePickerLabel.Text = “ Deadline Date”
    $DeadlineDatePickerLabel.Location = “10, 45”
    $DeadlineDatePickerLabel.Height = 22
    $DeadlineDatePickerLabel.Width = 200
    $mainForm.Controls.Add($DeadlineDatePickerLabel)

    # TimePicker
    $DeadlineTimePickerLabel = New-Object System.Windows.Forms.DateTimePicker
    $DeadlineTimePickerLabel.Location = “220, 42”
    $DeadlineTimePickerLabel.Width = “210”
    $DeadlineTimePickerLabel.Format = [windows.forms.datetimepickerFormat]::custom
    $DeadlineTimePickerLabel.CustomFormat = “MM/dd/yyy_HH:mm:ss”
    $DeadlineTimePickerLabel.ShowUpDown = $TRUE
    $mainForm.Controls.Add($DeadlineTimePickerLabel)

    # OD Button
    $OkApproveDeadlineButton = New-Object System.Windows.Forms.Button
    $OkApproveDeadlineButton.Location = “15, 130”
    $OkApproveDeadlineButton.ForeColor = “Black”
    $OkApproveDeadlineButton.BackColor = "#f5a623"
    $OkApproveDeadlineButton.Text = “Approve”
    $OkApproveDeadlineButton.Width =  "110"
    $OkApproveDeadlineButton.add_Click({$mainForm.close()})
    $mainForm.Controls.Add($OkApproveDeadlineButton)
    [void] $mainForm.ShowDialog()
        #Deadline Convert Sting to time
        
        $pass1 = $DeadlineTimePickerLabel.Text -replace ':',''
        $pass2 = $pass1 -replace '/','' 
        $deadlinedate = ([datetime]::ParseExact($pass2,"MMddyyyy_HHmmss", [System.Globalization.CultureInfo]::CurrentCulture))
        #Approval Function
        $list = Import-Csv $ApprovalListTextBox.text | select -ExpandProperty updateKB -Unique
        #Approve with Deadline
        write-host -ForegroundColor Yellow Approving $list.Count Updates with an Installation Deadline of $DeadlineTimePickerLabel.Value
        
        #write values for status box
        $scount = $list.count
        $StatusTextBox.Text = "Approving $scount Updates with an Installation Deadline of $deadlinedate"
        $stargetgroup = $TargetGroupComboBox.Text
        Start-Sleep -Seconds 2
        foreach ($i in $list){
        Get-PSWSUSUpdate -Update "kb$i" | Approve-PSWSUSUpdate -Action Install -Group $(Get-PSWSUSGroup | where -Property Name -EQ $TargetGroupComboBox.text) -Deadline $DeadlineDate -Verbose
        $StatusTextBox.Text =  "Approving Windows kb$i on $stargetgroup"
        
        }
        Start-Sleep -Seconds 5
        $StatusTextBox.Text = "Approvals completed. See Powershell window for more details"
    })
$WithoutDeadlineButton1          = New-Object system.Windows.Forms.Button
$WithoutDeadlineButton1.BackColor  = "#50e3c2"
$WithoutDeadlineButton1.text     = "Approve Without deadline"
$WithoutDeadlineButton1.width    = 175
$WithoutDeadlineButton1.height   = 47
$WithoutDeadlineButton1.location  = New-Object System.Drawing.Point(323,34)
$WithoutDeadlineButton1.Font     = 'Microsoft Sans Serif,10'
$WithoutDeadlineButton1.add_click({
    
        $list = Import-Csv $ApprovalListTextBox.text | select -ExpandProperty updateKB -Unique
        #Approve with Deadline
        write-host -ForegroundColor Yellow Approving $list.Count
        
        #write values for status box
        $scount = $list.count
        $StatusTextBox.Text = "Approving $scount Updates without a deadline"
        $stargetgroup = $TargetGroupComboBox.Text
        Start-Sleep -Seconds 2
        foreach ($i in $list){
        Get-PSWSUSUpdate -Update "kb$i" | Approve-PSWSUSUpdate -Action Install -Group $(Get-PSWSUSGroup | where -Property Name -EQ $TargetGroupComboBox.text) -Verbose
        $StatusTextBox.Text =  "Approving Windows kb$i on $stargetgroup without a deadline"
        
        }
        Start-Sleep -Seconds 5
        $StatusTextBox.Text = "Approvals completed. See Powershell window for more details"
})

$StatusTextBox                   = New-Object system.Windows.Forms.TextBox
$StatusTextBox.multiline         = $false
$StatusTextBox.BackColor         = "#6AC83F"
$StatusTextBox.width             = 504
$StatusTextBox.height            = 20
$StatusTextBox.location          = New-Object System.Drawing.Point(17,423)
$StatusTextBox.Font              = 'Microsoft Sans Serif,10'

$ApproveNeededUpdatesForm.controls.AddRange(@($WSUSServerLabel,$WSUSServerTextBox,$UpdateListLabel,$BrowseforApprovalListButton,$ApprovalOptionsGroupbox,$TargetGroupLabel,$TargetGroupComboBox,$ApprovalListTextBox,$AboutButton,$StatusTextBox))
$ApprovalOptionsGroupbox.controls.AddRange(@($WithDeadlineButton,$WithoutDeadlineButton1))




#Write your logic code here
#General Form Information
Write-Host -ForegroundColor Blue -BackgroundColor Gray "Please keep this Windows Running to the side. A form window should be populated in the background."

#Import Modules

Write-Host -ForegroundColor Cyan Importing modules
Import-Module PoshWSUS
if ($(Get-Module).Name -like "*PoshWSUS*") {$StatusTextBox.Text = "Posh Loaded" }
#Fill in WSUS Server information
$WSUSServerTextBox.Text = ($(Get-Content Env:\COMPUTERNAME))

#Connect to WSUS Server
Connect-PSWSUSServer -WsusServer $WSUSServerTextBox.Text -Port 8530

#Generate WSUS Group List
$TGList = Get-PSWSUSGroup | sort name

#Add to Combo Box Drop Down
Foreach ($G in $TGList) {$TargetGroupComboBox.Items.Add($G.Name) | Out-Null}

#Button function for report save location

$BrowseforApprovalListButton.add_click({Get-ApprovalList})

function Get-ApprovalList
{
     $ApprovalListTextBox.Text = Get-FileName -initialDirectory $ApprovalListTextBox.Text
}

Function Get-FileName($initialDirectory)
{   
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "CSV (*.CSV)| *.CSV"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} 


[void]$ApproveNeededUpdatesForm.ShowDialog()

