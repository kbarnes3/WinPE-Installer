function Add-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$DriversRoot,
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)
    $driversScripts = Join-Path $WinpeWorkingDir "drivers-media\Scripts\Drivers"

    if ($ReuseSourcePath) {
        Reuse-Drivers -WinpeWorkingDir $WinpeWorkingDir -ReuseSourcePath $ReuseSourcePath
    }
    else {
        New-Item -Path $driversScripts -ItemType Directory | Out-Null
        New-Item -Path $DriversRoot -ItemType Directory | Out-Null

        Extract-Drivers -DriversScripts $driversScripts -DriversRoot $DriversRoot
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
        @{"friendlyName" = "Surface Laptop"; "source" = Get-SurfaceLaptopDrivers},
        @{"friendlyName" = "Surface Book 2"; "source" = Get-SurfaceBook2Drivers},
        @{"friendlyName" = "Surface Go"; "source" = Get-SurfaceGoDrivers},
        @{"friendlyName" = "Surface Laptop 2"; "source" = Get-SurfaceLaptop2Drivers},
        @{"friendlyName" = "Surface Pro 6"; "source" = Get-SurfacePro6Drivers},
        @{"friendlyName" = "Surface Studio 2"; "source" = Get-SurfaceStudio2Drivers}

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
    Set-Progress -StepNumber $devices.Length -TotalSteps $devices.Length
}

function Reuse-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$ReuseSourcePath
    )

    $sourcePath = Join-Path $ReuseSourcePath "drivers-media"
    $destPath = Join-Path $WinpeWorkingDir "drivers-media"

    Copy-Item $sourcePath $destPath -Recurse
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

