Push-Location $PSScriptRoot
wpeutil UpdateBootInfo

$FirmwareType = (Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlset\Control -Name PEFirmwareType).PEFirmwareType 
if ($FirmwareType -eq 1) {
    $FirmwareMode = "BIOS"
}
elseif ($FirmwareType -eq 2) {
    $FirmwareMode = "UEFI"
}

Write-Host "The PC is booted in $FirmwareMode mode"

Set-Location "$($FirmwareMode)\Partition"
diskpart /s \DiskPart\List-Disk.txt
Write-Host "To partition your disk run:"
Write-Host "    RS-Partition-$($FirmwareMode).bat n // For Windows 10 Version 1703 and Windows Server 2016"
Write-Host "Where n is the number of the appropriate disk listed above"
Write-Host "WARNING: Everything on the selected drive will be erased!"
