Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)

. $PSScriptRoot\SourceFiles.ps1
. $PSScriptRoot\Validation.ps1

ValidateEnvironment -ErrorAction Stop | Out-Null

$env:Path += ";C:\Program Files\7-Zip\"

if ($ReuseSourcePath) {
    Write-Host "Reusing large items from $ReuseSourcePath"
}
