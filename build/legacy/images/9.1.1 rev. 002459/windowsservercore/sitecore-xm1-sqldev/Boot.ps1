[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$InstallPath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$DataPath
)

$noDatabases = $null -eq (Get-ChildItem -Path $DataPath -Filter "*.mdf")

if ($noDatabases)
{
    Write-Host "### Sitecore databases not found in '$DataPath', seeding clean databases..."

    Get-ChildItem -Path $InstallPath | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $DataPath
    }
}
else
{
    Write-Host "### Existing Sitecore databases found in '$DataPath'..."
}

Get-ChildItem -Path $DataPath -Filter "*.mdf" | ForEach-Object {
    $databaseName = $_.BaseName.Replace("_Primary", "")
    $mdfPath = $_.FullName
    $ldfPath = $mdfPath.Replace(".mdf", ".ldf")
    $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$databaseName') BEGIN EXEC sp_detach_db [$databaseName] END;CREATE DATABASE [$databaseName] ON (FILENAME = N'$mdfPath'), (FILENAME = N'$ldfPath') FOR ATTACH;"

    Write-Host "### Attaching '$databaseName'..."

    Invoke-Sqlcmd -Query $sqlcmd
}

Write-Host "### Sitecore databases ready!"

& C:\Start.ps1 -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose
