function Update-InstallWim {
param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir,
    [Parameter(Mandatory=$true)]
    [ValidateSet('Consumer', 'Business', 'Server')]
    [string]$Sku,
    [Parameter(Mandatory=$false)]
    [string]$ReuseGePath
)
    switch ($Sku) {
        "Consumer" {
            $sourceIso = Get-ConsumerIsoPath
            $extractedWim = Join-Path $WinpeWorkingDir "temp\consumer.wim"
            $codebase = "Ge"
            $reuseSourcePath = $ReuseGePath
            $images =
            @{
                "SourceName" = "Windows 11 Home"; 
                "DestinationName" = "Windows 11 Home";
                "ShortName" = "Home"
                "CompactEnabled" = $true
            },
            @{
                "SourceName" = "Windows 11 Pro"; 
                "DestinationName" = "Windows 11 Pro";
                "ShortName" = "Pro"
                "CompactEnabled" = $true
            }
        }
        "Business" {
            $sourceIso = Get-BusinessIsoPath
            $extractedWim = Join-Path $WinpeWorkingDir "temp\business.wim"
            $codebase = "Ge"
            $reuseSourcePath = $ReuseGePath
            $images =
            @{
                "SourceName" = "Windows 11 Enterprise"; 
                "DestinationName" = "Windows 11 Enterprise";
                "ShortName" = "Enterprise"
                "CompactEnabled" = $true
            }
        }
        "Server" {
            $sourceIso = Get-ServerIsoPath
            $extractedWim = Join-Path $WinpeWorkingDir "temp\server.wim"
            $codebase = "Ge"
            $reuseSourcePath = $ReuseGePath
            $images =
            @{
                "SourceIndex" = 1; 
                "DestinationName" = "Windows Server 2025 Standard";
                "ShortName" = "Server-Standard-Core"
                "CompactEnabled" = $false
            },
            @{
                "SourceIndex" = 2; 
                "DestinationName" = "Windows Server 2025 Standard (Desktop Experience)";
                "ShortName" = "Server-Standard-Desktop"
                "CompactEnabled" = $false
            },
            @{
                "SourceIndex" = 3; 
                "DestinationName" = "Windows Server 2025 Datacenter";
                "ShortName" = "Server-Datacenter-Core"
                "CompactEnabled" = $false
            },
            @{
                "SourceIndex" = 4; 
                "DestinationName" = "Windows Server 2025 Datacenter (Desktop Experience)";
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

    $images | ForEach-Object {
        $destinationName = $_["DestinationName"]
        Set-Progress -CurrentOperation "Exporting $destinationName" -StepNumber $step -ImageCount $images.Length
        if (-Not $reuseSourcePath) {
            $destinationWim = "temp\$codebase.wim"
            Export-Image -SourceWim $extractedWim -DestinationWim $destinationWim -ImageInfo $_ -MountTempDir $MountTempDir 
            $version = (Get-WindowsImage -ImagePath $destinationWim -Name $destinationName).Version
            Write-Host "$destinationName exported at version $version"
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
    [string]$MountTempDir
)
    $exportParams = @{
        "SourceImagePath" = $SourceWim;
        "DestinationImagePath" = $DestinationWim;
        "DestinationName" = $ImageInfo["DestinationName"];
        "CompressionType" = "maximum"
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
    $perImageSteps = 2
    $totalSteps = ($ImageCount * $perImageSteps) + $otherSteps
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    if ($completed) {
        $CurrentOperation = "Done"
    }

    Write-Progress -Id 1 -ParentId 0 -Activity "Updating images" -PercentComplete $percent -Status $CurrentOperation -Completed:$completed
}
