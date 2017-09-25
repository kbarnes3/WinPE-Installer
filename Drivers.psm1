function Add-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)
    $driversScripts = Join-Path $WinpeWorkingDir "media\Scripts\Drivers"
    $driversRoot = Join-Path $WinpeWorkingDir "media\Drivers"

    if ($ReuseSourcePath) {
        Reuse-Drivers -DriversScripts $driversScripts -DriversRoot $driversRoot -ReuseSourcePath $ReuseSourcePath
    }
    else {
        New-Item -Path $driversScripts -ItemType Directory | Out-Null
        New-Item -Path $driversRoot -ItemType Directory | Out-Null

        Extract-Drivers -DriversScripts $driversScripts -DriversRoot $driversRoot
    }

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
        @{"friendlyName" = "Surface Pro"; "source" = Get-SurfaceProDrivers},
        @{"friendlyName" = "Surface Pro 2"; "source" = Get-SurfacePro2Drivers},
        @{"friendlyName" = "Surface 3"; "source" = Get-Surface3Drivers},
        @{"friendlyName" = "Surface Pro 3"; "source" = Get-SurfacePro3Drivers},
        @{"friendlyName" = "Surface Pro 4"; "source" = Get-SurfacePro4Drivers},
        @{"friendlyName" = "Surface Book"; "source" = Get-SurfaceBookDrivers},
        @{"friendlyName" = "Surface Studio"; "source" = Get-SurfaceStudioDrivers},
        @{"friendlyName" = "Surface Pro (2017)"; "source" = Get-SurfacePro2017Drivers},
        @{"friendlyName" = "Surface Laptop"; "source" = Get-SurfaceLaptopDrivers}

    for ($i = 0; $i -lt $devices.Length; $i++) {
        $device = $devices[$i]
        $friendlyName = $device["friendlyName"]
        $source = $device["source"]
        Set-Progress -FriendlyName $friendlyName -StepNumber $i -TotalSteps $devices.Length
        $shortName = $friendlyName
        $shortName = $shortName.replace(" ","")
        $shortName = $shortName.replace("(","")
        $shortName = $shortName.replace(")","")
        $driversMountPath = "\Drivers\$shortName"

        $destination = Join-Path $driversRoot $shortName
        $extension = [IO.Path]::GetExtension($source)

        if ($extension.ToLower() -eq ".msi") {
            & msiexec "/a" "$source" "targetdir=$($destination)" "/qn" | Out-Null
        }
        else
        {
            & 7z x "$source" "-o$($destination)" | Out-Null
        }

        $script = Join-Path $driversScripts "$shortName.bat"
        New-Item -Path $script -ItemType File | Out-Null
        Add-Content $script "mkdir W:\DismScratch`n"
        Add-Content $script "dism /Add-Driver /Image:W:\ /Driver:$driversMountPath /Recurse /ScratchDir:W:\DismScratch`n"
        Add-Content $script "rmdir /s /q W:\DismScratch`n"
        Add-Content $script "@ECHO $friendlyName drivers added. Run 'wpeutil shutdown' or 'wpeutil reboot'`n"
    }
    Set-Progress -StepNumber $devices.Length -TotalSteps $devices.Length
}

function Reuse-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$DriversScripts,
    [Parameter(Mandatory=$true)]
    [string]$DriversRoot,
    [Parameter(Mandatory=$true)]
    [string]$ReuseSourcePath
    )

    $sourceScripts = Join-Path $ReuseSourcePath "media\Scripts\Drivers"
    $sourceDrivers = Join-Path $ReuseSourcePath "media\Drivers"

    Copy-Item $sourceScripts $DriversScripts -Recurse
    Copy-Item $sourceDrivers $DriversRoot -Recurse
}

function Set-Progress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$FriendlyName,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber,
    [Parameter(Mandatory=$true)]
    [int]$TotalSteps
)
    $currentOperation = $null
    if ($FriendlyName) {
        $currentOperation = "Adding $FriendlyName drivers"
    }
    $percent = $StepNumber / $TotalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Device $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 1 -Activity " " -CurrentOperation $currentOperation -PercentComplete $percent -Status $status -Completed:$completed
}

