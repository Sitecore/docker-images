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

# detach DB
Get-ChildItem -Path $InstallPath -Filter "*.mdf" | ForEach-Object {
    $databaseName = $_.BaseName.Replace("_Primary", "")

	if($databaseName -eq 'sc_Core'){
		Invoke-Sqlcmd -Query "ALTER DATABASE $databaseName SET SINGLE_USER WITH ROLLBACK AFTER 10 SECONDS"
		Start-Sleep -s 10
	}
	Write-Host "### Detach: $databaseName"
    Invoke-Sqlcmd -Query "EXEC MASTER.dbo.sp_detach_db @dbname = N'$databaseName', @keepfulltextindexfile = N'false'"
}

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$server.Properties["DefaultFile"].Value = $DataPath
$server.Properties["DefaultLog"].Value = $DataPath
$server.Alter()