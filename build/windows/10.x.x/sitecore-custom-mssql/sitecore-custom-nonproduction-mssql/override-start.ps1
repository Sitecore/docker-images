[CmdletBinding()]
param (
    [string] $SqlServiceAccount,
    [string] $DataPath
)

if ($env:ACCEPT_EULA -ne "Y" -And $env:ACCEPT_EULA -ne "y")
{
    Write-Verbose "ERROR: You must accept the End User License Agreement before this container can start."
    Write-Verbose "Set the environment variable ACCEPT_EULA to 'Y' if you accept the agreement."

    exit 1
}

$permission = (Get-Acl $DataPath).Access |  `
    Where-Object { $_.IdentityReference -match $SqlServiceAccount } | `
    Select-Object IdentityReference, FileSystemRights

if (-not $permission)
{
    Write-Verbose "Set permission 'Access' on $DataPath - $SqlServiceAccount"
    $aclDataPath = (Get-Acl $DataPath)
    $fsar = New-Object System.Security.AccessControl.FileSystemAccessRule($SqlServiceAccount.Replace("\\", "\"), "FullControl", "Allow")
    $aclDataPath.SetAccessRule($fsar)
    $aclDataPath | Set-Acl $DataPath
}

# start the service
Write-Verbose "Starting SQL Server"

start-service MSSQLSERVER

Write-Verbose "Started SQL Server."

# change default data path
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null

Write-Verbose "set data directory $DataPath"

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$server.Properties["DefaultFile"].Value = $DataPath
$server.Properties["DefaultLog"].Value = $DataPath
$server.Alter()

# restart the service
Write-Verbose "restart SQL Server, and apply change"
restart-service MSSQLSERVER
Write-Verbose "SQL Server restarted"

.\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose