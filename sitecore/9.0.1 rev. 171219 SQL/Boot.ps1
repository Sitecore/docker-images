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
    [string]$DatabasePrefix
)

$noData = (Get-ChildItem -Path $DataPath -Filter "*.mdf") -eq $null

# If no databases found in data directory, install from dacpac files
if ($noData)
{
    Write-Host "### Sitecore databases not found, installing..."

    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
    
    $server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
    $server.Properties["DefaultFile"].Value = $DataPath
    $server.Properties["DefaultLog"].Value = $DataPath
    $server.Alter()

    $sqlPackageExePath = Get-Item "C:\Program Files (x86)\Microsoft SQL Server\*\DAC\bin\SqlPackage.exe" | Select-Object -Last 1 -Property FullName -ExpandProperty FullName

    Write-Host "### Using: $sqlPackageExePath"

    Push-Location -Path $InstallPath

    Get-ChildItem -Path $InstallPath -Filter "*.dacpac" | ForEach-Object {
        $databaseName = $_.BaseName.Replace("Sitecore.", "$DatabasePrefix`_").Replace(".Database.Sql", ".ShardMapManager")
        $dacpacPath = ".\{0}" -f $_.Name

        Write-Host "### Installing '$databaseName' from '$dacpacPath'..."

        & $sqlPackageExePath /a:Publish /sf:$dacpacPath /tdn:$databaseName /tsn:$env:COMPUTERNAME /q
    }

    Pop-Location
}
else
{
    # Attach databases
    Write-Host "### Sitecore databases found, attaching..."

    Get-ChildItem -Path $DataPath -Filter "*.mdf" | ForEach-Object {
        $databaseName = $_.BaseName.Replace("_Primary", "")
        $mdfPath = $_.FullName
        $ldfPath = $mdfPath.Replace(".mdf", ".ldf")
        $sqlcmd = "CREATE DATABASE [$databaseName] ON (FILENAME = N'$mdfPath'), (FILENAME = N'$ldfPath') FOR ATTACH;"

        Write-Host "### Attaching '$databaseName'..."

        Invoke-Sqlcmd -Query $sqlcmd
    }
}

Write-Host "### Sitecore databases ready!"

# Call Start.ps1 from the base image https://github.com/Microsoft/mssql-docker/blob/master/windows/mssql-server-windows-developer/dockerfile
& C:\Start.ps1 -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose
