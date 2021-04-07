

[CmdletBinding(SupportsShouldProcess = $true)]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "RegistryPassword")]

param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$InstallSourcePath = (Join-Path $PSScriptRoot "\packages"),
    [Parameter(Mandatory = $true)]
    [string]$SitecoreVersion

)
$preference = $ProgressPreference
$ProgressPreference = "SilentlyContinue"

$packages = @{
    "Sitecore Azure Toolkit 2.5.1-r02522.1082.zip" = "https://sitecoredev.azureedge.net/~/media/AD7EFDD038704CED855039DA8EAF5856.ashx?date=20201214T083612"
}

$packages += $( if ($SitecoreVersion -eq "9.3.0")
    {
        @{
            "Sitecore Publishing Module 9.3.0.0 rev. r00546.2197.zip" = "https://sitecoredev.azureedge.net/~/media/417C43AC4F334C4085D18925367FE79A.ashx?date=20191125T151435"
        }
    }
    elseif ($SitecoreVersion -eq "10.0.0")
    {
        @{
            "Sitecore Publishing Module 10.0.0.0 rev. r00568.2697.zip"                                        = "https://sitecoredev.azureedge.net/~/media/A06BC5BBBCA84F2F90AC08CB456A3801.ashx?date=20200729T135935"
            "Data Exchange Framework 5.0.0 rev. 01466.zip"                                                    = "https://sitecoredev.azureedge.net/~/media/BD89F623F3134F2186E12EE76B856A28.ashx?date=20200817T121005"
            "Sitecore Connect for Salesforce Marketing Cloud - Behavioral Data Exchange 5.0.0 rev. 00294.zip" = "https://sitecoredev.azureedge.net/~/media/B63D767DD031462D9BECC39C0F19CCA6.ashx?date=20200817T125946"
            "Sitecore Connect for Salesforce Marketing Cloud - Content Exchange 5.0.0 rev. 00162.zip"         = "https://sitecoredev.azureedge.net/~/media/F6D8B71478FD4A26A9807ABB0E83DAA5.ashx?date=20200817T133632"
            "Sitecore Connect for Salesforce CRM 5.0.0 rev. 01431.zip"                                        = "https://sitecoredev.azureedge.net/~/media/674BCDC0ED504EF5BD741757ADE657A2.ashx?date=20200817T140139"
            "Sitecore Connect for Microsoft Dynamics 365 for Sales 5.0.0 rev. 01439.zip"                      = "https://sitecoredev.azureedge.net/~/media/FCED12D64FF74CA88FB2C8A0C92D7CF2.ashx?date=20200817T124210"
            "Sitecore Connect for CMP XP for 10.0 v. 3.0.0 rev. 00134.zip"                                    = "https://sitecoredev.azureedge.net/~/media/8443DB808C834186B40D66D58499355B.ashx?date=20200916T110356"
            "Sitecore Connect for CMP XM for 10.0 v. 3.0.0 rev. 00134.zip"                                    = "https://sitecoredev.azureedge.net/~/media/36489D794FA5489CBBB78653F03F81A3.ashx?date=20200916T110356"
            "Sitecore Connect for Sitecore DAM-2.0.0.zip"                                                     = "https://sitecoredev.azureedge.net/~/media/7F118478CF78478087A1DB3EBDF9FBFE.ashx?date=20190626T140600"
        }
    }
    elseif ($SitecoreVersion -eq "10.0.1")
    {
        @{
            "Sitecore Publishing Module 10.0.0.0 rev. r00568.2697.zip"                                        = "https://sitecoredev.azureedge.net/~/media/A06BC5BBBCA84F2F90AC08CB456A3801.ashx?date=20200729T135935"
            "Data Exchange Framework 5.0.0 rev. 01466.zip"                                                    = "https://sitecoredev.azureedge.net/~/media/BD89F623F3134F2186E12EE76B856A28.ashx?date=20200817T121005"
            "Sitecore Connect for Salesforce Marketing Cloud - Behavioral Data Exchange 5.0.0 rev. 00294.zip" = "https://sitecoredev.azureedge.net/~/media/B63D767DD031462D9BECC39C0F19CCA6.ashx?date=20200817T125946"
            "Sitecore Connect for Salesforce Marketing Cloud - Content Exchange 5.0.0 rev. 00162.zip"         = "https://sitecoredev.azureedge.net/~/media/F6D8B71478FD4A26A9807ABB0E83DAA5.ashx?date=20200817T133632"
            "Sitecore Connect for Salesforce CRM 5.0.0 rev. 01431.zip"                                        = "https://sitecoredev.azureedge.net/~/media/674BCDC0ED504EF5BD741757ADE657A2.ashx?date=20200817T140139"
            "Sitecore Connect for Microsoft Dynamics 365 for Sales 5.0.0 rev. 01439.zip"                      = "https://sitecoredev.azureedge.net/~/media/FCED12D64FF74CA88FB2C8A0C92D7CF2.ashx?date=20200817T124210"
            "Sitecore Connect for CMP XP for 10.0 v. 3.0.0 rev. 00134.zip"                                    = "https://sitecoredev.azureedge.net/~/media/8443DB808C834186B40D66D58499355B.ashx?date=20200916T110356"
            "Sitecore Connect for CMP XM for 10.0 v. 3.0.0 rev. 00134.zip"                                    = "https://sitecoredev.azureedge.net/~/media/36489D794FA5489CBBB78653F03F81A3.ashx?date=20200916T110356"
            "Sitecore Connect for Sitecore DAM-2.0.0.zip"                                                     = "https://sitecoredev.azureedge.net/~/media/7F118478CF78478087A1DB3EBDF9FBFE.ashx?date=20190626T140600"
            "Coveo for Sitecore 10.0 5.0.858.1.zip"                                                           = "https://static.cloud.coveo.com/coveoforsitecore/packages/v5.0.858.1/Coveo%20for%20Sitecore%2010.0%205.0.858.1.zip"
            "Coveo for Sitecore SXA 10.0 5.0.858.1.zip"                                                       = "https://static.cloud.coveo.com/coveoforsitecore/packages/v5.0.858.1/Coveo%20for%20Sitecore%20SXA%2010.0%205.0.858.1.zip"
            "Sitecore Horizon for Azure 10.0.1.zip"                                                           = "https://sitecoredev.azureedge.net/~/media/B1E32BBAEA0B4BCA941628A1F9C348AD.ashx?date=20201214T083840"
        }
    }
    else {
        @{}
    }
)
if ($packages.count -eq 1)
{
    # Only Sitecore Azure Toolkit was in the packages list, which means we don't have any packages to download.
    Exit 0
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

            # Download package
            Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -UseBasicParsing
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

    if ($fileName -notlike "*Azure Toolkit*")
    {
        $filePath = Join-Path $Destination $fileName
        $expectedScwdpFilePath = $filePath -replace ".zip", ".scwdp.zip"

        if (Test-Path $expectedScwdpFilePath -PathType Leaf)
        {
            Write-Host ("Required WDP found: '{0}'" -f $expectedScwdpFilePath)
        }
        else
        {
            if ($PSCmdlet.ShouldProcess($filePath))
            {


                if (Test-Path $filePath -PathType Leaf)
                {
                    if ($filePath -like '*Horizon*')
                    {
                        Write-Host "Extracting $filePath"
                        #extract list entries for dir myzipdir/c/ into myzipdir.zip
                        $zip = [IO.Compression.ZipFile]::OpenRead($filePath)
                        $entries = $zip.Entries | Where-Object { $_.FullName -like 'wdp*' }

                        #extraction
                        $entries | ForEach-Object {
                            if (-not (Test-path (Join-Path $InstallSourcePath $_.Name)))
                            {
                                [IO.Compression.ZipFileExtensions]::ExtractToFile( $_, $(Join-Path $InstallSourcePath $_.Name))
                            }
                        }

                        #free object
                        $zip.Dispose()
                    }
                    else
                    {
                        Write-Host "Convert to WDP $filePath"
                        ConvertTo-SCModuleWebDeployPackage -Path $filePath -Destination $Destination -Force
                    }
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