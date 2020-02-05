Param(
    [Parameter(Mandatory=$true)]
    [int]$DiskNumber,
    [switch]$ForceFormatUSB
)

if (-Not $ForceFormatUSB) {
    $disk = Get-PhysicalDisk -DeviceNumber $DiskNumber
    if ($disk.BusType -eq "USB") {
        $errorMessage = @'
You are attempting to format a USB device. This is probably not what you want.
If you are really, really sure you want to do this, pass the -ForceFormatUSB flag to this script.
'@
        throw $errorMessage
    }
}

$scriptName = "RS-BIOS.txt"
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
