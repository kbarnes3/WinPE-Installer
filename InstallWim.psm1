function Update-InstallWim {
param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir,
    [Parameter(Mandatory=$true)]
    [string]$DismScratchDir,
    [Parameter(Mandatory=$true)]
    [string]$CumulativeUpdate,
    [Parameter(Mandatory=$true)]
    [ValidateSet('Client')]
    [string]$Sku,
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)
    switch ($Sku) {
        "Client" {
            $sourceIso = Get-ClientIsoPath
            $extractedWim = Join-Path $WinpeWorkingDir "temp\client.wim"
            $destinationWim = Join-Path $WinpeWorkingDir "temp\rs1.wim"
            $images =
            @{
                "SourceName" = "Windows 10 Home"; 
                "DestinationName" = "Windows 10 Home";
                "ShortName" = "Home"
                "CompactEnabled" = $true
            },
            @{
                "SourceName" = "Windows 10 Pro"; 
                "DestinationName" = "Windows 10 Pro";
                "ShortName" = "Pro"
                "CompactEnabled" = $true
            }
        }
    }

    $step = 0

    Set-Progress -CurrentOperation "Extracting WIM" -StepNumber $step -ImageCount $images.Length
    Extract-Wim -SourceIso $sourceIso -DestinationWim $extractedWim
    $step++

    $images | % {
        $destinationName = $_["DestinationName"]
        Set-Progress -CurrentOperation "Updating $destinationName" -StepNumber $step -ImageCount $images.Length
        Update-Image -SourceWim $extractedWim -ImageInfo $_ -MountTempDir $MountTempDir -DismScratchDir $DismScratchDir -CumulativeUpdate $CumulativeUpdate
        $step++

        Set-Progress -CurrentOperation "Exporting $destinationName" -StepNumber $step -ImageCount $images.Length
        Export-Image -SourceWim $extractedWim -DestinationWim $destinationWim -ImageInfo $_ -MountTempDir $MountTempDir -DismScratchDir $DismScratchDir
        $step++
    }

    Set-Progress -StepNumber $step -ImageCount $images.Length
}
Export-ModuleMember Update-InstallWim

function Extract-Wim
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$SourceIso,
    [Parameter(Mandatory=$true)]
    [string]$DestinationWim
)
    & 7z "e" "$SourceIso" "-otemp\" "sources\install.wim" | Out-Null
    Move-Item .\temp\install.wim $DestinationWim | Out-Null
}

function Update-Image
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$SourceWim,
    [Parameter(Mandatory=$true)]
    $ImageInfo,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir,
    [Parameter(Mandatory=$true)]
    [string]$DismScratchDir,
    [Parameter(Mandatory=$true)]
    [string]$CumulativeUpdate
)
    $step = 0

    Set-UpdateProgress -CurrentOperation "Mounting image" -StepNumber $step
    $mountParams = @{
        "ImagePath" = $SourceWim;
        "Path" = $MountTempDir;
        "ScratchDirectory" = $DismScratchDir;
        "ErrorAction" = "Stop"}

    if ($ImageInfo["SourceName"]) {
        $mountParams.Add("Name", $ImageInfo["SourceName"])
    }
    else {
        throw "Unable to identify image to mount for $($ImageInfo["DestinationName"])"
    }
    Mount-WindowsImage @mountParams | Out-Null
    $step++

    Set-UpdateProgress -CurrentOperation "Applying cumulative update" -StepNumber $step
    Add-WindowsPackage -PackagePath $CumulativeUpdate -Path $MountTempDir -ScratchDirectory $DismScratchDir | Out-Null
    $step++

    Set-UpdateProgress -CurrentOperation "Cleaning up image" -StepNumber $step
    & dism "/Cleanup-Image" "/Image:$MountTempDir" "/StartComponentCleanup" "/ResetBase" "/ScratchDir:$DismScratchDir" | Out-Null
    $step++

    Set-UpdateProgress -CurrentOperation "Dismounting image" -StepNumber $step
    Dismount-WindowsImage -Path $MountTempDir -Save -ScratchDirectory $DismScratchDir | Out-Null
    $step++

    Set-UpdateProgress -StepNumber $step
}

function Export-Image
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$SourceWim,
    [Parameter(Mandatory=$true)]
    [string]$DestinationWim,
    [Parameter(Mandatory=$true)]
    $ImageInfo,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir,
    [Parameter(Mandatory=$true)]
    [string]$DismScratchDir
)
    $exportParams = @{
        "SourceImagePath" = $SourceWim;
        "DestinationImagePath" = $DestinationWim;
        "DestinationName" = $ImageInfo["DestinationName"];
        "CompressionType" = "maximum"
        "ScratchDirectory" = $DismScratchDir
    }

    if ($ImageInfo["SourceName"]) {
        $exportParams.Add("SourceName", $ImageInfo["SourceName"])
    }

    Export-WindowsImage @exportParams | Out-Null

}

function Set-Progress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber,
    [Parameter(Mandatory=$true)]
    [int]$ImageCount
)
    $otherSteps = 1
    $perImageSteps = 2
    $totalSteps = ($ImageCount * $perImageSteps) + $otherSteps
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Step $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 1 -Activity " " -CurrentOperation $CurrentOperation -PercentComplete $percent -Status $status -Completed:$completed
}

function Set-UpdateProgress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 4
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Step $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 2 -Activity " " -CurrentOperation $CurrentOperation -PercentComplete $percent -Status $status -Completed:$completed
}
