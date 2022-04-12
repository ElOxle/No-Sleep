#include <Constants.au3>

Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode", 3)

TraySetIcon("shell32.dll", 26)

$AboutItem = TrayCreateItem("About")
TrayItemSetOnEvent(-1,"ReadList")

$IntervalItem = TrayCreateItem("Set Interval")
TrayItemSetOnEvent(-1, "ReadList")

TrayCreateItem("")

$ExitItem = TrayCreateItem("Exit")
TrayItemSetOnEvent(-1,"ReadList")

; Get power plan, then set to high
$CurrentPlan = Run(@SystemDir & "\Powercfg.exe -getactivescheme", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
ProcessWaitClose($CurrentPlan)
$CurrentPlan = StdoutRead($CurrentPlan)
$CurrentPlan = StringMid($CurrentPlan, StringInStr($CurrentPlan, ": ") + 2, 36)

$SetHigh = Run(@SystemDir & "\Powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
ProcessWaitClose($SetHigh)

OnAutoItExitRegister("RevertPowerPlan")


$interval = 60
Call("SetInterval")

While 1

	Sleep($interval * 1000)

	TraySetIcon("shell32.dll", 44)

	$CurPos = MouseGetPos ( )
	MouseMove ( $CurPos[0] + 1, $CurPos[1] )
	MouseMove ( $CurPos[0] - 1, $CurPos[1] )

	Sleep(1000)

	$SetHigh = Run(@SystemDir & "\Powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($SetHigh)

	TraySetIcon("shell32.dll", 26)

WEnd

Func ReadList()

	$SelectedItem = TrayItemGetText(@TRAY_ID)

	If $SelectedItem = "Exit" Then

		Exit

	ElseIf $SelectedItem = "About" Then

		Call("About")

	ElseIf $SelectedItem = "Set Interval" Then

		Call("SetInterval")

	EndIf

EndFunc

Func About()

	MsgBox(064, "No Sleep... v2.1","Prevents your computer from automatically locking or going to screen saver after the idle timeout period.")

EndFunc

Func SetInterval()

   $newinterval = InputBox("No Sleep...", "Specify the number of seconds to wait before preventing sleep again" & @LF & @LF & "Your value must be at least 5 [seconds]", $interval)

   If $newinterval = "" Then

	  MsgBox(64, "No Sleep...", "No value specified, maintaining interval of " & $interval & " seconds)")

   ElseIf $newinterval < 5 Then

	  MsgBox(16, "No Sleep...", "You must specify a value of at least 5 [seconds].")
	  Call("SetInterval")

   Else

	  $interval = $newinterval

   EndIf

EndFunc

Func RevertPowerPlan()

	$ReturnPlan = Run(@SystemDir & "\Powercfg.exe /setactive " & $CurrentPlan, "", @SW_HIDE)
	ProcessWaitClose($ReturnPlan)

EndFunc

