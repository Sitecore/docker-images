$packagesPath = Join-Path $PSScriptRoot "..\sitecore-packages.json"
$sorted = New-Object PSCustomObject

Get-Content -Raw $packagesPath | ConvertFrom-Json -PipelineVariable jo | Get-Member -Type  NoteProperty | Sort-Object Name | ForEach-Object { 
    Add-Member -InputObject $sorted -Type NoteProperty -Name $_.Name -Value $jo.$($_.Name)
}

$newJson = $sorted | ConvertTo-Json -Depth 10

[IO.File]::WriteAllLines($packagesPath, $newJson)