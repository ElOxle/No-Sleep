# ----------------------
# NoSleep.ps1
# Daniel Oxley
# v1.0 - Initial Version
# ----------------------

# Add library
Add-Type -AssemblyName System.Windows.Forms

# Set sleep time in seconds
[int]$intSleepFor = 0

#Generated Form Function
function GenerateForm {

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$frmMain = New-Object System.Windows.Forms.Form
$btnExit = New-Object System.Windows.Forms.Button
$btnNoSleep = New-Object System.Windows.Forms.Button
$txtSleepPeriod = New-Object System.Windows.Forms.TextBox
$lblSleepPeriod = New-Object System.Windows.Forms.Label
$timer1 = New-Object System.Windows.Forms.Timer
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$btnNoSleep_OnClick= 
{
    $btnNoSleep.Enabled = $false
    $txtSleepPeriod.Enabled = $false

    $intSleepFor = [convert]::ToInt32($txtSleepPeriod.Text, 10)
    $timer1.Interval = $intSleepFor * 1000
    $timer1.Enabled = $True
}

$handler_timer1_Tick= 
{
    $myshell = New-Object -com "Wscript.Shell"
    $myshell.SendKeys(“{NUMLOCK}{NUMLOCK}”)

    Write-Host "Not sleeping for $($timer1.Interval / 1000) seconds."
}

$handler_btnExit_Click= 
{
    $frmMain.Close()
}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$frmMain.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 56
$System_Drawing_Size.Width = 182
$frmMain.ClientSize = $System_Drawing_Size
$frmMain.ControlBox = $False
$frmMain.DataBindings.DefaultDataSourceUpdateMode = 0
$frmMain.FormBorderStyle = 1
$frmMain.MaximizeBox = $False
$frmMain.Name = "frmMain"
$frmMain.ShowIcon = $False
$frmMain.ShowInTaskbar = $False
$frmMain.SizeGripStyle = 2
$frmMain.StartPosition = 1
$frmMain.Text = "No Sleep Till..."
$frmMain.TopMost = $True


$btnExit.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 99
$System_Drawing_Point.Y = 26
$btnExit.Location = $System_Drawing_Point
$btnExit.Name = "btnExit"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 75
$btnExit.Size = $System_Drawing_Size
$btnExit.TabIndex = 3
$btnExit.Text = "Exit"
$btnExit.UseVisualStyleBackColor = $True
$btnExit.add_Click($handler_btnExit_Click)

$frmMain.Controls.Add($btnExit)


$btnNoSleep.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 8
$System_Drawing_Point.Y = 26
$btnNoSleep.Location = $System_Drawing_Point
$btnNoSleep.Name = "btnNoSleep"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 75
$btnNoSleep.Size = $System_Drawing_Size
$btnNoSleep.TabIndex = 2
$btnNoSleep.Text = "No Sleep!"
$btnNoSleep.UseVisualStyleBackColor = $True
$btnNoSleep.add_Click($btnNoSleep_OnClick)

$frmMain.Controls.Add($btnNoSleep)

$txtSleepPeriod.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 136
$System_Drawing_Point.Y = 2
$txtSleepPeriod.Location = $System_Drawing_Point
$txtSleepPeriod.Name = "txtSleepPeriod"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 38
$txtSleepPeriod.Size = $System_Drawing_Size
$txtSleepPeriod.TabIndex = 1
$txtSleepPeriod.Text = "60"
$txtSleepPeriod.TextAlign = 2

$frmMain.Controls.Add($txtSleepPeriod)

$lblSleepPeriod.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 0
$System_Drawing_Point.Y = 0
$lblSleepPeriod.Location = $System_Drawing_Point
$lblSleepPeriod.Name = "lblSleepPeriod"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 129
$lblSleepPeriod.Size = $System_Drawing_Size
$lblSleepPeriod.TabIndex = 0
$lblSleepPeriod.Text = "Sleep period in seconds:"
$lblSleepPeriod.TextAlign = 64
$lblSleepPeriod.add_Click($handler_label1_Click)

$frmMain.Controls.Add($lblSleepPeriod)

$timer1.Interval = 60000
$timer1.Enabled = $False
$timer1.add_Tick($handler_timer1_Tick)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $frmMain.WindowState
#Init the OnLoad event to correct the initial state of the form
$frmMain.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$frmMain.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm