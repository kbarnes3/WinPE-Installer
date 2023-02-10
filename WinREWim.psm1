function Update-WinREImage
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$Codebase,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir,
    [Parameter(Mandatory=$true)]
    [string]$WinREMountTempDir,
    [Parameter(Mandatory=$true)]
    [string]$CumulativeUpdate
)
    $winreTempPath = Get-WinReTempPath -WinpeWorkingDir $WinpeWorkingDir -Codebase $Codebase
    $winreFinalPath = Join-Path $MountTempDir "Windows\System32\Recovery\winre.wim"
    if (-Not (Test-Path $winreTempPath))
    {
        $step = 0
        Copy-Item $winreFinalPath $winreTempPath
    
        Set-WinREUpdateProgress -Codebase $Codebase -CurrentOperation "Mounting image" -StepNumber $step
        $mountParams = @{
            "ImagePath" = $winreTempPath;
            "Path" = $WinREMountTempDir;
            "Index" = 1;
            "ErrorAction" = "Stop"}

        Mount-WindowsImage @mountParams | Out-Null
        $step++

        if ($CumulativeUpdate) {
            Set-WinREUpdateProgress -Codebase $Codebase -CurrentOperation "Applying cumulative update" -StepNumber $step
            Add-WindowsPackage -PackagePath $CumulativeUpdate -Path $WinREMountTempDir | Out-Null
        }
        $step++

        Set-WinREUpdateProgress -Codebase $Codebase -CurrentOperation "Cleaning up image" -StepNumber $step
        & dism "/Cleanup-Image" "/Image:$WinREMountTempDir" "/StartComponentCleanup" "/ResetBase" | Out-Null
        $step++

        Set-WinREUpdateProgress -Codebase $Codebase -CurrentOperation "Dismounting image" -StepNumber $step
        Dismount-WindowsImage -Path $WinREMountTempDir -Save  | Out-Null
        $step++

        Set-WinREUpdateProgress -StepNumber $step
        $version = (Get-WindowsImage -ImagePath $winreTempPath -Index 1).Version

        Write-Host "$Codebase Winre.wim updated to $version"
    }

    Copy-Item $winreTempPath $winreFinalPath -Force

}

function Get-WinReTempPath
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$Codebase
)
    $relativePath = "temp\$Codebase-WinRE.wim"
    $fullPath = Join-Path $WinpeWorkingDir $relativePath

    return $fullPath
}

function Set-WinREUpdateProgress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$Codebase,
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 4
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    if ($completed) {
        $CurrentOperation = "Done"
    }

    Write-Progress -Id 3 -ParentId 2 -Activity "Updating $Codebase WinRE.wim" -PercentComplete $percent -Status $CurrentOperation -Completed:$completed
}
