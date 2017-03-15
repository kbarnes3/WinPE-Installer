Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)

Import-Module $PSScriptRoot\WinPE.psd1 -Force

Confirm-Environment -ErrorAction Stop | Out-Null

$env:Path += ";C:\Program Files\7-Zip\"

if ($ReuseSourcePath) {
    Write-Host "Reusing large items from $ReuseSourcePath"
}
