$registryPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

foreach ($path in $registryPaths) {
    $MyApp = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -match $AppName }
    if ($MyApp) { break }
 }

 if ($MyApp) {
    try {
        Write-Host "true"
        Exit 0
    }
    catch {
        Write-Host $_.Exception.Message
        Exit 1
    }
} else {
    Write-Host "Application with $AppName does not exist"
    try {
        Write-Host "false"
        Exit 0
    }
    catch {
        Write-Host $_.Exception.Message
        Exit 1
    }
}
