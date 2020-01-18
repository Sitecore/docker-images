function Invoke-PackageRestore
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$Path
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Destination
        ,
        [Parameter(Mandatory = $false)]
        [array]$Tags = (Get-LatestSupportedVersionTags)
        ,
        [Parameter(Mandatory = $false)]
        [array]$AutoGenerateWindowsVersionTags = (Get-SupportedWindowsVersions)
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$DeprecatedTagsBehavior = "Skip"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$ExperimentalTagBehavior = "Skip"
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SitecoreUsername
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SitecorePassword
    )

    # Setup
    $ErrorActionPreference = "STOP"
    $ProgressPreference = "SilentlyContinue"

    $sitecoreDownloadUrl = "https://dev.sitecore.net"
    $destinationPath = $Destination.TrimEnd('\')

    # Load packages
    $packages = Get-Packages

    # Ensure destination exists
    if (!(Test-Path $destinationPath -PathType "Container"))
    {
        New-Item $destinationPath -ItemType Directory -WhatIf:$false | Out-Null
    }

    # Find out which files is needed
    $sitecoreDownloadSession = $null
    $specs = Initialize-BuildSpecifications -Specifications (Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags) -InstallSourcePath $Destination -Tags $Tags -ImplicitTagsBehavior "Include" -DeprecatedTagsBehavior $DeprecatedTagsBehavior -ExperimentalTagBehavior $ExperimentalTagBehavior
    $expected = $specs | Where-Object { $_.Include -and $_.Sources.Length -gt 0 } | Select-Object -ExpandProperty Sources -Unique

    # Check or download needed files
    $expected | ForEach-Object {
        $filePath = $_

        if (Test-Path $filePath -PathType Leaf)
        {
            $requiredFile = Get-Item -Path $filePath

            if ($requiredFile.Length -gt 0)
            {
                Write-Host ("Required package found: '{0}'" -f $filePath)

                return
            }

            Remove-Item -Path $filePath -Force
        }

        $fileName = $filePath.Replace(("{0}\" -f $destinationPath), "")
        $package = $packages.$fileName

        if ($null -eq $package)
        {
            throw ("Required package '{0}' was not defined in 'sitecore-packages.json' so it can't be downloaded, please add the package ' {1}' manually." -f $fileName, $filePath)
        }

        $fileUrl = $package.url

        if ([string]::IsNullOrEmpty($fileUrl))
        {
            Write-Warning ("Required package '{0}' not available for download because the url property is empty, please copy '{0}' into '{1}' manually." -f $fileName, $Destination)
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

    Write-Host "Restore completed."
}