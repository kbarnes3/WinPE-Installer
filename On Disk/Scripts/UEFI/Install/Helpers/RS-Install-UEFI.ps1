Param(
    [ValidateSet('RS1', 'RS2')]
    [string]$Codebase,
    [Parameter(Mandatory=$true)]
    [string]$ImageName,
    [switch]$Compact
)

if ($Codebase -eq "RS1") {
    $ImagePath = "\Images\RS1.swm"
    $SplitImageFilePattern = "\Images\RS1*.swm"
}
elseif ($Codebase -eq "RS2") {
    $ImagePath = "\Images\RS2.swm"
    $SplitImageFilePattern = "\Images\RS2*.swm"
}

$ScratchDir = "W:\DismScratch"
New-Item -Path $ScratchDir -Type Directory | Out-Null

# Apply the image to the Windows partition
Expand-WindowsImage -ImagePath $ImagePath -SplitImageFilePattern $SplitImageFilePattern -Name $ImageName -ApplyPath W:\ -ScratchDirectory $ScratchDir -Compact:$Compact

# Copy the Windows RE Tools to the Recovery partition
New-Item -Path "R:\Recovery\WindowsRE" -Type Directory | Out-Null
& xcopy /h W:\Windows\System32\Recovery\winre.wim R:\Recovery\WindowsRE

# Copy boot files from the Windows partition to the System partition
& bcdboot W:\Windows

# In the System partition, set the location of the WinRE tools
& W:\Windows\System32\reagentc /setreimage /path R:\Recovery\WindowsRE /target W:\Windows

Remove-Item -Recurse -Force $ScratchDir

Push-Location \Scripts\Drivers
dir

Write-Host "Windows is installed! To install additional drivers,"
Write-Host "run the appropriate script listed above. Otherwise,"
Write-Host "run 'wpeutil shutdown' or 'wpeutil reboot'."
