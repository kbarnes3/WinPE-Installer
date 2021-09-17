function New-WinPEInstallMedia
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath,
    [Parameter(Mandatory=$false)]
    [ValidateSet('All', 'VbOnly', 'FeOnly')]
    [string]$ReuseSourceSet,
    [switch]$LowMemory
)
    $winpeWorkingDir = "R:\WinPE_amd64"
    $mountTempDir = "C:\WinPE_mount"
    $tempDir = Join-Path $winpeWorkingDir "temp"
    # $servicingStackUpdateVb = Join-Path $tempDir "VbServicingStackUpdate.msu"
    $servicingStackUpdateVb = $null
    $cumulativeUpdateVb = Join-Path $tempDir "VbCumulativeUpdate.msu"
    $servicingStackUpdateFe = $null
    $cumulativeUpdateFe = Join-Path $tempDir "FeCumulativeUpdate.msu"
    $step = 0

    Start-Process KeepAwake.exe -WindowStyle Minimized

    if ($ReuseSourcePath) {
        if (($ReuseSourceSet -eq 'All') -Or (-Not $ReuseSourceSet)) {
            Write-Host "Reusing large items from $ReuseSourcePath"
            $ReuseVbPath = $ReuseSourcePath
            $ReuseFePath = $ReuseSourcePath
        }
        elseif ($ReuseSourceSet -eq 'VbOnly') {
            Write-Host "Reusing Vb items from $ReuseSourcePath"
            $ReuseVbPath = $ReuseSourcePath
        }
        elseif ($ReuseSourceSet -eq 'FeOnly') {
            Write-Host "Reusing Fe items from $ReuseSourcePath"
            $ReuseFePath = $ReuseSourcePath
        }
    }

    Set-Progress -CurrentOperation "Validating required source files" -StepNumber $step
    Confirm-Environment -ErrorAction Stop | Out-Null
    $step++

    Set-Progress -CurrentOperation "Preparing working directory" -StepNumber $step
    Prep-WorkingDir -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -TempDir $tempDir
    $step++

    if ($null -eq $ReuseVbPath) {
        Set-Progress -CurrentOperation "Copying Vb servicing stack update" -StepNumber $step
        # Copy-Item $(Get-ServicingStackUpdatePathVb) $servicingStackUpdateVb
    }
    $step++

    if ($null -eq $ReuseVbPath) {
        Set-Progress -CurrentOperation "Copying Vb cumulative update" -StepNumber $step
        Copy-Item $(Get-CumulativeUpdatePathVb) $cumulativeUpdateVb
    }
    $step++

    if ($null -eq $ReuseFePath) {
        Set-Progress -CurrentOperation "Copying Fe servicing stack update" -StepNumber $step
        # Copy-Item $(Get-ServicingStackUpdatePathFe) $servicingStackUpdateFe
    }
    $step++

    if ($null -eq $ReuseFePath) {
        Set-Progress -CurrentOperation "Copying Fe cumulative update" -StepNumber $step
        Copy-Item $(Get-CumulativeUpdatePathFe) $cumulativeUpdateFe
    }
    $step++

    Set-Progress -CurrentOperation "Configuring boot.wim" -StepNumber $step
    Update-BootWim -WinpeWorkingDir $winpeWorkingDir -DriversRoot $(Get-WinPEDriverDir) -MountTempDir $mountTempDir
    $step++

    Set-Progress -CurrentOperation "Copying scripts" -StepNumber $step
    & robocopy "/S" "/XX" "$PSScriptRoot\On Disk" "$(Join-Path $winpeWorkingDir "media")" | Out-Null
    $step++

    $skus = "Consumer", "Business", "Server"
    $skus | ForEach-Object {
        Set-Progress -CurrentOperation "Preparing $_ SKUs" -StepNumber $step
        Update-InstallWim `
            -WinpeWorkingDir $winpeWorkingDir `
            -MountTempDir $mountTempDir `
            -ServicingStackUpdateVb $servicingStackUpdateVb `
            -CumulativeUpdateVb $cumulativeUpdateVb `
            -ServicingStackUpdateFe $servicingStackUpdateFe `
            -CumulativeUpdateFe $cumulativeUpdateFe `
            -Sku $_ `
            -ReuseVbPath $ReuseVbPath `
            -ReuseFePath $ReuseFePath
        $step++
    }

    Set-Progress -CurrentOperation "Splitting Vb.wim" -StepNumber $step
    Split-Images -ImageName "Vb" -WinpeWorkingDir $winpeWorkingDir -ReuseSourcePath $ReuseVbPath
    $step++

    Set-Progress -CurrentOperation "Splitting Fe.wim" -StepNumber $step
    Split-Images -ImageName "Fe" -WinpeWorkingDir $winpeWorkingDir -ReuseSourcePath $ReuseFePath
    $step++

    Set-Progress -CurrentOperation "Removing temp files" -StepNumber $step
    Remove-Item -Recurse -Force "$winpeWorkingDir\temp"
    $step++

    $winpeFinalDir = "D:\WinPE_amd64"

    if ($LowMemory) {
        Set-Progress -CurrentOperation "Copying out of RAM drive to $winpeFinalDir" -StepNumber $step
        & robocopy /MIR $winpeWorkingDir $winpeFinalDir | Out-Null
        $step++

        $isoPath = Join-Path $winpeFinalDir "winpe.iso"

        Set-Progress -CurrentOperation "Creating winpe.iso" -StepNumber $step
        & cmd /c MakeWinPEMedia /ISO . $isoPath | Out-Null
        $step++

    } else {
        $isoPath = Join-Path $winpeWorkingDir "winpe.iso"

        Set-Progress -CurrentOperation "Creating winpe.iso" -StepNumber $step
        & cmd /c MakeWinPEMedia /ISO . $isoPath | Out-Null
        $step++

        Set-Progress -CurrentOperation "Copying out of RAM drive to $winpeFinalDir" -StepNumber $step
        & robocopy /MIR $winpeWorkingDir $winpeFinalDir | Out-Null
        $step++
    }

    Set-Progress -CurrentOperation "Copying winpe.iso to $env:DISC_PATH" -StepNumber $step
    $isoDestination = Join-Path $env:DISC_PATH "winpe.iso"
    Start-BitsTransfer -Source $isoPath -Destination $isoDestination
    $step++

    Set-Progress -StepNumber $step

    Set-Location $winpeFinalDir
    Write-Host "All done!"
    Write-Host "To create or update a bootable USB drive,"
    Write-Host "please see this project's README.md"

    Stop-Process -Name KeepAwake -ErrorAction SilentlyContinue
    Push-Location $PSScriptRoot

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
    [string]$TempDir
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
        Remove-Item -Path $wim | Out-Null
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
    $totalSteps = 17
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Step $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 0 -Activity "Generating WinPE Installer" -CurrentOperation $CurrentOperation -PercentComplete $percent -Status $status -Completed:$completed
}
