Param(
    [Parameter(Mandatory=$true)]
    [int]$DiskNumber,
    [Parameter(Mandatory=$true)]
    [string]$VhdName
)


$scriptName = "RS-BIOS.txt"
$tempDir = "X:\Temp"
$partitionScript = Join-Path $tempDir $scriptName

if (-Not (Test-Path $tempDir)) {
    New-Item -Path $tempDir -Type Directory | Out-Null
}

$scriptBody = Get-Content "\DiskPart\$($scriptName)"
$scriptBody = $scriptBody -replace "\*\*DISKNUMBER\*\*", $DiskNumber
$scriptBody = $scriptBody -replace "\*\*MAINPARTITION\*\*", "V"
$scriptBody = $scriptBody -replace "\*\*MAINLABEL\*\*", "VHDs"

Set-Content $partitionScript $scriptBody
& diskpart /s $partitionScript

New-Item -Path "V:\VHDs" -Type Directory | Out-Null

if (-Not ($VhdName.ToLower().EndsWith(".vhdx"))) {
    $VhdName += ".vhd"
}

$scriptPart2Name = "RS-VHD.txt"
$vhdScript = Join-Path $tempDir $scriptPart2Name

$scriptPart2Body = Get-Content "\DiskPart\$($scriptPart2Name)"
$scriptPart2Body = $scriptPart2Body -replace "\*\*VHDNAME\*\*", $VhdName

Set-Content $vhdScript $scriptPart2Body
& diskpart /s $vhdScript

Set-Location ..\Install\RS
dir
Write-Host To install Windows, run the appropriate script listed above
