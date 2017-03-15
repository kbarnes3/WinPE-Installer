Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)

Import-Module $PSScriptRoot\WinPE.psd1 -Force

New-WinPEInstallMedia -ReuseSourcePath $ReuseSourcePath
