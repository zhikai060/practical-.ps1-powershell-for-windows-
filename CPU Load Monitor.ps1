# CPU-Load-Monitor.ps1

Write-Host "==============================="
Write-Host "     CPU & RAM Monitor"
Write-Host " Press Ctrl + C to exit"
Write-Host "==============================="
Write-Host ""

while ($true) {

    $CPU = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
    $OS = Get-CimInstance Win32_OperatingSystem

    $TotalRAM = $OS.TotalVisibleMemorySize
    $FreeRAM = $OS.FreePhysicalMemory
    $UsedRAMPercent = [math]::Round((($TotalRAM - $FreeRAM) / $TotalRAM) * 100, 2)

    Clear-Host

    Write-Host "CPU Usage: " ([math]::Round($CPU,2)) "%"
    Write-Host "RAM Usage: " $UsedRAMPercent "%"

    Start-Sleep -Seconds 0.5
}
