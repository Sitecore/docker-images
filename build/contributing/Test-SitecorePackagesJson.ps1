
$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

$packagesPath = Join-Path $PSScriptRoot "..\sitecore-packages.json"

$content = Get-Content -Raw $packagesPath | ConvertFrom-Json -OutVariable jo | Get-Member -Type  NoteProperty | Sort-Object Name
foreach ($item in $content)
{
    $name = $item.Name
    $url = $jo.$($item.Name).url

    if (!$url)
    {
        Write-Verbose ("[{0}] Doesn't have a URL, skipping..." -f $name)
        continue
    }

    Write-Verbose ("[{0}] Checking '{1}'..." -f $name, $url)
    if ($url -like "*github*")
    {
        Write-Host "Skipping GitHub urls - no support for HEAD"
        continue
    }
    $response = Invoke-WebRequest -Uri $url -UseBasicParsing -Method "HEAD"

    if ($response.StatusCode -ne 200)
    {
        throw ("[{0}] Non sucessfull status code '{1}' on '{2}'." -f $name, $response.StatusCode, $url)
    }

    $contentDispositionHeader = $response.Headers["Content-Disposition"] | Out-String

    if (!$contentDispositionHeader.Contains($name))
    {
        if (-not $name -like "Coveo*")
        {
            throw ("[{0}] The header 'Content-Disposition: {1}' did not match the file name." -f $name, $contentDispositionHeader)
        }
    }
}
