# Credits: https://github.com/michaellwest/docker-https by Michael West

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$EntryPointScriptPath = "C:\tools\entrypoints\iis\Development.ps1"
)
Write-Host "Running startup.ps1"
Import-Module WebAdministration
$website = "Default Web Site"
Write-Host "Checking if $($website) has any existing HTTPS bindings"
$hostHeaders = "${env:HOST_HEADER}".Split(";", [System.StringSplitOptions]::RemoveEmptyEntries)
function Set-HttpBinding {
    param(
        [string]$SiteName,
        [string]$HostHeader
    )
    if ($null -eq (Get-WebBinding -Name $siteName | Where-Object { $_.BindingInformation -eq "*:80:$($hostHeader)" })) {
        Write-Host "Adding a new HTTP binding for $($siteName)"
        $binding = New-WebBinding -Name $siteName -Protocol http -IPAddress * -Port 80 -HostHeader $hostHeader
    } else {
        Write-Host "HTTP binding for $($siteName) already exists"
    }

    # Removing existing HTTPS binding
    Remove-IISSiteBinding -Name $SiteName -BindingInformation "$($HostHeader):443"
    
    if ($null -eq (Get-WebBinding -Name $siteName | Where-Object { $_.BindingInformation -eq "*:443:$($hostHeader)" })) {
        Write-Host "Adding a new HTTPS binding for $($siteName)"
        $securePassword = (Get-Content -Path C:\startup\cert.password.txt) | ConvertTo-SecureString -AsPlainText -Force
        $cert = Import-PfxCertificate -Password $securePassword -CertStoreLocation Cert:\LocalMachine\root -FilePath C:\startup\cert.pfx   
        $thumbprint = $cert.Thumbprint
        $binding = New-WebBinding -Name $siteName -Protocol https -IPAddress * -Port 443 -HostHeader $hostHeader
        $binding = Get-WebBinding -Name $siteName -Protocol https
        $binding.AddSslCertificate($thumbprint, "root")
    } else {
        Write-Host "HTTPS binding for $($siteName) already exists"
    }
}
foreach($hostheader in $hostHeaders) {
    Set-HttpBinding -SiteName $website -HostHeader $hostheader
}

Write-Host "Running $($EntryPointScriptPath)"
& $EntryPointScriptPath