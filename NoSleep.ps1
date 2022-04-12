# ---------------------------------------
# NoSleep.ps1
# Daniel Oxley
# v1.0 - Initial Version
# v1.1 - Updates for slacking off brother
# ---------------------------------------

$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)

# Add library
Add-Type -AssemblyName System.Windows.Forms

# Set sleep time in seconds
[int]$intSleepFor = 0

function GenerateForm {

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$frmMain = New-Object System.Windows.Forms.Form
$btnMin = New-Object System.Windows.Forms.Button
$lblMsg = New-Object System.Windows.Forms.Label
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
$btnNoSleep_OnClick= 
{
    $btnNoSleep.Enabled = $false
    $txtSleepPeriod.Enabled = $false

    $frmMain.WindowState = [System.Windows.Forms.FormWindowState]::Minimized

    $intSleepFor = [convert]::ToInt32($txtSleepPeriod.Text, 10)
    $timer1.Interval = $intSleepFor * 1000
    $timer1.Enabled = $True
}

$handler_timer1_Tick= 
{
    $myshell = New-Object -com "Wscript.Shell"
    $myshell.SendKeys(“{NUMLOCK}{NUMLOCK}”)

    $lblMsg.Text = "Tick: $(Get-Date -Format "HH:mm.ss")"
}

$handler_label1_Click= 
{
#TODO: Place custom script here

}

$handler_btnExit_Click= 
{
    $frmMain.Close()
}

$btnMin_OnClick= 
{
    $frmMain.WindowState = [System.Windows.Forms.FormWindowState]::Minimized
}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$frmMain.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 54
$System_Drawing_Size.Width = 177
$frmMain.ClientSize = $System_Drawing_Size
$frmMain.ControlBox = $False
$frmMain.DataBindings.DefaultDataSourceUpdateMode = 0
$frmMain.FormBorderStyle = 1
$frmMain.MaximizeBox = $False
$frmMain.Name = "frmMain"
$frmMain.ShowIcon = $False
$frmMain.ShowInTaskbar = $True
$frmMain.SizeGripStyle = 2
$frmMain.StartPosition = 1
$frmMain.Text = "No Sleep Till..."
$frmMain.TopMost = $True


$btnMin.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 148
$System_Drawing_Point.Y = 26
$btnMin.Location = $System_Drawing_Point
$btnMin.Name = "btnMin"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 24
$btnMin.Size = $System_Drawing_Size
$btnMin.TabIndex = 4
$btnMin.Text = "▼"
$btnMin.UseVisualStyleBackColor = $True
$btnMin.add_Click($btnMin_OnClick)

$frmMain.Controls.Add($btnMin)

$lblMsg.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 66
$System_Drawing_Point.Y = 26
$lblMsg.Location = $System_Drawing_Point
$lblMsg.Name = "lblMsg"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 81
$lblMsg.Size = $System_Drawing_Size
$lblMsg.TabIndex = 5
$lblMsg.Text = "Ready to start"
$lblMsg.TextAlign = 16

$frmMain.Controls.Add($lblMsg)


$btnExit.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 134
$System_Drawing_Point.Y = 2
$btnExit.Location = $System_Drawing_Point
$btnExit.Name = "btnExit"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 22
$System_Drawing_Size.Width = 38
$btnExit.Size = $System_Drawing_Size
$btnExit.TabIndex = 2
$btnExit.Text = "Exit"
$btnExit.UseVisualStyleBackColor = $True
$btnExit.add_Click($handler_btnExit_Click)

$frmMain.Controls.Add($btnExit)


$btnNoSleep.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 3
$System_Drawing_Point.Y = 26
$btnNoSleep.Location = $System_Drawing_Point
$btnNoSleep.Name = "btnNoSleep"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 61
$btnNoSleep.Size = $System_Drawing_Size
$btnNoSleep.TabIndex = 3
$btnNoSleep.Text = "Brooklyn!"
$btnNoSleep.UseVisualStyleBackColor = $True
$btnNoSleep.add_Click($btnNoSleep_OnClick)

$frmMain.Controls.Add($btnNoSleep)

$txtSleepPeriod.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 99
$System_Drawing_Point.Y = 3
$txtSleepPeriod.Location = $System_Drawing_Point
$txtSleepPeriod.Name = "txtSleepPeriod"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 28
$txtSleepPeriod.Size = $System_Drawing_Size
$txtSleepPeriod.TabIndex = 1
$txtSleepPeriod.Text = "60"
$txtSleepPeriod.TextAlign = 2

$frmMain.Controls.Add($txtSleepPeriod)

$lblSleepPeriod.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 3
$System_Drawing_Point.Y = 0
$lblSleepPeriod.Location = $System_Drawing_Point
$lblSleepPeriod.Name = "lblSleepPeriod"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 100
$lblSleepPeriod.Size = $System_Drawing_Size
$lblSleepPeriod.TabIndex = 0
$lblSleepPeriod.Text = "Interval (seconds):"
$lblSleepPeriod.TextAlign = 16
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
