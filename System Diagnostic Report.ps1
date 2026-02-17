# System Diagnostic Report Tool
# Version 1.0

$DateString = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$OutputFile = "System_Report_$DateString.txt"

"=====================================" | Out-File $OutputFile
"       System Diagnostic Report      " | Out-File $OutputFile -Append
"=====================================" | Out-File $OutputFile -Append
"Date: $(Get-Date)" | Out-File $OutputFile -Append
"" | Out-File $OutputFile -Append

# Computer Info
"Computer Name: $env:COMPUTERNAME" | Out-File $OutputFile -Append
"Username: $env:USERNAME" | Out-File $OutputFile -Append
"" | Out-File $OutputFile -Append

# Windows Info
$OS = Get-CimInstance Win32_OperatingSystem
"-------- Windows Information --------" | Out-File $OutputFile -Append
"OS Name: $($OS.Caption)" | Out-File $OutputFile -Append
"Version: $($OS.Version)" | Out-File $OutputFile -Append
"Build: $($OS.BuildNumber)" | Out-File $OutputFile -Append
"" | Out-File $OutputFile -Append

# CPU Info
$CPU = Get-CimInstance Win32_Processor
"-------- CPU --------" | Out-File $OutputFile -Append
"Name: $($CPU.Name)" | Out-File $OutputFile -Append
"Cores: $($CPU.NumberOfCores)" | Out-File $OutputFile -Append
"Logical Processors: $($CPU.NumberOfLogicalProcessors)" | Out-File $OutputFile -Append
"" | Out-File $OutputFile -Append

# RAM Info
$TotalRAM = [math]::Round($OS.TotalVisibleMemorySize / 1MB, 2)
"-------- RAM --------" | Out-File $OutputFile -Append
"Total RAM: $TotalRAM GB" | Out-File $OutputFile -Append
"" | Out-File $OutputFile -Append

# Disk Info
"-------- Disk Information --------" | Out-File $OutputFile -Append
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $FreeGB = [math]::Round($_.FreeSpace / 1GB, 2)
    $SizeGB = [math]::Round($_.Size / 1GB, 2)
    "Drive $($_.DeviceID) - Free: $FreeGB GB / Total: $SizeGB GB" | Out-File $OutputFile -Append
}
"" | Out-File $OutputFile -Append

# Uptime
$LastBoot = $OS.LastBootUpTime
$Uptime = (Get-Date) - $LastBoot
"-------- Uptime --------" | Out-File $OutputFile -Append
"Last Boot: $LastBoot" | Out-File $OutputFile -Append
"Uptime: $($Uptime.Days) Days $($Uptime.Hours) Hours $($Uptime.Minutes) Minutes" | Out-File $OutputFile -Append

Write-Host ""
Write-Host "Report generated successfully!"
Write-Host "File saved as: $OutputFile"
Pause
