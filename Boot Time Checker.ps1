# Boot-Time-Checker.ps1

Write-Host "==============================="
Write-Host "       Boot Time Checker"
Write-Host "==============================="
Write-Host ""

$OS = Get-CimInstance Win32_OperatingSystem
$LastBoot = $OS.LastBootUpTime
$Now = Get-Date
$Uptime = $Now - $LastBoot

Write-Host "Last Boot Time:"
Write-Host $LastBoot
Write-Host ""

Write-Host "System Uptime:"
Write-Host "$($Uptime.Days) Days $($Uptime.Hours) Hours $($Uptime.Minutes) Minutes"
Write-Host ""

Write-Host "Recent Boot Records (Last 5):"
Get-WinEvent -FilterHashtable @{LogName='System'; ID=6005} -MaxEvents 5 |
Select-Object TimeCreated |
Format-Table -AutoSize

Write-Host ""
Pause
