Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath,
    [Parameter(Mandatory=$false)]
    [ValidateSet('All', 'RS5Only', 'VbOnly')]
    [string]$ReuseSourceSet='All',
    [switch]$LowMemory
)

Import-Module $PSScriptRoot\WinPE.psd1 -Force

New-WinPEInstallMedia -ReuseSourcePath $ReuseSourcePath -ReuseSourceSet $ReuseSourceSet -LowMemory:$LowMemory
