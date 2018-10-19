function Find-ExternalBaseImages {
    [cmdletbinding()]
    param(
        [object[]]$Images,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Registry
    )

    $externalImages = @{}
    Foreach ($image in $Images) {
        if ($image.BaseImages) {
            Foreach ($baseImage in $image.BaseImages) {
                if (-not $externalImages.ContainsKey($baseImage) -And -not $baseImage.StartsWith($Registry, "CurrentCultureIgnoreCase")) {
                    $externalImages.add($baseImage, $baseImage)
                }
            }
        }
    }

    $externalImages.Values
}
