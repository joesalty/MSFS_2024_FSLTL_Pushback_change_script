# --- CONFIGURATION ---
$rootPath    = "YOUR_EXACT_PATH_OH_THE_FSLTL_FOLDER eg: g:\WpSystem\S-1-5-21-3235851969-1608176482-1491362216-1001\AppData\Local\Packages\Microsoft.Limitless_8wekyb3d8bbwe\LocalCache\Packages\Community\fsltl-traffic-base\SimObjects\Airplanes\"
$targetFile  = "aircraft.cfg"
$lineToFind  = "PUSHBACK = 1"
$lineToWrite = "PUSHBACK = 0"
$logFile     = "YOUR_EXACT_LOG_FILE eg g:\pushback_edit_log.txt"

# --- DRY RUN MODE ---
$dryRun = $true   # Set to $false to actually modify files

# Start log
"--- Script started: $(Get-Date) ---" | Out-File -FilePath $logFile -Encoding UTF8

# --- SCRIPT ---
Get-ChildItem -Path $rootPath -Recurse -File -Filter $targetFile | ForEach-Object {
    $file = $_.FullName
    Write-Host "Processing: $file"

    $content = Get-Content $file
    $changed = $false

    # Simulate replacement
    $newContent = $content | ForEach-Object {
        if ($_ -eq $lineToFind) {
            $changed = $true
            $lineToWrite
        } else {
            $_
        }
    }

    if ($dryRun) {
        # DRY RUN: Do not modify anything
        if ($changed) {
            "DRY-RUN (WOULD CHANGE): $file" | Out-File -FilePath $logFile -Append -Encoding UTF8
        } else {
            "DRY-RUN (NO CHANGE): $file" | Out-File -FilePath $logFile -Append -Encoding UTF8
        }
    }
    else {
        # REAL MODE: Backup + write changes
        $backup = "$file.bak"
        Copy-Item -Path $file -Destination $backup -Force

        Set-Content -Path $file -Value $newContent

        if ($changed) {
            "CHANGED: $file" | Out-File -FilePath $logFile -Append -Encoding UTF8
        } else {
            "NO CHANGE: $file" | Out-File -FilePath $logFile -Append -Encoding UTF8
        }
    }
}

"--- Script finished: $(Get-Date) ---" | Out-File -FilePath $logFile -Append -Encoding UTF8
