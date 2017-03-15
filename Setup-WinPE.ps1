Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)

Import-Module $PSScriptRoot\SourceFiles.psm1 -Force
Import-Module $PSScriptRoot\Validation.psm1 -Force

Confirm-Environment -ErrorAction Stop | Out-Null

$env:Path += ";C:\Program Files\7-Zip\"

if ($ReuseSourcePath) {
    Write-Host "Reusing large items from $ReuseSourcePath"
}
