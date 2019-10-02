[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })] 
    [string]$InstallPath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })] 
    [string]$DataPath
)

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$server.Properties["DefaultFile"].Value = $InstallPath
$server.Properties["DefaultLog"].Value = $InstallPath
$server.Alter()

$sqlPackageExePath =Get-Item "C:\Program Files\Microsoft SQL Server\*\DAC\bin\SqlPackage.exe" | Select-Object -Last 1 -Property FullName -ExpandProperty FullName

# attach
Get-ChildItem -Path $InstallPath -Filter "*.mdf" | ForEach-Object {
    $databaseName = $_.BaseName.Replace("_Primary", "")
    $mdfPath = $_.FullName
    $ldfPath = $mdfPath.Replace(".mdf", ".ldf")
    $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$databaseName') BEGIN EXEC sp_detach_db [$databaseName] END;CREATE DATABASE [$databaseName] ON (FILENAME = N'$mdfPath'), (FILENAME = N'$ldfPath') FOR ATTACH;"

    Write-Host "### Attaching '$databaseName'..."

    Invoke-Sqlcmd -Query $sqlcmd
}

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$server.Properties["DefaultFile"].Value = $DataPath
$server.Properties["DefaultLog"].Value = $DataPath
$server.Alter()