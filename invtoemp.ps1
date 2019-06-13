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

#Abfrage was gemacht werden soll
#1 Datenexport
#2 


#Wir möchten den Pfad haben in dem unser PowerShell .ps1 Skript gerade läuft.

function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

#Benutzerabfrage was gemacht werden soll 

$abfrage = Read-Host "Was soll gemacht werden? [1] -> PC Inventory starten [2] -> Daten zum Empirumserver übertragen"

if($abfrage -eq 1 ){
#aktuelle Pfad steht in $installpath
$installpath = Get-ScriptDirectory
$softwarepath = "_Full.bat"
$aufruf = $installpath + $softwarepath

Start-Process -Wait $aufruf #| out-file D:\ScanOrdner\$env:computername.xml#OLD!!

}
else{
if($abfrage -eq 2){
#Daten kopieren zum Empirumserver anschließend Backup

$quelle = "D:\InvScan"
$dirempirum = "\\ITESX0105\empinv$"
$dirbackup = "D:\InvScan\_Backup"
$datum = Get-Date -Format yyyyMMdd 

$dateien = Get-ChildItem -Path D:\InvScan\*.xml

foreach($datei in $dateien){
    Copy-Item $datei.FullName -Destination $dirempirum
    $newname = $datei.BaseName+"-"+$datum+".xmlold"
    Move-Item $datei.FullName -Destination $dirbackup\$newname
}
Write-Output "Daten wurden kopiert"
}
else{
  Write-Output "FEHLER falsche Eingabe!"  
  close 
}
}
