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
        [array]$Tags
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
    )

    # Setup
    $ErrorActionPreference = "STOP"
    $ProgressPreference = "SilentlyContinue"

    $watch = [System.Diagnostics.StopWatch]::StartNew()

    $destinationPath = $Destination.TrimEnd('\')

    # Load packages
    $packages = Get-Packages

    # Ensure destination exists
    if (!(Test-Path $destinationPath -PathType "Container"))
    {
        New-Item $destinationPath -ItemType Directory -WhatIf:$false | Out-Null
    }

    # Find out which files is needed
    $allSpecs = Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags

    if ($Tags -eq $null)
    {
        $Tags = Get-LatestSupportedVersionTags -Specs $allSpecs
    }

    $specs = Initialize-BuildSpecifications -Specifications $allSpecs -InstallSourcePath $Destination -Tags $Tags -ImplicitTagsBehavior "Include" -DeprecatedTagsBehavior $DeprecatedTagsBehavior -ExperimentalTagBehavior $ExperimentalTagBehavior
    $expected = $specs | Where-Object { $_.Include -and $_.Sources.Length -gt 0 } | Select-Object -ExpandProperty Sources -Unique

    # Check or download needed files
    $expected | ForEach-Object {
        $filePath = $_

        if (Test-Path $filePath -PathType Leaf)
        {
            $requiredFile = Get-Item -Path $filePath

            if ($requiredFile.Length -gt 0)
            {
                Write-Message ("Required package found: '{0}'" -f $filePath) -Level Debug

                return
            }

            Remove-Item -Path $filePath -Force
        }

        $fileName = ($filePath.Replace(("{0}" -f $destinationPath), "")) -replace "([\/\\])", ""
        $package = $packages.$fileName

        if ($null -eq $package)
        {
            throw ("Required package '{0}' was not defined in 'sitecore-packages.json' so it can't be downloaded, please add the package ' {1}' manually." -f $fileName, $filePath)
        }

        $fileUrl = $package.url

        if ([string]::IsNullOrEmpty($fileUrl))
        {
            Write-Message ("Required package '{0}' not available for download because the url property is empty, please copy '{0}' into '{1}' manually." -f $fileName, $Destination) -Level Warning
        }
        else
        {
            if ($PSCmdlet.ShouldProcess($fileName))
            {
                Write-Message ("Downloading '{0}' to '{1}'..." -f $fileUrl, $filePath)

                # Download package
                Invoke-FileDownload -Url $fileUrl -Path $filePath

            }
        }
    }

    $watch.Stop()
    Write-Message "Restore completed. Time: $($watch.Elapsed.ToString("hh\:mm\:ss\.fff"))."
}