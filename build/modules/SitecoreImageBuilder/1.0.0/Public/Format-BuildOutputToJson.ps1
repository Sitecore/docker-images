function Format-BuildOutputToJson
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string[]] $Tags
    )

    $foundTags = @{}

    foreach ($tag in $Tags)
    {
        $result = ($tag.Split(":")) # split the tag from the image name
        if (-not $foundTags.ContainsKey($result[0]))
        {
            $foundTags.Add($result[0], [System.Collections.ArrayList]@($result[1]))
        }
        else
        {
            $foundTags[$result[0]] += $result[1]
        }
    }
    $output = [PSCustomObject]$foundTags
    return $output | ConvertTo-Json -Depth 3
}