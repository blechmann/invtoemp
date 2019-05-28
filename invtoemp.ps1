###########################
#Daten Transfer zu Empirum#
###########################
<#
1. Aufruf EmpInventory.exe 
2. Ablage in INVSCAN
3. Export an Empirum Server
4. Daten ins Backup legen. 

Name Process :  345     28  13000  25880   0,86 11272  1 EmpInventory

#>

#Wir möchten den Pfad haben in dem unser PowerShell .ps1 Skript gerade läuft.

function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

#aktuelle Pfad steht in $installpath
$installpath = Get-ScriptDirectory
$softwarepath = "EmpInventory.exe"
$aufruf = $installpath + $softwarepath

Start-Process -FilePath $aufruf 
