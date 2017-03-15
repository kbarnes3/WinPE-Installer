function New-WinPEInstallMedia
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$ReuseSourcePath
)
    Confirm-Environment -ErrorAction Stop | Out-Null

    $env:Path += ";C:\Program Files\7-Zip\"

    if ($ReuseSourcePath) {
        Write-Host "Reusing large items from $ReuseSourcePath"
    }
}
Export-ModuleMember New-WinPEInstallMedia
