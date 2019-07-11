[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })] 
    [string]$InstallPath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })] 
    [string]$DataPath,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()] 
    [string]$DatabasePrefix
)

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$server.Properties["DefaultFile"].Value = $InstallPath
$server.Properties["DefaultLog"].Value = $InstallPath
$server.Alter()

$sqlPackageExePath = Get-Item "C:\Program Files\Microsoft SQL Server\*\DAC\bin\SqlPackage.exe" | Select-Object -Last 1 -Property FullName -ExpandProperty FullName

# attach
Get-ChildItem -Path $InstallPath -Filter "*.mdf" | ForEach-Object {
    $databaseName = $_.BaseName.Replace("_Primary", "")
    $mdfPath = $_.FullName
    $ldfPath = $mdfPath.Replace(".mdf", ".ldf")
    $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$databaseName') BEGIN EXEC sp_detach_db [$databaseName] END;CREATE DATABASE [$databaseName] ON (FILENAME = N'$mdfPath'), (FILENAME = N'$ldfPath') FOR ATTACH;"

    Write-Host "### Attaching '$databaseName'..."

    Invoke-Sqlcmd -Query $sqlcmd
}

# do modules
$TextInfo = (Get-Culture).TextInfo
Get-ChildItem -Path $InstallPath -Include "core.dacpac", "master.dacpac" -Recurse | ForEach-Object { 

    $dacpacPath = $_.FullName
    $databaseName = "$DatabasePrefix`_" + $TextInfo.ToTitleCase($_.BaseName)

    # Install
    & $sqlPackageExePath /a:Publish /sf:$dacpacPath /tdn:$databaseName /tsn:$env:COMPUTERNAME /q

    # HOTFIX: Replace invalid seperation of list field values
    Write-Host "### HOTFIXING '$databaseName'..."

    $sqlcmd = "UPDATE [$databaseName].[dbo].[SharedFields] SET [Value] = REPLACE( [Value], ('}' + CHAR(13) + CHAR(10) +'{'), '}|{') WHERE [Value] LIKE ('%}' + CHAR(13) + CHAR(10) +'{%')"
    $sqlcmd += " UPDATE [$databaseName].[dbo].[UnversionedFields] SET [Value] = REPLACE( [Value], ('}' + CHAR(13) + CHAR(10) +'{'), '}|{') WHERE [Value] LIKE ('%}' + CHAR(13) + CHAR(10) +'{%')"
    $sqlcmd += " UPDATE [$databaseName].[dbo].[VersionedFields] SET [Value] = REPLACE( [Value], ('}' + CHAR(13) + CHAR(10) +'{'), '}|{') WHERE [Value] LIKE ('%}' + CHAR(13) + CHAR(10) +'{%')"

    Invoke-Sqlcmd -Query $sqlcmd
} 

# detach DB
Get-ChildItem -Path $InstallPath -Filter "*.mdf" | ForEach-Object {
    $databaseName = $_.BaseName.Replace("_Primary", "")

    Write-Host "### Detaching '$databaseName'..."

    Invoke-Sqlcmd -Query "EXEC MASTER.dbo.sp_detach_db @dbname = N'$databaseName', @keepfulltextindexfile = N'false'"
}

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$server.Properties["DefaultFile"].Value = $DataPath
$server.Properties["DefaultLog"].Value = $DataPath
$server.Alter()