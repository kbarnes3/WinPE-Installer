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
Get-PhysicalDisk | Format-Table @{Name="DiskNumber"; Expression={$_.DeviceId}},
    FriendlyName,
    SerialNumber,
    BusType,
    @{Name="Size"; Expression={
        $size = $_.Size;
        $postfixes = @( "B", "KB", "MB", "GB", "TB", "PB" );
        for ($i=0; $size -ge 1024 -and $i -lt $postfixes.Length; $i++) { $size = $size / 1024; };
        return "" + [System.Math]::Round($size,2) + " " + $postfixes[$i];}}
Write-Host "To partition your disk run:"
Write-Host "    .\RS-Partition-$($FirmwareMode).ps1 -DiskNumber n " -ForegroundColor Yellow -NoNewline 
Write-Host "// For Windows 10 Version 21H1 and Windows Server 2019"
if ($FirmwareMode -eq "BIOS") {
    Write-Host "    .\RS-Partition-BIOS-VHD.ps1 -DiskNumber n -VhdName Filename " -ForegroundColor Yellow -NoNewline 
    Write-Host "// If you know what you are doing"
}
if ($FirmwareMode -eq "UEFI") {
    Write-Host "    .\RS-Partition-UEFI-VHDX.ps1 -DiskNumber n -VhdxName Filename " -ForegroundColor Yellow -NoNewline
    Write-Host "// If you know what you are doing"
}
Write-Host "Where n is the number of the appropriate disk listed above"
Write-Warning "Everything on the selected drive will be erased!"
