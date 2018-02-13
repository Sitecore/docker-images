[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$SolrPath,
    [Parameter(Mandatory = $true)]
    [string]$SolrPort,
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$InstallPath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$DataPath
)

$noData = ((Get-ChildItem -Path $DataPath -Filter "sc_*") -eq $null -or (Get-ChildItem -Path $DataPath -Filter "solr.xml") -eq $null)

if ($noData)
{
    Write-Host "### No Sitecore solr cores found in '$DataPath', seeding clean cores..."

    Get-ChildItem -Path $InstallPath | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $DataPath -Recurse
    }
}
else
{
    Write-Host "### Existing Sitecore solr cores found in '$DataPath'..."
}

Write-Host "### Starting solr..."

& (Join-Path $SolrPath "/bin/solr.cmd") start -port $SolrPort -f
