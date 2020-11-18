

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
$preference = $ProgressPreference
$ProgressPreference = "SilentlyContinue"

$sitecoreDownloadUrl = "https://dev.sitecore.net"

$packages = @{"Sitecore Azure Toolkit 2.5.0-r02519.1061.zip"                                          = "https://dev.sitecore.net/~/media/0548382E0792436AB067676FD4D66A40.ashx"
    "Sitecore Publishing Module 9.3.0.0 rev. r00546.2197.zip"                                         = "https://dev.sitecore.net/~/media/417C43AC4F334C4085D18925367FE79A.ashx"
    "Sitecore Publishing Module 10.0.0.0 rev. r00568.2697.zip"                                        = "https://dev.sitecore.net/~/media/A06BC5BBBCA84F2F90AC08CB456A3801.ashx"
    "Data Exchange Framework 5.0.0 rev. 01466.zip"                                                    = "https://dev.sitecore.net/~/media/BD89F623F3134F2186E12EE76B856A28.ashx"
    "Sitecore Connect for Salesforce Marketing Cloud - Behavioral Data Exchange 5.0.0 rev. 00294.zip" = "https://dev.sitecore.net/~/media/B63D767DD031462D9BECC39C0F19CCA6.ashx"
    "Sitecore Connect for Salesforce Marketing Cloud - Content Exchange 5.0.0 rev. 00162.zip"         = "https://dev.sitecore.net/~/media/F6D8B71478FD4A26A9807ABB0E83DAA5.ashx"
    "Sitecore Connect for Salesforce CRM 5.0.0 rev. 01431.zip"                                        = "https://dev.sitecore.net/~/media/674BCDC0ED504EF5BD741757ADE657A2.ashx"
    "Sitecore Connect for Microsoft Dynamics 365 for Sales 5.0.0 rev. 01439.zip"                      = "https://dev.sitecore.net/~/media/FCED12D64FF74CA88FB2C8A0C92D7CF2.ashx"
    "Sitecore Connect for CMP XP for 10.0 v. 3.0.0 rev. 00134.zip"                                    = "https://dev.sitecore.net/~/media/8443DB808C834186B40D66D58499355B.ashx"
    "Sitecore Connect for CMP XM for 10.0 v. 3.0.0 rev. 00134.zip"                                    = "https://dev.sitecore.net/~/media/36489D794FA5489CBBB78653F03F81A3.ashx"
    "Sitecore Connect for Sitecore DAM-2.0.0.zip"                                                     = "https://dev.sitecore.net/~/media/7F118478CF78478087A1DB3EBDF9FBFE.ashx"
    "Coveo for Sitecore SXA 10.0 5.0.822.2.zip"                                                       = "https://static.cloud.coveo.com/coveoforsitecore/packages/v5.0.822.2/Coveo%20for%20Sitecore%20SXA%2010.0%205.0.822.2.zip"
}

# download packages from Sitecore
$packages.GetEnumerator() | ForEach-Object {

    $filePath = Join-Path $InstallSourcePath $_.Key
    $fileUrl = $_.Value

    if (Test-Path $filePath -PathType Leaf)
    {
        Write-Host ("Required package found: '{0}'" -f $filePath)
    }
    else
    {
        if ($PSCmdlet.ShouldProcess($fileName))
        {
            Write-Host ("Downloading '{0}' to '{1}'..." -f $fileUrl, $filePath)

            if ($fileUrl.StartsWith($sitecoreDownloadUrl))
            {
                # Login to dev.sitecore.net and save session for re-use
                if ($null -eq $sitecoreDownloadSession)
                {
                    Write-Verbose ("Logging in to '{0}'..." -f $sitecoreDownloadUrl)

                    $loginResponse = Invoke-WebRequest "https://dev.sitecore.net/api/authorization" -Method Post -Body @{
                        username   = $SitecoreUsername
                        password   = $SitecorePassword
                        rememberMe = $true
                    } -SessionVariable "sitecoreDownloadSession" -UseBasicParsing

                    if ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200 -or $loginResponse.Content -eq "false")
                    {
                        throw ("Unable to login to '{0}' with the supplied credentials." -f $sitecoreDownloadUrl)
                    }

                    Write-Verbose ("Logged in to '{0}'." -f $sitecoreDownloadUrl)
                }

                # Download package using saved session
                Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -WebSession $sitecoreDownloadSession -UseBasicParsing
            }
            else
            {
                # Download package
                Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -UseBasicParsing
            }
        }
    }

}

$Destination = $InstallSourcePath

# Install Azure toolkit
Write-Host "Prepare Azure toolkit"

$sat = (Join-Path (Get-Item $PSScriptRoot).FullName "tools\sat")

Write-Host "Sitecore Azure Toolkit directory $sat"

# Ensure Azure SAT destination exists
if (!(Test-Path $sat -PathType "Container"))
{
    Write-Host "Create SAT directory $sat"
    New-Item $sat -ItemType Directory -WhatIf:$false | Out-Null
}

if (!(Test-Path (Join-Path $sat "tools\Sitecore.Cloud.Cmdlets.dll") -PathType Leaf))
 {
    # extract Sitecore Azure Toolkit
    Get-ChildItem -Path $Destination -Filter "*Azure Toolkit*" -Recurse | Select-Object -First 1 | Expand-Archive -DestinationPath $sat -Force
}
# import Azure toolkit
Write-Host "Import Sitecore Azure Toolkit"
Import-Module (Join-Path $sat "tools\Sitecore.Cloud.Cmdlets.dll")  -Force

# Convert packages
$packages.GetEnumerator() | ForEach-Object {
    $fileName = $_.Key

    if ($fileName -notlike "*Azure Toolkit*") {
        $filePath = Join-Path $Destination $fileName
        $expectedScwdpFilePath = $filePath -replace ".zip",".scwdp.zip"

        if (Test-Path $expectedScwdpFilePath -PathType Leaf)
        {
            Write-Host ("Required WDP found: '{0}'" -f $expectedScwdpFilePath)
        }
        else {
            if ($PSCmdlet.ShouldProcess($filePath)) {
                Write-Host "Convert to WDP $filePath"

                if (Test-Path $filePath -PathType Leaf)
                {
                    ConvertTo-SCModuleWebDeployPackage -Path $filePath -Destination $Destination -Force
                }
                else
                {
                    Throw "Cannot find file: $filePath"
                }
            }
        }
    }
}

$ProgressPreference = $preference
Write-Host "DONE"