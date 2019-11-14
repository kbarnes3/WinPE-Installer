function Update-InstallWim {
param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir,
    [Parameter(Mandatory=$true)]
    [string]$DismScratchDir,
    [Parameter(Mandatory=$true)]
    [string]$RS5ServicingStackUpdate,
    [Parameter(Mandatory=$true)]
    [string]$RS5CumulativeUpdate,
    [Parameter(Mandatory=$false)]
    [string]$ServicingStackUpdate19H2,
    [Parameter(Mandatory=$false)]
    [string]$CumulativeUpdate19H2,
    [Parameter(Mandatory=$true)]
    [ValidateSet('Consumer', 'Business', 'Server')]
    [string]$Sku,
    [Parameter(Mandatory=$false)]
    [string]$ReuseRS5Path,
    [Parameter(Mandatory=$false)]
    [string]$Reuse19H2Path
)
    switch ($Sku) {
        "Consumer" {
            $sourceIso = Get-ConsumerIsoPath
            $extractedWim = Join-Path $WinpeWorkingDir "temp\consumer.wim"
            $codebase = "19H2"
            $servicingStackUpdate = $ServicingStackUpdate19H2
            $cumulativeUpdate = $CumulativeUpdate19H2
            $reuseSourcePath = $Reuse19H2Path
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
        "Business" {
            $sourceIso = Get-BusinessIsoPath
            $extractedWim = Join-Path $WinpeWorkingDir "temp\business.wim"
            $codebase = "19H2"
            $servicingStackUpdate = $ServicingStackUpdate19H2
            $cumulativeUpdate = $CumulativeUpdate19H2
            $reuseSourcePath = $Reuse19H2Path
            $images =
            @{
                "SourceName" = "Windows 10 Enterprise"; 
                "DestinationName" = "Windows 10 Enterprise";
                "ShortName" = "Enterprise"
                "CompactEnabled" = $true
            }
        }
        "Server" {
            $sourceIso = Get-ServerIsoPath
            $extractedWim = Join-Path $WinpeWorkingDir "temp\server.wim"
            $codebase = "RS5"
            $servicingStackUpdate = $RS5ServicingStackUpdate
            $cumulativeUpdate = $RS5CumulativeUpdate
            $reuseSourcePath = $ReuseRS5Path
            $images =
            @{
                "SourceIndex" = 1; 
                "DestinationName" = "Windows Server 2019 Standard";
                "ShortName" = "Server-Standard-Core"
                "CompactEnabled" = $false
            },
            @{
                "SourceIndex" = 2; 
                "DestinationName" = "Windows Server 2019 Standard (Desktop Experience)";
                "ShortName" = "Server-Standard-Desktop"
                "CompactEnabled" = $false
            },
            @{
                "SourceIndex" = 3; 
                "DestinationName" = "Windows Server 2019 Datacenter";
                "ShortName" = "Server-Datacenter-Core"
                "CompactEnabled" = $false
            },
            @{
                "SourceIndex" = 4; 
                "DestinationName" = "Windows Server 2019 Datacenter (Desktop Experience)";
                "ShortName" = "Server-Datacenter-Desktop"
                "CompactEnabled" = $false
            }
        }
    }

    $step = 0

    Set-Progress -CurrentOperation "Extracting WIM" -StepNumber $step -ImageCount $images.Length
    if (-Not $reuseSourcePath) {
        Extract-Wim -SourceIso $sourceIso -DestinationWim $extractedWim
    }
    $step++

    $images | % {
        $destinationName = $_["DestinationName"]
        Set-Progress -CurrentOperation "Updating $destinationName" -StepNumber $step -ImageCount $images.Length
        if (-Not $reuseSourcePath) {
            if ($servicingStackUpdate -or $cumulativeUpdate) {
                Update-Image -SourceWim $extractedWim -ImageInfo $_ -MountTempDir $MountTempDir -DismScratchDir $DismScratchDir -ServicingStackUpdate $servicingStackUpdate -CumulativeUpdate $cumulativeUpdate
            }
        }
        $step++

        Set-Progress -CurrentOperation "Exporting $destinationName" -StepNumber $step -ImageCount $images.Length
        if (-Not $reuseSourcePath) {
            $destinationWim = "temp\$codebase.wim"
            Export-Image -SourceWim $extractedWim -DestinationWim $destinationWim -ImageInfo $_ -MountTempDir $MountTempDir -DismScratchDir $DismScratchDir
        }
        $step++

        Set-Progress -CurrentOperation "Creating install scripts for $destinationName" -StepNumber $step -ImageCount $images.Length
        Create-Scripts -WinpeWorkingDir $WinpeWorkingDir -Codebase $codebase -ImageInfo $_
        $step++
    }

    if (-Not $reuseSourcePath) {
        Remove-Item $extractedWim | Out-Null
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
    [Parameter(Mandatory=$false)]
    [string]$ServicingStackUpdate,
    [Parameter(Mandatory=$false)]
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
    elseif ($ImageInfo["SourceIndex"]){
        $mountParams.Add("Index", $ImageInfo["SourceIndex"])
    }
    else {
        throw "Unable to identify image to mount for $($ImageInfo["DestinationName"])"
    }
    Mount-WindowsImage @mountParams | Out-Null
    $step++

    if ($ServicingStackUpdate) {
        Set-UpdateProgress -CurrentOperation "Applying servicing stack update" -StepNumber $step
        Add-WindowsPackage -PackagePath $ServicingStackUpdate -Path $MountTempDir -ScratchDirectory $DismScratchDir | Out-Null
    }
    $step++

    if ($CumulativeUpdate) {
        Set-UpdateProgress -CurrentOperation "Applying cumulative update" -StepNumber $step
        Add-WindowsPackage -PackagePath $CumulativeUpdate -Path $MountTempDir -ScratchDirectory $DismScratchDir | Out-Null
    }
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
    elseif ($ImageInfo["SourceIndex"]) {
        $exportParams.Add("SourceIndex", $ImageInfo["SourceIndex"])
    }
   else {
        throw "Unable to identify image to export for $($ImageInfo["DestinationName"])"
    }

    Export-WindowsImage @exportParams | Out-Null
}

function Create-Scripts {
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$codebase,
    [Parameter(Mandatory=$true)]
    $ImageInfo
)
    $partitioningCodebase = "RS"
    $biosScripts = Join-Path $WinpeWorkingDir "\media\Scripts\BIOS\Install\$partitioningCodebase"
    if (-Not (Test-Path $biosScripts)) {
        New-Item -Path $biosScripts -ItemType Directory | Out-Null
    }
    $uefiScripts = Join-Path $WinpeWorkingDir "\media\Scripts\UEFI\Install\$partitioningCodebase"
    if (-Not (Test-Path $uefiScripts)) {
        New-Item -Path $uefiScripts -ItemType Directory | Out-Null
    }

    if ($ImageInfo["CompactEnabled"]) {
        $firstLine = "Param([switch]`$Compact)"
    }
    else {
        $firstLine = "`$Compact = `$false"
    }

    $biosScript = Join-Path $biosScripts "$($ImageInfo["ShortName"])-BIOS.ps1"
    New-Item -Path $biosScript -ItemType File | Out-Null
    Add-Content $biosScript $firstLine
    Add-Content $biosScript "& ..\Helpers\$($partitioningCodebase)-Install-BIOS.ps1 -Codebase $codebase -ImageName `"$($ImageInfo["DestinationName"])`" -Compact:`$Compact"

    $uefiScript = Join-Path $uefiScripts "$($ImageInfo["ShortName"])-UEFI.ps1"
    New-Item -Path $uefiScript -ItemType File | Out-Null
    Add-Content $uefiScript $firstLine
    Add-Content $uefiScript "& ..\Helpers\$($partitioningCodebase)-Install-UEFI.ps1 -Codebase $codebase -ImageName `"$($ImageInfo["DestinationName"])`" -Compact:`$Compact"
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
    $perImageSteps = 3
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
    $totalSteps = 5
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Step $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 2 -Activity " " -CurrentOperation $CurrentOperation -PercentComplete $percent -Status $status -Completed:$completed
}
