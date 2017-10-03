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

$scriptBody = Get-Content "\DiskPart\$($scriptName)"
$scriptBody = $scriptBody -replace "\*\*DISKNUMBER\*\*", $DiskNumber
$scriptBody = $scriptBody -replace "\*\*MAINPARTITION\*\*", "W"
$scriptBody = $scriptBody -replace "\*\*MAINLABEL\*\*", "Windows"

Set-Content $partitionScript $scriptBody
& diskpart /s $partitionScript

Set-Location ..\Install\RS
dir
Write-Host To install Windows, run the appropriate script listed above
