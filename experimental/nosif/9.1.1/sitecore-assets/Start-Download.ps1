[CmdletBinding()]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()] 
    [string]$Path
    ,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()] 
    [string]$Destination
    ,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecoreUsername
    ,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecorePassword
)

function Invoke-Download
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Url
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Destination
        ,
        [Parameter(Mandatory = $false)]
        [int]$RetryCount = 0
        ,
        [Parameter(Mandatory = $false)]
        [int]$MaxRetryCount = 5
        ,
        [Parameter(Mandatory = $false)]
        [object]$Session
    )

    if (Test-Path $Destination) 
    {
        Remove-Item $Destination -Force
    }
    
    try
    {
        Invoke-WebRequest -Uri $Url -OutFile $Destination -WebSession $Session -UseBasicParsing -TimeoutSec 120
    }
    catch
    {
        $exception = $_.Exception

        if ($null -ne $exception)
        {
            $response = $exception.Response

            if ($null -ne $response -and [int]$response.StatusCode -gt 400)
            {
                throw [Exception] "Download failed.", $exception
            }
            
            if ($exception.Message -like "*timed out*" -or $exception.GetType() -eq [System.Threading.Tasks.TaskCanceledException])
            {
                if ($RetryCount -ge $MaxRetryCount)
                {
                    throw [Exception] "Download timed out, will not retry.", $exception
                }
                
                Write-Warning "Retrying ($RetryCount/$MaxRetryCount)..."

                Invoke-Download -Url $Url -Destination $Destination -Session $Session -RetryCount ($RetryCount + 1) -MaxRetryCount $MaxRetryCount
            }

            throw [Exception] "Unknown exception.", $exception
        }
        else
        {
            throw "Unknown error."
        }
    }
}

# Setup
$sitecoreDownloadUrl = "https://dev.sitecore.net"
$sitecoreDownloadSession = $null

# Ensure destination exists
if (!(Test-Path $Destination -PathType "Container"))
{
    New-Item $Destination -ItemType Directory -WhatIf:$false | Out-Null
}

Write-Host ("Downloading files into '{0}'..." -f $Destination)
 
Get-Content -Raw $Path | ConvertFrom-Json -PipelineVariable jo | Get-Member -Type  NoteProperty | ForEach-Object { 
    $fileName = $_.Name
    $filePath = Join-Path $Destination $fileName
    $fileUrl = ($jo.$($_.Name)).url

    # if needed, login to dev.sitecore.net and save session for re-use
    if ($null -eq $sitecoreDownloadSession)
    {
        Write-Host ("Logging in to '{0}' using '{1}'..." -f $sitecoreDownloadUrl, $SitecoreUsername)

        $loginResponse = Invoke-WebRequest ("{0}/api/authorization" -f $sitecoreDownloadUrl) -Method Post -Body @{
            username   = $SitecoreUsername
            password   = $SitecorePassword
            rememberMe = $true
        } -SessionVariable "sitecoreDownloadSession" -Timeout 120 -UseBasicParsing

        if ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200 -or $loginResponse.Content -eq "false")
        {
            throw ("Unable to login to '{0}' with the supplied credentials." -f $sitecoreDownloadUrl)
        }
    }
    
    Write-Host ("Downloading '{0}' from '{1}'..." -f $fileName, $fileUrl)

    Invoke-Download -Url $fileUrl -Destination $filePath -Session $sitecoreDownloadSession
}

Write-Host "Downloads completed."