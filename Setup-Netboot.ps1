Param(
    [string]$InstallSourcePath
)

Import-Module $PSScriptRoot\WinPE.psd1 -Force

New-WinPENetbootMedia -InstallSourcePath $InstallSourcePath
