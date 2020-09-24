[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$Roles,
    [Parameter(Mandatory=$true)]
    [string]$SourceFolder,
    [Parameter(Mandatory=$true)]
    [string]$DestinationFolder
)

New-Item -Path $DestinationFolder -ItemType Directory -Force

$Roles -Split ',' | ForEach-Object {
    $role = $_

    $sourceRoleFolder = Join-Path -Path $SourceFolder -ChildPath $role
    $extractFolder = Join-Path -Path $sourceRoleFolder -ChildPath "temp"
    $extractWebsiteFolder = Join-Path -Path $extractFolder -ChildPath "Content/Website"
    $destinationRoleContentFolder = Join-Path -Path $DestinationFolder -ChildPath "$role/content"

    $wdp = Get-ChildItem -Path $sourceRoleFolder -Filter *.scwdp.zip
    Expand-Archive -Path $wdp.FullName -DestinationPath $extractFolder

    New-Item -Path $destinationRoleContentFolder -ItemType Directory -Force
    Move-Item -Path "$extractWebsiteFolder/*" -Destination $destinationRoleContentFolder -Force -ErrorAction SilentlyContinue

    $dbs = Get-ChildItem -Path $extractFolder -Filter *.dacpac

    if (($dbs | Measure-Object).Count -gt 0) {
        $destinationDBFolder = Join-Path -Path $DestinationFolder -ChildPath "db"

        if (!(Test-Path -Path $destinationDBFolder -PathType Container)) {
            New-Item -Path $destinationDBFolder -ItemType Directory -Force
        }

        $dbs | ForEach-Object {
            $db = $_

            $destinationDBPath = Join-Path -Path $destinationDBFolder -ChildPath "Sitecore.$($db.Name)"
            Move-Item -Path $_.FullName -Destination $destinationDBPath
        }
    }

    $sourceSolrSchemaPath = Join-Path -Path $destinationRoleContentFolder -ChildPath "App_Data/SolrSchema/managed-schema"
    if (Test-Path -Path $sourceSolrSchemaPath -PathType Leaf) {
        $solrSchema = Get-Item -Path $sourceSolrSchemaPath
        $destinationSolrSchemaFolder = Join-Path -Path $DestinationFolder -ChildPath "solr"

        if (!(Test-Path -Path $destinationSolrSchemaFolder -PathType Container)) {
            New-Item -Path $destinationSolrSchemaFolder -ItemType Directory -Force
        }

        Move-Item -Path $solrSchema.FullName -Destination $destinationSolrSchemaFolder
    }
}