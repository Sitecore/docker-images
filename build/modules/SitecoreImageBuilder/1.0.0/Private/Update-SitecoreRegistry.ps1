function  Update-SitecoreRegistry
{
    [CmdletBinding()]
    param (
        [System.Collections.ArrayList]
        $specs,
        [string]
        $SitecoreRegistry
    )
    # using a temporary file to avoid the nested looping through objects
    $tempFile = Join-Path $PWD "temp-tags.json"
    $json = $specs | ConvertTo-Json | Set-Content $tempFile -Force
    $json = $((Get-Content $tempFile -Raw).Replace("`${sitecore_registry}", "$SitecoreRegistry")) | ConvertFrom-Json
    Remove-Item $tempFile -Force
    return $json
}
