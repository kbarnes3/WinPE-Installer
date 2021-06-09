Param(
    [string]$Codebase,
    [Parameter(Mandatory=$true)]
    [string]$ImageName,
    [switch]$Compact
)

$ImagePath = "\Images\$($Codebase).swm"
$SplitImageFilePattern = "\Images\$($Codebase)*.swm"

& $PSScriptRoot\Install-UEFI.ps1 -ImagePath $ImagePath -SplitImageFilePattern $SplitImageFilePattern -ImageName $ImageName -Compact:$Compact
