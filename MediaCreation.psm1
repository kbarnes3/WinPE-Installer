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

    skus = "Client", "Enterprise", "Server"
    skus | % {
        Set-Progress -CurrentOperation "Preparing $_ SKUs" -StepNumber $step
        Update-InstallWim -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -DismScratchDir $dismScratchDir -CumulativeUpdate $cumulativeUpdate -Sku $_ -ReuseSourcePath $ReuseSourcePath
        $step++
    }

    Set-Progress -CurrentOperation "Splitting RS1.wim" -StepNumber $step
    Split-Images -WinpeWorkingDir $winpeWorkingDir -ReuseSourcePath $ReuseSourcePath
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

function Split-Images
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)
    $imagesDir = Join-Path $WinpeWorkingDir "Images"

    if (-Not $ReuseSourcePath) {
        New-Item -Path $imagesDir -ItemType Directory

        $wim = Join-Path $WinpeWorkingDir "temp\rs1.wim"
        $swm = Join-Path $imagesDir "RS1.swm"

        Split-WindowsImage -ImagePath $wim -SplitImagePath $swm -FileSize 2048 | Out-Null
    }
    else {
        $sourceImagesDir = Join-Path $ReuseSourcePath "Images"
        Copy-Item $sourceImagesDir $imagesDir -Recurse
    }
}

function Set-Progress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 10
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Step $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 0 -Activity "Generating WinPE Installer" -CurrentOperation $CurrentOperation -PercentComplete $percent -Status $status -Completed:$completed
}
