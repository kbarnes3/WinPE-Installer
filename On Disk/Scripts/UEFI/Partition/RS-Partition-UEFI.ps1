Param(
    [Parameter(Mandatory=$true)]
    [int]$DiskNumber
)


$scriptName = "RS-UEFI.txt"
$tempDir = "X:\Temp"
$partitionScript = Join-Path $tempDir $scriptName

if (-Not (Test-Path $tempDir)) {
    New-Item -Path $tempDir -Type Directory | Out-Null
}

Set-Content $partitionScript "select disk $DiskNumber `n"
Add-Content $partitionScript (Get-Content "\DiskPart\$($scriptName)")
& diskpart /s $partitionScript

Set-Location ..\Install\RS
dir
Write-Host To install Windows, run the appropriate script listed above
