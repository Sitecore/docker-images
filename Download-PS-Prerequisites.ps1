

[CmdletBinding(SupportsShouldProcess = $true)]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "RegistryPassword")]

param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$InstallSourcePath = (Join-Path $PSScriptRoot "\packages")
    ,
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecoreUsername
    ,
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecorePassword


)

$sitecoreDownloadUrl = "https://dev.sitecore.net"

$packages = @{
    "Sitecore Azure Toolkit 2.4.0-r02514.1001.zip" = "https://dev.sitecore.net/~/media/B627BFA7070B40AD854A0FF08719381D.ashx"
}

$packagesFile = Get-Item -Path (Join-Path $PSScriptRoot ".\sitecore-packages.json")
(
    $packagesFile | Get-Content | ConvertFrom-Json).psobject.properties | Foreach {
    if (($null -ne $_.Value.packageUrl) -and ($null -ne $_.Value.packageName)) {
        $packages[$_.Value.packageName] = $_.Value.packageUrl
    }
}

# download packages from Sitecore download
$packages.GetEnumerator() | ForEach-Object {

    $filePath = Join-Path $InstallSourcePath $_.Key
    $fileUrl = $_.Value

    if (Test-Path $filePath -PathType Leaf) {
        Write-Host ("Required package found: '{0}'" -f $filePath)
    }
    else {
        if ($PSCmdlet.ShouldProcess($fileName)) {
            Write-Host ("Downloading '{0}' to '{1}'..." -f $fileUrl, $filePath)

            if ($fileUrl.StartsWith($sitecoreDownloadUrl)) {
                # Login to dev.sitecore.net and save session for re-use
                if ($null -eq $sitecoreDownloadSession) {
                    Write-Verbose ("Logging in to '{0}'..." -f $sitecoreDownloadUrl)

                    $loginResponse = Invoke-WebRequest "https://dev.sitecore.net/api/authorization" -Method Post -Body @{
                        username   = $SitecoreUsername
                        password   = $SitecorePassword
                        rememberMe = $true
                    } -SessionVariable "sitecoreDownloadSession" -UseBasicParsing

                    if ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200 -or $loginResponse.Content -eq "false") {
                        throw ("Unable to login to '{0}' with the supplied credentials." -f $sitecoreDownloadUrl)
                    }

                    Write-Verbose ("Logged in to '{0}'." -f $sitecoreDownloadUrl)
                }

                # Download package using saved session
                Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -WebSession $sitecoreDownloadSession -UseBasicParsing
            }
            else {
                # Download package
                Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -UseBasicParsing
            }
        }
    }

}

# Install Azure toolkit
Write-Host "Prepare Azure toolkit"

$sat = (Join-Path (Get-Item $PSScriptRoot).FullName "tools\sat")

Write-Host "Sitecore Azure Toolkit directory $sat"

# Ensure Azure SAT destination exists
if (!(Test-Path $sat -PathType "Container")) {
    Write-Host "Create SAT directory $sat"
    New-Item $sat -ItemType Directory -WhatIf:$false | Out-Null
}

# extract Sitecore Azure Toolkit
Get-ChildItem -Path $InstallSourcePath -Filter "*Azure Toolkit*" -Recurse | Select-Object -First 1 | Expand-Archive -DestinationPath $sat -Force

# import Azure toolkit
Write-Host "Import Sitecore Azure Toolkit"
Import-Module (Join-Path $sat "tools\Sitecore.Cloud.Cmdlets.dll")  -Force

# Find modules to transform
$packages.Keys | Where-Object { $_ -notlike "*Azure Toolkit*" } | ForEach-Object {
    $zip = Get-Item (Join-Path "C:\Sitecore\Repository\" "$_")
    Write-Host "Convert to WDP $zip"
    ConvertTo-SCModuleWebDeployPackage -Path $zip -Destination $InstallSourcePath -Force
}

Write-Host "DONE"