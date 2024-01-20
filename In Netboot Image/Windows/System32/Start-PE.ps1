$password = ConvertTo-SecureString "**PASSWORD**" -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ("**USERNAME**", $password)
$TargetDriveLetter = "I"
New-PSDrive -Name $TargetDriveLetter -PSProvider "FileSystem" -Root "**SHARE**" -Credential $creds -Persist

$MainScript = "$($TargetDriveLetter):\Scripts\Start.ps1"
. $MainScript