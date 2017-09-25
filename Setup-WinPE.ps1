Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath,
    [Parameter(Mandatory=$false)]
    [ValidateSet('All', 'RS1Only', 'DriversOnly')]
    [string]$ReuseSourceSet='All'
)

Import-Module $PSScriptRoot\WinPE.psd1 -Force

New-WinPEInstallMedia -ReuseSourcePath $ReuseSourcePath -ReuseSourceSet $ReuseSourceSet
