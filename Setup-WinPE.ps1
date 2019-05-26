Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath,
    [Parameter(Mandatory=$false)]
    [ValidateSet('All', 'RS5Only', 'RS5AndDrivers', '19H1Only', '19H1AndDrivers', 'RS5And19H1', 'DriversOnly')]
    [string]$ReuseSourceSet='All',
    [switch]$LowMemory
)

Import-Module $PSScriptRoot\WinPE.psd1 -Force

New-WinPEInstallMedia -ReuseSourcePath $ReuseSourcePath -ReuseSourceSet $ReuseSourceSet -LowMemory:$LowMemory
