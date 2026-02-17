
Clear-Host
Write-Host "================================="
Write-Host "         Ping Tool"
Write-Host " Press Q to stop"
Write-Host "================================="
Write-Host ""

$target = Read-Host "Enter IP address or hostname"

if ([string]::IsNullOrWhiteSpace($target)) {
    Write-Host "No input detected."
    Pause
    exit
}

$count = 0
$total = 0
$min = [int]::MaxValue
$max = 0

Write-Host ""
Write-Host "Pinging $target ..."
Write-Host ""

while ($true) {

    $ping = Test-Connection $target -Count 1 -ErrorAction SilentlyContinue

    if ($ping) {
        $time = [math]::Round($ping.ResponseTime)

        $count++
        $total += $time

        if ($time -lt $min) { $min = $time }
        if ($time -gt $max) { $max = $time }

        $avg = [math]::Round($total / $count, 2)

        Write-Host "Reply: $time ms  |  Min: $min  Max: $max  Avg: $avg" -ForegroundColor Green
    }
    else {
        Write-Host "Request timed out." -ForegroundColor Red
    }

    Start-Sleep -Seconds 1

    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        if ($key.Key -eq "Q") {
            break
        }
    }
}

Write-Host ""
Write-Host "================================="
Write-Host "        Final Statistics"
Write-Host "================================="
Write-Host "Packets Received: $count"

if ($count -gt 0) {
    $avg = [math]::Round($total / $count, 2)
    Write-Host "Minimum = $min ms"
    Write-Host "Maximum = $max ms"
    Write-Host "Average = $avg ms"
}

Pause
