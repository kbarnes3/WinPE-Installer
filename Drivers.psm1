function New-WinPEDriverMedia {
    $DriverDir = Get-WinPEDriverDir
    $step = 0

    Suspend-Suspending

    Set-Progress -CurrentOperation "Validating required source files" -StepNumber $step
    Confirm-Environment -IgnoreWinPEDriverDir -ErrorAction Stop | Out-Null
    $step++

    Set-Progress -CurrentOperation "Removing existing drivers" -StepNumber $step
    if (Test-Path $DriverDir) {
        Remove-Item $DriverDir -Recurse -Force
    }
    $step++
    
    Set-Progress -CurrentOperation "Adding drivers" -StepNumber $step
    Add-Drivers -WinpeWorkingDir $DriverDir
    $step++

    Set-Progress -CurrentOperation "Copying scripts" -StepNumber $step
    & robocopy "/S" "/XX" "$PSScriptRoot\Driver Disk" "$(Join-Path $DriverDir "media")" | Out-Null
    $step++

    Push-Location $DriverDir
    $driverIsoPath = Join-Path $DriverDir "winpe-drivers.iso"

    Set-Progress -CurrentOperation "Creating winpe-drivers.iso" -StepNumber $step
    & oscdimg -u1 -udfver102 ".\media" $driverIsoPath | Out-Null
    $step++

    Set-Progress -CurrentOperation "Done" -StepNumber $step
    Write-Host "All done!"
    Write-Host "To create or update a bootable USB drive,"
    Write-Host "please see this project's README.md"

    Resume-Suspending
    Push-Location $PSScriptRoot
}
Export-ModuleMember New-WinPEDriverMedia

function Add-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir
)
    $driversScripts = Join-Path $WinpeWorkingDir "media\Scripts\Drivers"
    $driversRoot = Join-Path $WinpeWorkingDir "media\Drivers"

    New-Item -Path $driversScripts -ItemType Directory | Out-Null
    New-Item -Path $DriversRoot -ItemType Directory | Out-Null

    Extract-Drivers -DriversScripts $driversScripts -DriversRoot $driversRoot

}
Export-ModuleMember Add-Drivers

function Extract-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$DriversScripts,
    [Parameter(Mandatory=$true)]
    [string]$DriversRoot
    )

    $devices =
        @{"friendlyName" = "AMD RZ616"; "source" = Get-AmdRZ616WifiDrivers},
        @{"friendlyName" = "AMD RZ717"; "source" = Get-AmdRZ717WifiDrivers},
        @{"friendlyName" = "Intel WIFI"; "source" = Get-IntelWifiDrivers},
        @{"friendlyName" = "Intel Wired NICs"; "source" = Get-IntelNicDrivers},
        @{"friendlyName" = "Marvell NICs"; "source" = Get-MarvellNicDrivers}

    for ($i = 0; $i -lt $devices.Length; $i++) {
        $device = $devices[$i]
        $friendlyName = $device["friendlyName"]
        $source = $device["source"]
        Set-ExtractProgress -FriendlyName $friendlyName -StepNumber $i -TotalSteps $devices.Length
        $shortName = $friendlyName
        $shortName = $shortName.replace(" ","")
        $shortName = $shortName.replace("(","")
        $shortName = $shortName.replace(")","")
        $driversMountPath = "\Drivers\$shortName"

        $destination = Join-Path $driversRoot $shortName

        if (Test-Path -Path $source -PathType Container)
        {
            & robocopy "/S" "/XX" $source $destination | Out-Null
        } else {

            $extension = [IO.Path]::GetExtension($source)

            if ($extension.ToLower() -eq ".msi") {
                & msiexec "/a" "$source" "targetdir=$($destination)" "/qn" | Out-Null
            }
            else
            {
                & 7z x "$source" "-o$($destination)" | Out-Null
            }
        }

        $script = Join-Path $driversScripts "$shortName.ps1"
        Set-Content $script "Write-Host `"Adding $friendlyName drivers. This may take a few minutes.`""
        Add-Content $script "New-Item -Path W:\DismScratch -Type Directory | Out-Null"
        Add-Content $script "Add-WindowsDriver -Path W: -Driver $driversMountPath -Recurse -ScratchDirectory `"W:\DismScratch`""
        Add-Content $script "Remove-Item -Recurse -Force W:\DismScratch"
        Add-Content $script "Write-Host `"$friendlyName drivers added. `""
        Add-Content $script "Write-Host `"Run '`" -NoNewline"
        Add-Content $script "Write-Host `"wpeutil shutdown`" -ForegroundColor Yellow -NoNewline "
        Add-Content $script "Write-Host `"' or '`" -NoNewline"
        Add-Content $script "Write-Host `"wpeutil reboot`" -ForegroundColor Yellow -NoNewline"
        Add-Content $script "Write-Host `"'.`""
    }
    Set-ExtractProgress -StepNumber $devices.Length -TotalSteps $devices.Length
}

function Set-Progress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 5
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)

    Write-Progress -Id 0 -Activity "Generating WinPE Drivers" -Status $CurrentOperation -PercentComplete $percent -Completed:$completed
}

function Set-ExtractProgress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$FriendlyName,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber,
    [Parameter(Mandatory=$true)]
    [int]$TotalSteps
)
    $currentOperation = "Done"
    if ($FriendlyName) {
        $currentOperation = "Adding $FriendlyName drivers"
    }
    $percent = $StepNumber / $TotalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)

    Write-Progress -Id 1 -ParentId 0 -Activity "Adding drivers" -PercentComplete $percent -Status $currentOperation -Completed:$completed
}


