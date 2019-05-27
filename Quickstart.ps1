[CmdletBinding(DefaultParameterSetName = "__Quickstart")]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
Param(
  [Parameter(Position = 0, Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string]$Registry
  ,
  [Parameter(ParameterSetName = "__Quickstart", Position = 1, Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string]$SitecoreUsername
  ,
  [Parameter(ParameterSetName = "__Quickstart", Position = 2, Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string]$SitecorePassword
  ,
  [Parameter(Position = 3)]
  [ValidateScript({ (Test-Path $_ -PathType "Container") -or (Test-Path $_ -IsValid) })]
  [string]$SavePath = ".\packages"
  ,
  [Parameter(ParameterSetName = "__Local", Position = 1, Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType "Container" })]
  [string]$InstallSourcePath
)
Begin {
  $eap = $ErrorActionPreference
  $pp = $ProgressPreference

  $ErrorActionPreference = "Stop"
  $ProgressPreference = "SilentlyContinue";

  $InstallSourceResolver = $null
  $LookupTable = @{}
  $scSession = $null
}
Process {
  # Import module
  Import-Module ".\modules\SitecoreImageBuilder" -Force

  # Establish mechanism to fiding packages based on incoming params  
  If ($PSCmdlet.ParameterSetName -eq "__Local") {
    $InstallSourceResolver = {
      Param($Filename)
      $result = Join-Path $InstallSourcePath -ChildPath $Filename
      Write-Verbose "${filename} resolved to ${result}"
      Return $result
    }
  } Else {
    # Cache a list of packages we could potentially be downloading into
    # a lookup table we'll use in the InstallSourceResolver
    $packages = Get-Content "${PSScriptRoot}\sitecore-packages.json" | ConvertFrom-Json

    # ensure SavePath exists
    If (!(Test-Path $SavePath)) {
      New-Item $SavePath -ItemType "Directory" | Out-Null
    }

    $InstallSourceResolver = {
      Param($Filename, $Tag)

      # Look locally first
      $expectedLocation = Join-Path $SavePath -ChildPath $Filename
      If (Test-Path $expectedLocation -PathType "Leaf") {
        Write-Verbose "${filename} resolved to ${expectedLocation}"
        Return $expectedLocation
      }

      # Next, look to remote source
      # grab reference to the package at hand (if it exists)
      If ($packages.PSObject.Properties.Name -contains $Filename) {
        $package = $packages.$Filename

        # confirm we have a remote source
        If ($package.psobject.Properties.Name -notcontains "url") {
          Throw "Unable to find/fetch '${Filename}' needed for '${Tag}', no 'url' provided in sitecore-packages.json entry."
        }

        # save a reference to the source
        $remoteSource = $package.url
        Write-Verbose "${Filename} resolved to ${remoteSource}"

        # Login to sitecore's site and save session for re-use
        if ($null -eq $scSession) {
          $loginResponse = Invoke-WebRequest "https://dev.sitecore.net/api/authorization" -Method Post -Body @{
            username = $SitecoreUsername
            password = $SitecorePassword
            rememberMe = $true
          } -SessionVariable "scSession" -UseBasicParsing
          If ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200) {
            Throw "Unable to login to dev.sitecore.net with the supplied credentials"
          }
          Write-Verbose "Logged in to dev.sitecore.net."
        }

        # fetch from sitecore site.
        Write-Verbose "Downloading ${Filename} from ${remoteSource}"
        Invoke-WebRequest -Uri $remoteSource -OutFile $expectedLocation -WebSession $scSession -UseBasicParsing
        
        # Now return the path to the saved location
        Write-Verbose "Download saved to ${expectedLocation}"
        Return $expectedLocation
      }

      # Not local, and don't know where to get it from
      Throw "Unable to find/fetch '${Filename}' needed for '${Tag}', not found locally and no entry in sitecore-packages.json."
    }
  }

  # Begin build (for quickstart, let's skip 7.5 as it's a little old and requires a 10gb
  # download now from dev.sitecore.net's archive)
  SitecoreImageBuilder\Invoke-Build `
    -Path "${PSScriptRoot}\images" `
    -InstallSourceResolver $InstallSourceResolver `
    -Registry $Registry `
    -Exclude "*:7.5*" `
    -ErrorAction:$ErrorActionPreference `
    -Verbose:$VerbosePreference `
    -WhatIf:$WhatIfPreference
}
End {
  $ErrorActionPreference = $eap;
  $ProgressPreference = $pp
}