<#
    .SYNOPSIS
        Proxy localhost ports to specific hostnames through a loopback IP address

        Use this script to proxy hostnames directly to your local Docker containers. No DNS required.

    .DESCRIPTION
        The script reads port, hostname and loopback addresses from a csv file.

        netshell is then used to add a port proxy between locahost:port and loopback IP:80

        Loopback IP -> Hostname entries are then written to the hosts file

        _Ex. usage:_
            __Run Powershell as administrator.__

            # Default; expects .\Hostnames.csv file
            $ .\Set-LocalPortsToHostsProxies.ps1 

            $ .\Set-LocalPortsToHostsProxies.ps1 -CsvFile .\SomeFile.csv

            $ .\Set-LocalPortsToHostsProxies.ps1 -CsvFile .\SomeFile.csv -Remove

        CSV file format example; 

        Example .\PortsToHostnames.csv

>> bof
Port,HostName,LoopBack
44001,cm.solution.local,127.0.1.100
44002,solution.local,127.0.1.110
44002,subsite1.solution.local,127.0.1.110
44002,subsite2.solution.local,127.0.1.110
44011,solr.solution.local,127.0.1.120
<< eof

Note; Loopback IP has to be unused and within the local address segment, 127.0.0.0/8 

        _Troubleshooting:_
            Hostnames not responding
                Check hosts file and csv file for errors

            Hostnames are redirecting to localhost port 80 ? 
                - Check if Docker containers are running.

                - Validate your bindings - List all configured port proxies:
                        $ netsh interface portproxy show all

                - Try to run:
                    $ netsh Interface ipv4 install

                .. restart and test again ..

            _Still not working?_ 
                Checkout the netsh docs:
                https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731068(v=ws.10)


    - Anders Laub, @anderslaub, Nov. 2019
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$CsvFile = (Join-Path $PSScriptRoot "\PortsToHostnames.csv"),
    [Switch]$Remove
)

if (-not (Test-Path $CsvFile)) {
    Write-Host "File: $($CsvFile) does not exist." -ForegroundColor Red
    exit
}

Function Invoke-NetshellPortProxy {
    param (
        [Parameter(Mandatory = $true)]
        [string]$LoopBack,
        [Parameter(Mandatory = $true)]
        [string]$Port,
        [Parameter(Mandatory = $false)]
        [bool]$Remove = $false
    )
    if ($Remove -eq $true) {
        $Expression = ("netsh interface portproxy delete v4tov4 listenport=80 listenaddress={0}" -f $_.LoopBack)

    }
    else {
        $Expression = ("netsh interface portproxy add v4tov4 listenport=80 listenaddress={0} connectport={1} connectaddress=127.0.0.1" `
                -f $_.LoopBack, $_.Port)
    }
    Write-Verbose $Expression
    Invoke-Expression $Expression
}

Function Update-HostsFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$IpAddress,
        [Parameter(Mandatory = $true)]
        [string]$HostName,
        [Parameter(Mandatory = $false)]
        [bool]$Remove = $false,
        [Parameter(Mandatory = $false)]
        [Switch]$OverwriteByIp
    )
    $HostsFilePath = "$env:windir\System32\drivers\etc\hosts"
    $Replaced = $false
    $HostsFileContent = Get-Content $HostsFilePath
    $HostsFileContent = $HostsFileContent | ForEach-Object {
        if ($_ -match ("(\t| ){0}" -f $HostName) `
                -bor ($OverwriteByIp -eq $true -band $Replaced -eq $false `
                    -band $_ -match ("{0}" -f $IpAddress))) {
            if ($Remove) { 
                ""
            }
            else {
                "$($IpAddress)`t$($HostName)"
            }
            $Replaced = $true
        }
        else { 
            $_ 
        }
    }
    if (-not $Replaced -band -not $Remove) {
        $HostsFileContent += ("`n{0}`t{1}" -f $IpAddress, $HostName)
    }
    $HostsFileContent | Out-File $HostsFilePath -enc ascii    
}

## do ##

Import-CSV $CsvFile | ForEach-Object {
    $_ | Format-Table | Out-String
    Invoke-NetshellPortProxy -LoopBack $_.LoopBack -Port $_.Port -Remove $Remove
    Update-HostsFile -IpAddress $_.LoopBack -HostName $_.HostName -Remove $Remove
}
Write-Host "Done.." -ForegroundColor Green