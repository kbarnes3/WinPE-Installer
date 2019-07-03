Param(
    [string]$Codebase,
    [Parameter(Mandatory=$true)]
    [string]$ImageName,
    [switch]$Compact
)

$ImagePath = "\Images\$($Codebase).swm"
$SplitImageFilePattern = "\Images\$($Codebase)*.swm"

$ScratchDir = "W:\DismScratch"
New-Item -Path $ScratchDir -Type Directory | Out-Null

# Apply the image to the Windows partition
Expand-WindowsImage -ImagePath $ImagePath -SplitImageFilePattern $SplitImageFilePattern -Name $ImageName -ApplyPath W:\ -ScratchDirectory $ScratchDir -Compact:$Compact -ErrorAction Stop
if (-Not (Test-Path W:\Windows\System32\Recovery\winre.wim)) {
    return
}

# Copy the Windows RE Tools to the Recovery partition
New-Item -Path "R:\Recovery\WindowsRE" -Type Directory | Out-Null
& xcopy /h W:\Windows\System32\Recovery\winre.wim R:\Recovery\WindowsRE

# Copy boot files from the Windows partition to the System partition
& bcdboot W:\Windows

# In the System partition, set the location of the WinRE tools
& W:\Windows\System32\reagentc /setreimage /path R:\Recovery\WindowsRE /target W:\Windows

Remove-Item -Recurse -Force $ScratchDir

Set-Location \Scripts\Drivers
Write-Host "Available drivers: "
Get-ChildItem | % { Write-Host ".\$($_.Name)" -ForegroundColor Yellow }

$modelName = (Get-WmiObject Win32_ComputerSystemProduct).Name

Write-Host "`nWindows is installed!"
Write-Host "This computer reports that it is a '" -NoNewline
Write-Host $modelName -ForegroundColor Yellow -NoNewline
Write-Host "'. "
Write-Host "To install additional drivers,"
Write-Host "run the appropriate script listed above. Otherwise,"
Write-Host "run '" -NoNewline
Write-Host "wpeutil shutdown" -ForegroundColor Yellow -NoNewline 
Write-Host "' or '" -NoNewline
Write-Host "wpeutil reboot" -ForegroundColor Yellow -NoNewline
Write-Host "'."
