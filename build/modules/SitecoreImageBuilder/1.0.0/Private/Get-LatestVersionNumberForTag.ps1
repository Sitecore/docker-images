function Get-LatestVersionNumberForTag
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [array]$Specs
        ,
        [Parameter(Mandatory = $true)]
        [string]$Tag
    )

    # find all versions for the tag
    $versions = $Specs | Where-Object { $_.Tag -like $Tag } | Select-Object -ExpandProperty Tag

    $versions = $versions | ForEach-Object {
        $_.Substring($_.IndexOf(':') + 1)
    }

    $versions = $versions | ForEach-Object {
        $_.Substring(0, $_.IndexOf('-'))
    }

    $versions = $versions | Sort-Object -Unique -Descending | Sort-Object

    # pick latest version for the tag
    Write-Output ($versions | Select-Object -First 1)
}