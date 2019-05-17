<# 
.NAME
   Wsus-Sync
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$WSUSSyncForm                    = New-Object system.Windows.Forms.Form
$WSUSSyncForm.ClientSize         = '482,607'
$WSUSSyncForm.text               = "WSUS Sync"
$WSUSSyncForm.TopMost            = $false

$WSUSSyncServerStatus            = New-Object system.Windows.Forms.Label
$WSUSSyncServerStatus.text       = "WSUS Sync Server Status"
$WSUSSyncServerStatus.AutoSize   = $true
$WSUSSyncServerStatus.width      = 25
$WSUSSyncServerStatus.height     = 10
$WSUSSyncServerStatus.location   = New-Object System.Drawing.Point(129,13)
$WSUSSyncServerStatus.Font       = 'Microsoft Sans Serif,12'

$SyncAndServerStatusGroupbox     = New-Object system.Windows.Forms.Groupbox
$SyncAndServerStatusGroupbox.height  = 293
$SyncAndServerStatusGroupbox.width  = 454
$SyncAndServerStatusGroupbox.text  = "Wsus Server and Sync Statistics"
$SyncAndServerStatusGroupbox.location  = New-Object System.Drawing.Point(11,298)

$Last5SyncsDataGridView          = New-Object system.Windows.Forms.DataGridView
$Last5SyncsDataGridView.BackColor  = "#4a4a4a"
$Last5SyncsDataGridView.width    = 435
$Last5SyncsDataGridView.height   = 142
$Last5SyncsDataGridView.location  = New-Object System.Drawing.Point(10,144)

$Last5SyncstatusLabel            = New-Object system.Windows.Forms.Label
$Last5SyncstatusLabel.text       = "Last 5 Synchronizations"
$Last5SyncstatusLabel.AutoSize   = $true
$Last5SyncstatusLabel.width      = 25
$Last5SyncstatusLabel.height     = 10
$Last5SyncstatusLabel.location   = New-Object System.Drawing.Point(16,119)
$Last5SyncstatusLabel.Font       = 'Microsoft Sans Serif,10'

$SyncActionsGroupBox             = New-Object system.Windows.Forms.Groupbox
$SyncActionsGroupBox.height      = 234
$SyncActionsGroupBox.width       = 452
$SyncActionsGroupBox.text        = "Sync Actions"
$SyncActionsGroupBox.location    = New-Object System.Drawing.Point(14,43)

$DeclineRollupnetbutton          = New-Object system.Windows.Forms.RadioButton
$DeclineRollupnetbutton.text     = "Decline Monthly Security Rollup for .Net Framework"
$DeclineRollupnetbutton.AutoSize  = $true
$DeclineRollupnetbutton.width    = 104
$DeclineRollupnetbutton.height   = 20
$DeclineRollupnetbutton.location  = New-Object System.Drawing.Point(55,33)
$DeclineRollupnetbutton.Font     = 'Microsoft Sans Serif,10'

$DeclineRollupWindowsButton      = New-Object system.Windows.Forms.RadioButton
$DeclineRollupWindowsButton.text  = "Decline Monthly Security Rollup for Windows Server"
$DeclineRollupWindowsButton.AutoSize  = $true
$DeclineRollupWindowsButton.width  = 104
$DeclineRollupWindowsButton.height  = 20
$DeclineRollupWindowsButton.location  = New-Object System.Drawing.Point(56,63)
$DeclineRollupWindowsButton.Font  = 'Microsoft Sans Serif,10'

$SyncButton                      = New-Object system.Windows.Forms.Button
$SyncButton.BackColor            = "#50e3c2"
$SyncButton.text                 = "Start Sync"
$SyncButton.width                = 343
$SyncButton.height               = 30
$SyncButton.location             = New-Object System.Drawing.Point(49,96)
$SyncButton.Font                 = 'Microsoft Sans Serif,10'

$WSUSSyncStatusLabel             = New-Object system.Windows.Forms.Label
$WSUSSyncStatusLabel.BackColor   = "#b8e986"
$WSUSSyncStatusLabel.AutoSize    = $true
$WSUSSyncStatusLabel.width       = 25
$WSUSSyncStatusLabel.height      = 10
$WSUSSyncStatusLabel.location    = New-Object System.Drawing.Point(190,146)
$WSUSSyncStatusLabel.Font        = 'Microsoft Sans Serif,10'

$WSUSSyncForm.controls.AddRange(@($WSUSSyncServerStatus,$SyncAndServerStatusGroupbox,$SyncActionsGroupBox))
$SyncAndServerStatusGroupbox.controls.AddRange(@($Last5SyncsDataGridView,$Last5SyncstatusLabel))
$SyncActionsGroupBox.controls.AddRange(@($DeclineRollupnetbutton,$DeclineRollupWindowsButton,$SyncButton,$WSUSSyncStatusLabel))




#Write your logic code here

[void]$WSUSSyncForm.ShowDialog()