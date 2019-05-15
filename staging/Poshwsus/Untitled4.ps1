###########################################################
# TimeFramePicker.ps1
#
# MeneerB 29/07/2015
###########################################################
Add-Type -AssemblyName System.Windows.Forms
# Main Form
$mainForm = New-Object System.Windows.Forms.Form
$font = New-Object System.Drawing.Font(“Consolas”, 13)
$mainForm.Text = ”Set Deadline”
$mainForm.Font = $font
$mainForm.ForeColor = “Black”
$mainForm.BackColor = “white"
$mainForm.Width = 600
$mainForm.Height = 200

# DatePicker Label
$datePickerLabel = New-Object System.Windows.Forms.Label
$datePickerLabel.Text = “Deadline Day”
$datePickerLabel.Location = “15, 10”
$datePickerLabel.Height = 22
$datePickerLabel.Width = 200
$mainForm.Controls.Add($datePickerLabel)

# MinTimePicker Label
$minTimePickerLabel = New-Object System.Windows.Forms.Label
$minTimePickerLabel.Text = “ Deadline Time (24hr)”
$minTimePickerLabel.Location = “10, 45”
$minTimePickerLabel.Height = 22
$minTimePickerLabel.Width = 220
$mainForm.Controls.Add($minTimePickerLabel)



# DatePicker
$datePicker = New-Object System.Windows.Forms.DateTimePicker
$datePicker.Location = “250, 7”
$datePicker.Width = “110”
$datePicker.Format = [windows.forms.datetimepickerFormat]::custom
$datePicker.CustomFormat = “MM/dd/yyyy”
$mainForm.Controls.Add($datePicker)

# MinTimePicker
$minTimePicker = New-Object System.Windows.Forms.DateTimePicker
$minTimePicker.Location = “250, 42”
$minTimePicker.Width = “110”
$minTimePicker.Format = [windows.forms.datetimepickerFormat]::custom
$minTimePicker.CustomFormat = “HH:mm:ss”
$minTimePicker.ShowUpDown = $TRUE
$mainForm.Controls.Add($minTimePicker)

# OD Button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = “15, 130”
$okButton.ForeColor = “Black”
$okButton.BackColor = “White”
$okButton.Text = “OK”
$okButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($okButton)

[void] $mainForm.ShowDialog()