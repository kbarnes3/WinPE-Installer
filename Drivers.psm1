function Add-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)
    $driversScripts = Join-Path $WinpeWorkingDir "media\Scripts\Drivers"
    $driversRoot = Join-Path $WinpeWorkingDir "media\Drivers"


}
Export-ModuleMember Add-Drivers
