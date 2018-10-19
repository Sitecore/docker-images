# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Sort-PSDependency.ps1
function Sort-Images {
    [cmdletbinding()]
    param(
        [object[]]$Images
    )

    $order = @{}
    Foreach ($image in $Images) {
        if ($image.BaseImages) {
            if (-not $order.ContainsKey($image.MainTag)) {
                $order.add($image.MainTag, $image.BaseImages)
            }
        }
    }

    if ($order.Keys.Count -gt 0) {
        $imageOrder = Get-TopologicalSort $order
        Sort-ObjectWithCustomList -InputObject $Images -Property MainTag -CustomList $imageOrder
    }
    else {
        $Images
    }
}
