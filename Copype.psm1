function Invoke-Copype
{
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir
)
    # Run copype against a temp directory on C:\ rather than the working dir
    # (which is typically a RAM drive). copype.cmd mounts boot.wim read-only
    # at <dest>\mount to extract bootmgfw.efi. If that mount is interrupted
    # or the working dir is later wiped, DISM can be left with an "Invalid"
    # stale mount entry pointing into the RAM drive. Isolating copype to a
    # stable C:\ path keeps the working dir clean.
    $copypeTempDir = "C:\WinPE_copype_amd64"

    if (Test-Path $copypeTempDir) {
        $staleMount = Join-Path $copypeTempDir "mount"
        if (Test-Path $staleMount) {
            # Best-effort dismount in case a previous run left it mounted.
            & dism /Unmount-Image /MountDir:$staleMount /Discard 2>&1 | Out-Null
        }
        & dism /Cleanup-Mountpoints 2>&1 | Out-Null
        Remove-Item -Recurse -Force $copypeTempDir -ErrorAction Stop | Out-Null
    }

    cmd /c copype amd64 $copypeTempDir | Out-Null

    # Copy everything copype produced except the now-empty (or potentially
    # mount-registered) "mount" subdirectory over to the real working dir.
    & robocopy $copypeTempDir $WinpeWorkingDir /MIR /XD (Join-Path $copypeTempDir "mount") | Out-Null
}
Export-ModuleMember Invoke-Copype
