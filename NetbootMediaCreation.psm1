function New-WinPENetbootMedia
{
Param(
    [string]$InstallSourcePath
)
    $netbootDir = "D:\WinPE_amd64_netboot"
    $mountTempDir = "C:\WinPE_mount"
    $installBootWim = Join-Path $InstallSourcePath "media\sources\boot.wim"
    $step = 0

    Suspend-Suspending 

    Set-Progress -CurrentOperation "Validating required source files" -StepNumber $step
    Confirm-NetbootEnvironment -InstallBootWim $installBootWim -ErrorAction Stop | Out-Null
    $step++

    Set-Progress -CurrentOperation "Preparing working directory" -StepNumber $step
    Prep-WorkingDir -WinpeWorkingDir $netbootDir -MountTempDir $mountTempDir 
    $step++

    Resume-Suspending
    Push-Location $PSScriptRoot
}
Export-ModuleMember New-WinPENetbootMedia

function Prep-WorkingDir
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir
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
}

function Set-Progress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 2
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    if ($completed) {
        $CurrentOperation = "Done"
    }

    Write-Progress -Id 0 -Activity "Generating WinPE Netboot Installer" -PercentComplete $percent -Status $CurrentOperation -Completed:$completed
}
