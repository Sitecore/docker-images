[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$InstallPath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$DataPath,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()] 
    [string]$DatabasePrefix,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()] 
    [string]$CommerceDatabasePrefix
)

# Make sure SQL server is running
Start-Service MSSQLSERVER;
(Get-Service MSSQLSERVER).WaitForStatus('Running');

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$server.Properties["DefaultFile"].Value = $InstallPath
$server.Properties["DefaultLog"].Value = $InstallPath
$server.Alter()

$sqlPackageExePath = Get-Item "C:\Program Files\Microsoft SQL Server\*\DAC\bin\SqlPackage.exe" | Select-Object -Last 1 -ExpandProperty FullName

Write-Host "Using: $sqlPackageExePath"

Push-Location -Path $InstallPath

# do Sitecore Commerce Global DB
Get-ChildItem -Path $InstallPath -Include "Sitecore.Commerce.Engine.Global.DB.dacpac" -Recurse | ForEach-Object {
    $dacpacPath = $_.FullName
    $databaseName = "${CommerceDatabasePrefix}Global"

    # Install
    & $sqlPackageExePath /a:Publish /sf:$dacpacPath /tdn:$databaseName /tsn:$env:COMPUTERNAME /q
}

# do Sitecore Commerce SharedEnvironments DB
Get-ChildItem -Path $InstallPath -Include "Sitecore.Commerce.Engine.Shared.DB.dacpac" -Recurse | ForEach-Object {
    $dacpacPath = $_.FullName
    $databaseName = "${CommerceDatabasePrefix}SharedEnvironments"

    # Install
    & $sqlPackageExePath /a:Publish /sf:$dacpacPath /tdn:$databaseName /tsn:$env:COMPUTERNAME /q
}

# do modules
$TextInfo = (Get-Culture).TextInfo
Get-ChildItem -Path $InstallPath -Include "core.dacpac", "master.dacpac" -Recurse | ForEach-Object {
    $dacpacPath = $_.FullName
    $databaseName = "$DatabasePrefix" + $TextInfo.ToTitleCase($_.BaseName)

    # Install
    & $sqlPackageExePath /a:Publish /sf:$dacpacPath /tdn:$databaseName /tsn:$env:COMPUTERNAME /q
}

Pop-Location

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$server.Properties["DefaultFile"].Value = $DataPath
$server.Properties["DefaultLog"].Value = $DataPath
$server.Alter()