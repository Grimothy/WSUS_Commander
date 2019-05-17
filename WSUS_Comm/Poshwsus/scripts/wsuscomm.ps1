<# 
.NAME
    WSUSCOM
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
Get-Location
$WSUCommanderForm                = New-Object system.Windows.Forms.Form
$WSUCommanderForm.ClientSize     = '500,500'
$WSUCommanderForm.text           = "WSUS Commander"
$WSUCommanderForm.TopMost        = $false

$WSUSConnectionGroupbox          = New-Object system.Windows.Forms.Groupbox
$WSUSConnectionGroupbox.height   = 131.19998168945312
$WSUSConnectionGroupbox.width    = 485.60003662109375
$WSUSConnectionGroupbox.text     = "WSUS Connection"
$WSUSConnectionGroupbox.location  = New-Object System.Drawing.Point(9,19)

$WSUSServerLabel                 = New-Object system.Windows.Forms.Label
$WSUSServerLabel.text            = "WSUS Server Name"
$WSUSServerLabel.AutoSize        = $true
$WSUSServerLabel.width           = 25
$WSUSServerLabel.height          = 10
$WSUSServerLabel.location        = New-Object System.Drawing.Point(12,28)
$WSUSServerLabel.Font            = 'Microsoft Sans Serif,10'

$WSUSSERVER                        = New-Object system.Windows.Forms.TextBox
$WSUSSERVER.multiline              = $false
$WSUSSERVER.width                  = 151.199951171875
$WSUSSERVER.height                 = 20
$WSUSSERVER.location               = New-Object System.Drawing.Point(146,23)
$WSUSSERVER.Font                   = 'Microsoft Sans Serif,10'

$WSUSConnectButton               = New-Object system.Windows.Forms.Button
$WSUSConnectButton.BackColor     = "#7ed321"
$WSUSConnectButton.text          = "Connect"
$WSUSConnectButton.width         = 88.79998779296875
$WSUSConnectButton.height        = 22.800003051757812
$WSUSConnectButton.location      = New-Object System.Drawing.Point(330,22)
$WSUSConnectButton.Font          = 'Microsoft Sans Serif,10'

$StatusLabel                     = New-Object system.Windows.Forms.Label
$StatusLabel.text                = "Status"
$StatusLabel.AutoSize            = $true
$StatusLabel.width               = 25
$StatusLabel.height              = 10
$StatusLabel.location            = New-Object System.Drawing.Point(200,52)
$StatusLabel.Font                = 'Microsoft Sans Serif,10'

$StatusTextBox                   = New-Object system.Windows.Forms.TextBox
$StatusTextBox.multiline         = $false
$StatusTextBox.BackColor         = '#FCD97A'
$StatusTextBox.width             = 461.6000061035156
$StatusTextBox.height            = 20
$StatusTextBox.location          = New-Object System.Drawing.Point(10,91)
$StatusTextBox.Font              = 'Microsoft Sans Serif,10'
$StatusTextBox.Font              = 'Microsoft Sans Serif,8'
$StatusTextBox.Text              = 'Run this program from the WSUS server,or a machine that has the console tools installed.'

$ControllPanelGroupbox           = New-Object system.Windows.Forms.Groupbox
$ControllPanelGroupbox.height    = 172.800048828125
$ControllPanelGroupbox.width     = 475.20001220703125
$ControllPanelGroupbox.BackColor  = "#bdb6b6"
$ControllPanelGroupbox.text      = "Control Panel"
$ControllPanelGroupbox.location  = New-Object System.Drawing.Point(13,166)

$WSUSSyncButton                  = New-Object system.Windows.Forms.Button
$WSUSSyncButton.BackColor        = "#50e3c2"
$WSUSSyncButton.text             = "WSUS Sync"
$WSUSSyncButton.width            = 90.39999389648437
$WSUSSyncButton.height           = 30
$WSUSSyncButton.location         = New-Object System.Drawing.Point(8,25)
$WSUSSyncButton.Font             = 'Microsoft Sans Serif,10'
$WSUSSyncButton.add_click({.\GUI\Wsus-Sync.ps1})

$CreateUpdateGroupButton         = New-Object system.Windows.Forms.Button
$CreateUpdateGroupButton.BackColor  = "#50e3c2"
$CreateUpdateGroupButton.text    = "Create Update Group"
$CreateUpdateGroupButton.width   = 144.80001831054687
$CreateUpdateGroupButton.height  = 30
$CreateUpdateGroupButton.location  = New-Object System.Drawing.Point(114,25)
$CreateUpdateGroupButton.Font    = 'Microsoft Sans Serif,10'
$CreateUpdateGroupButton.add_click({ .\GUI\GenerateNeededUpdates.ps1})
                    
$ApproveSoftwareUpdatesButton    = New-Object system.Windows.Forms.Button
$ApproveSoftwareUpdatesButton.BackColor  = "#50e3c2"
$ApproveSoftwareUpdatesButton.text  = "Approve Software Updates"
$ApproveSoftwareUpdatesButton.width  = 191.20001220703125
$ApproveSoftwareUpdatesButton.height  = 30
$ApproveSoftwareUpdatesButton.location  = New-Object System.Drawing.Point(270,25)
$ApproveSoftwareUpdatesButton.Font  = 'Microsoft Sans Serif,10'
$ApproveSoftwareUpdatesButton.add_click({ .\GUI\ApproveNeededUpdates.ps1})

$ComplianceReportButton          = New-Object system.Windows.Forms.Button
$ComplianceReportButton.BackColor  = "#50e3c2"
$ComplianceReportButton.text     = "Compliance Reports"
$ComplianceReportButton.width    = 166.4000244140625
$ComplianceReportButton.height   = 30
$ComplianceReportButton.location  = New-Object System.Drawing.Point(148,98)
$ComplianceReportButton.Font     = 'Microsoft Sans Serif,10'

$ExitButton                      = New-Object system.Windows.Forms.Button
$ExitButton.text                 = "Exit"
$ExitButton.width                = 60
$ExitButton.height               = 30
$ExitButton.location             = New-Object System.Drawing.Point(227,441)
$ExitButton.Font                 = 'Microsoft Sans Serif,15'

$WSUCommanderForm.controls.AddRange(@($WSUSConnectionGroupbox,$ControllPanelGroupbox,$ExitButton))
$WSUSConnectionGroupbox.controls.AddRange(@($WSUSServerLabel,$WSUSSERVER,$WSUSConnectButton,$StatusLabel,$StatusTextBox))
$ControllPanelGroupbox.controls.AddRange(@($WSUSSyncButton,$CreateUpdateGroupButton,$ApproveSoftwareUpdatesButton,$ComplianceReportButton))




#Write your logic code here
$WSUSConnectButton.add_click({
    Write-Host -ForegroundColor Blue -BackgroundColor Gray "Please keep this Windows Running to the side. A form window should be populated in the background."

    #Import Modules

    
    if ($(Get-Module).Name -like "*PoshWSUS*") {$StatusTextBox.Text = "PoshWSUS found and imported"
        $StatusTextBox.BackColor = '#3AD829'
        Write-Host -ForegroundColor Cyan Importing modules
        Import-Module PoshWSUS -Verbose
        
        Write-Host $WSUSServer.Text
        #Connect to WSUS Server
        Connect-PSWSUSServer -WsusServer $WSUSServer.text -Port 8530 -Verbose
        $StatusTextBox.Text = "Successfully connected to WSUS Server"
    }else{
        $StatusTextBox.BackColor = '#FF002B'
        $StatusTextBox.Text = "Unabled to load POSHWSUS or connect to WSUS Server"
    }
    

})

[void]$WSUCommanderForm.ShowDialog()