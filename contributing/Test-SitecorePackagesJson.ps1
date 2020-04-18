[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecoreUsername
    ,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecorePassword
)

$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

$packagesPath = Join-Path $PSScriptRoot "..\sitecore-packages.json"
$downloadUrl = "https://dev.sitecore.net"
$downloadSession = $null

Get-Content -Raw $packagesPath | ConvertFrom-Json -PipelineVariable jo | Get-Member -Type  NoteProperty | Sort-Object Name | ForEach-Object {
    $name = $_.Name
    $url = $jo.$($_.Name).url

    if ($null -eq $downloadSession)
    {
        Write-Verbose ("Logging in to '{0}'..." -f $downloadUrl)

        $loginResponse = Invoke-WebRequest "https://dev.sitecore.net/api/authorization" -Method Post -Body @{
            username   = $SitecoreUsername
            password   = $SitecorePassword
            rememberMe = $true
        } -SessionVariable "downloadSession" -UseBasicParsing

        if ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200 -or $loginResponse.Content -eq "false")
        {
            throw ("Unable to login to '{0}' with the supplied credentials." -f $downloadUrl)
        }

        Write-Verbose ("Logged in to '{0}'." -f $downloadUrl)
    }

    Write-Verbose ("[{0}] Checking '{1}'..." -f $name, $url)

    $response = Invoke-WebRequest -Uri $url -WebSession $downloadSession -UseBasicParsing -Method "HEAD"

    if ($response.StatusCode -ne 200)
    {
        throw ("[{0}] Non sucessfull status code '{1}' on '{2}'." -f $name, $response.StatusCode, $url)
    }

    $contentDispositionHeader = $response.Headers["Content-Disposition"] | Out-String

    if (!$contentDispositionHeader.Contains($name))
    {
        throw ("[{0}] The header 'Content-Disposition: {1}' did not match the file name." -f $name, $contentDispositionHeader)
    }
}
