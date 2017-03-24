function New-WinPEInstallMedia
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)
    $winpeWorkingDir = "R:\WinPE_amd64"
    $mountTempDir = "C:\WinPE_mount"
    $tempDir = Join-Path $winpeWorkingDir "temp"
    $dismScratchDir = Join-Path $tempDir "DismScratch"
    $cumulativeUpdate = Join-Path $tempDir "CumulativeUpdate.msu"
    $step = 0;

    if ($ReuseSourcePath) {
        Write-Host "Reusing large items from $ReuseSourcePath"
    }

    Set-Progress -CurrentOperation "Validating required source files" -StepNumber $step
    Confirm-Environment -ErrorAction Stop | Out-Null
    $step++

    $env:Path += ";C:\Program Files\7-Zip\"

    Set-Progress -CurrentOperation "Preparing working directory" -StepNumber $step
    Prep-WorkingDir -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -TempDir $tempDir -DismScratch $dismScratchDir
    $step++

    Set-Progress -CurrentOperation "Adding drivers" -StepNumber $step
    Add-Drivers -WinpeWorkingDir $winpeWorkingDir -ReuseSourcePath $ReuseSourcePath
    $step++

    Set-Progress -CurrentOperation "Copying cumulative update" -StepNumber $step
    Copy-Item $(Get-CumulativeUpdatePath) $cumulativeUpdate
    $step++

    Set-Progress -CurrentOperation "Configuring boot.wim" -StepNumber $step
    Update-BootWim -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -DismScratchDir $dismScratchDir
    $step++

    Set-Progress -CurrentOperation "Copying scripts" -StepNumber $step
    & robocopy "/S" "/XX" "$PSScriptRoot\On Disk" "$(Join-Path $winpeWorkingDir "media")" | Out-Null
    $step++

    Set-Progress -CurrentOperation "Preparing Client SKUs" -StepNumber $step
    Update-InstallWim -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -DismScratchDir $dismScratchDir -CumulativeUpdate $cumulativeUpdate -Sku Client -ReuseSourcePath $ReuseSourcePath
    $step++

    Set-Progress -StepNumber $step

}
Export-ModuleMember New-WinPEInstallMedia

function Prep-WorkingDir
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir,
    [Parameter(Mandatory=$true)]
    [string]$TempDir,
    [Parameter(Mandatory=$true)]
    [string]$DismScratchDir
)
    if (Test-Path $WinpeWorkingDir) {
        Remove-Item -Recurse -Force $WinpeWorkingDir -ErrorAction Stop | Out-Null
    }

    cmd /c copype amd64 $WinpeWorkingDir | Out-Null
    Push-Location $WinpeWorkingDir

    if (Test-Path $MountTempDir) {
        Remove-Item -Recurse -Force $MountTempDir -ErrorAction Stop | Out-Null
    }
    New-Item -Path $MountTempDir -ItemType Directory | Out-Null

    $scriptsDir = Join-Path $WinpeWorkingDir "media\Scripts"
    New-Item -Path $scriptsDir -ItemType Directory | Out-Null

    New-Item -Path $TempDir -ItemType Directory | Out-Null

    New-Item -Path $DismScratchDir -ItemType Directory | Out-Null
}

function Set-Progress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 7
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Step $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 0 -Activity "Generating WinPE Installer" -CurrentOperation $CurrentOperation -PercentComplete $percent -Status $status -Completed:$completed
}
