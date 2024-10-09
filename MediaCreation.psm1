function New-WinPEInstallMedia
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath,
    [Parameter(Mandatory=$false)]
    [ValidateSet('All', 'FeOnly', 'GeOnly')]
    [string]$ReuseSourceSet,
    [switch]$LowMemory
)
    $winpeWorkingDir = "R:\WinPE_amd64"
    $mountTempDir = "C:\WinPE_mount"
    $winREmountTempDir = "C:\WinRE_mount"
    $tempDir = Join-Path $winpeWorkingDir "temp"
    $servicingStackUpdateFe = $null
    $cumulativeUpdateDirFe = Join-Path $tempDir "FeCumulativeUpdate"
    $servicingStackUpdateGe = $null
    $cumulativeUpdateDirGe = Join-Path $tempDir "GeCumulativeUpdate"
    $step = 0

    Suspend-Suspending

    if ($ReuseSourcePath) {
        if (($ReuseSourceSet -eq 'All') -Or (-Not $ReuseSourceSet)) {
            Write-Host "Reusing large items from $ReuseSourcePath"
            $ReuseFePath = $ReuseSourcePath
            $ReuseGePath = $ReuseSourcePath
        }
        elseif ($ReuseSourceSet -eq 'FeOnly') {
            Write-Host "Reusing Fe items from $ReuseSourcePath"
            $ReuseFePath = $ReuseSourcePath
        }
        elseif ($ReuseSourceSet -eq 'GeOnly') {
            Write-Host "Reusing Ge items from $ReuseSourcePath"
            $ReuseGePath = $ReuseSourcePath
        }
    }

    Set-Progress -CurrentOperation "Validating required source files" -StepNumber $step
    Confirm-Environment -ErrorAction Stop | Out-Null
    $step++

    Set-Progress -CurrentOperation "Preparing working directory" -StepNumber $step
    Prep-WorkingDir -WinpeWorkingDir $winpeWorkingDir -MountTempDir $mountTempDir -WinREMountTempDir $winREmountTempDir -TempDir $tempDir
    $step++

    if ($null -eq $ReuseFePath) {
        Set-Progress -CurrentOperation "Copying Fe servicing stack update" -StepNumber $step
        $ssuFeSource = Get-ServicingStackUpdatePathFe
        if ($ssuFeSource) {
            $servicingStackUpdateFe = Join-Path $tempDir "FeSSU.cab"
            Copy-Item $ssuFeSource $servicingStackUpdateFe
        }
    }
    $step++

    if ($null -eq $ReuseFePath) {
        Set-Progress -CurrentOperation "Copying Fe cumulative update" -StepNumber $step
        New-Item $cumulativeUpdateDirFe -ItemType Directory | Out-Null
        $updateFiles = Join-Path $(Get-CumulativeUpdatePathFe) "*.msu"
        Copy-Item $updateFiles $cumulativeUpdateDirFe
    }
    $step++

    if ($null -eq $ReuseGePath) {
        Set-Progress -CurrentOperation "Copying Ge servicing stack update" -StepNumber $step
        $ssuGeSource = Get-ServicingStackUpdatePathGe
        if ($ssuGeSource) {
            $servicingStackUpdateGe = Join-Path $tempDir "GeSSU.cab"
            Copy-Item $ssuGeSource $servicingStackUpdateGe
        }
    }
    $step++

    if ($null -eq $ReuseGePath) {
        Set-Progress -CurrentOperation "Copying Ge cumulative update" -StepNumber $step
        New-Item $cumulativeUpdateDirGe -ItemType Directory | Out-Null
        $updateFiles = Join-Path $(Get-CumulativeUpdatePathGe) "*.msu"
        Copy-Item $updateFiles $cumulativeUpdateDirGe
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
            -WinREMountTempDir $winREMountTempDir `
            -ServicingStackUpdateFe $servicingStackUpdateFe `
            -CumulativeUpdateDirFe $cumulativeUpdateDirFe `
            -ServicingStackUpdateGe $servicingStackUpdateGe `
            -CumulativeUpdateDirGe $cumulativeUpdateDirGe `
            -Sku $_ `
            -ReuseFePath $ReuseFePath `
            -ReuseGePath $ReuseGePath
        $step++
    }

    Set-Progress -CurrentOperation "Splitting Fe.wim" -StepNumber $step
    Split-Images -ImageName "Fe" -WinpeWorkingDir $winpeWorkingDir -ReuseSourcePath $ReuseFePath
    $step++

    Set-Progress -CurrentOperation "Splitting Ge.wim" -StepNumber $step
    Split-Images -ImageName "Ge" -WinpeWorkingDir $winpeWorkingDir -ReuseSourcePath $ReuseGePath
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

    Set-Progress -StepNumber $step

    Set-Location $winpeFinalDir
    Write-Host "All done!"
    Write-Host "To create or update a bootable USB drive,"
    Write-Host "please see this project's README.md"

    Resume-Suspending
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
    [string]$WinREMountTempDir,
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

    if (Test-Path $WinREMountTempDir) {
        Remove-Item -Recurse -Force $WinREMountTempDir -ErrorAction Stop | Out-Null
    }
    New-Item -Path $WinREMountTempDir -ItemType Directory | Out-Null

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
    $totalSteps = 16
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    if ($completed) {
        $CurrentOperation = "Done"
    }

    Write-Progress -Id 0 -Activity "Generating WinPE Installer" -PercentComplete $percent -Status $CurrentOperation -Completed:$completed
}
