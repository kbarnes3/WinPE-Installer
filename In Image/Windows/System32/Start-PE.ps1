# Look up the bootable drive by finding whatever drive has a well known GUID at its root
(Get-Volume).DriveLetter | % { 
    $PotentialFile = "$($_):\45b3d435-9aa6-4800-909e-b51f645ed000"
    if (Test-Path $PotentialFile) { 
        $TargetDriveLetter = $_
    }
}

$MainScript = "$($_):\Scripts\Start.bat"
& $MainScript
