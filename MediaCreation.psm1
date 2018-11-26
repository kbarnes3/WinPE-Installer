function New-WinPEInstallMedia
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath,
    [Parameter(Mandatory=$false)]
    [ValidateSet('All', 'RS5Only', 'DriversOnly')]
    [string]$ReuseSourceSet
)
    $winpeWorkingDir = "R:\WinPE_amd64"
    $mountTempDir = "C:\WinPE_mount"
    $tempDir = Join-Path $winpeWorkingDir "temp"
    $dismScratchDir = Join-Path $tempDir "DismScratch"
    $rs5ServicingStackUpdate = Join-Path $tempDir "RS5ServicingStackUpdate.msu"
    $rs5CumulativeUpdate = Join-Path $tempDir "RS5CumulativeUpdate.msu"
    $step = 0;

    Start-Process KeepAwake.exe -WindowStyle Minimized

    if ($ReuseSourcePath) {
        if (($ReuseSourceSet -eq 'All') -Or (-Not $ReuseSourceSet)) {
            Write-Host "Reusing large items from $ReuseSourcePath"
            $ReuseDriversPath = $ReuseSourcePath
            $ReuseRS5Path = $ReuseSourcePath
        }
        elseif ($ReuseSourceSet -eq 'RS5Only') {
            Write-Host "Reusing RS1 items from $ReuseSourcePath"
            $ReuseDriversPath = $null
            $ReuseRS5Path = $ReuseSourcePath
        }
        elseif ($ReuseSourceSet -eq 'DriversOnly') {
            Write-Host "Reusing drivers from $ReuseSourcePath"
            $ReuseDriversPath = $ReuseSourcePath
            $ReuseRS5Path = $null
        }
    }

    Set-Progress -CurrentOperation "Validating required source files" -StepNumber $step
    Confirm-Environment -ErrorAction Stop | Out-Null
    $step++

    $env:Path += ";C:\Program Files\7-Zip\"

    Set-Progress -CurrentOperation "Preparing working directory" -StepNumber $step
    Prep-WorkingDir -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -TempDir $tempDir -DismScratch $dismScratchDir
    $step++

    Set-Progress -CurrentOperation "Adding drivers" -StepNumber $step
    Add-Drivers -WinpeWorkingDir $winpeWorkingDir -ReuseSourcePath $ReuseDriversPath
    $step++

    if ($ReuseRS5Path -eq $null) {
        Set-Progress -CurrentOperation "Copying RS5 servicing stack update" -StepNumber $step
        Copy-Item $(Get-RS5ServicingStackUpdatePath) $rs5ServicingStackUpdate
    }
    $step++

    if ($ReuseRS5Path -eq $null) {
        Set-Progress -CurrentOperation "Copying RS5 cumulative update" -StepNumber $step
        Copy-Item $(Get-RS5CumulativeUpdatePath) $rs5CumulativeUpdate
    }
    $step++

    Set-Progress -CurrentOperation "Configuring boot.wim" -StepNumber $step
    Update-BootWim -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -DismScratchDir $dismScratchDir
    $step++

    Set-Progress -CurrentOperation "Copying scripts" -StepNumber $step
    & robocopy "/S" "/XX" "$PSScriptRoot\On Disk" "$(Join-Path $winpeWorkingDir "media")" | Out-Null
    $step++

    $skus = "Consumer", "Business", "Server"
    $skus | % {
        Set-Progress -CurrentOperation "Preparing $_ SKUs" -StepNumber $step
        Update-InstallWim -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -DismScratchDir $dismScratchDir -RS5ServicingStackUpdate $rs5ServicingStackUpdate -RS5CumulativeUpdate $rs5CumulativeUpdate -Sku $_ -ReuseRS5Path $ReuseRS5Path
        $step++
    }

    Set-Progress -CurrentOperation "Splitting RS5.wim" -StepNumber $step
    Split-Images -ImageName "RS5" -WinpeWorkingDir $winpeWorkingDir -ReuseSourcePath $ReuseRS5Path
    $step++

    Set-Progress -CurrentOperation "Creating winpe.iso" -StepNumber $step
    & cmd /c MakeWinPEMedia /ISO . winpe.iso | Out-Null
    $step++

    $winpeFinalDir = "D:\WinPE_amd64"

    Set-Progress -CurrentOperation "Copying out of RAM drive to $winpeFinalDir" -StepNumber $step
    & robocopy /MIR $winpeWorkingDir $winpeFinalDir /XD temp | Out-Null
    $step++

    Set-Progress -CurrentOperation "Copying winpe.iso to $env:DISC_PATH" -StepNumber $step
    $isoDestination = Join-Path $env:DISC_PATH "winpe.iso"
    Start-BitsTransfer -Source winpe.iso -Destination $isoDestination
    $step++

    Set-Progress -StepNumber $step

    Set-Location $winpeFinalDir
    Write-Host "All done!"
    Write-Host "To make a bootable USB drive, run:"
    Write-Host "MakeWinPEMedia /UFD $winpeFinalDir X:"
    Write-Host "Where X: is the drive letter of your USB drive"
    Write-Host "And existing drive can be updated by running:"
    Write-Host "robocopy $winpeFinalDir\media X: /MIR /FFT /DST"

    Stop-Process -Name KeepAwake -ErrorAction SilentlyContinue

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
    [string]$ImageName,
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)
    $imagesDir = Join-Path $WinpeWorkingDir "media\Images"
    if (-Not (Test-Path $imagesDir)) {
        New-Item -Path $imagesDir -ItemType Directory | Out-Null
    }

    if (-Not $ReuseSourcePath) {
        $wim = Join-Path $WinpeWorkingDir "temp\$($ImageName).wim"
        $swm = Join-Path $imagesDir "$($ImageName).swm"

        Split-WindowsImage -ImagePath $wim -SplitImagePath $swm -FileSize 2048 | Out-Null
    }
    else {
        $sourceImagesFiles = Join-Path $ReuseSourcePath "media\Images\$($ImageName)*.swm"
        Copy-Item $sourceImagesFiles $imagesDir | Out-Null
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
    $totalSteps = 14
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Step $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 0 -Activity "Generating WinPE Installer" -CurrentOperation $CurrentOperation -PercentComplete $percent -Status $status -Completed:$completed
}
