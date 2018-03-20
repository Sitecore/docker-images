[CmdletBinding()]
param(
    # Hostname
    [Parameter(Mandatory=$true)]
    [String]$Hostname
)

$available = $false;
$numberOfTries = 0;
$totalTries = 10;

do {
    Write-Host "Waiting for SOLR service to be available...";

    try {
        $solrPing = Invoke-WebRequest "https://${Hostname}:8983/solr" -UseBasicParsing -Verbose

        if($solrPing.StatusCode -eq 200) {
            $available = $true;
            exit 0;
        } else {
            Throw "Error code querying solr: $solrPing.StatusCode";
        }
    }
    catch {
        Write-Verbose "SOLR service not available yet...";
        Start-Sleep 5
    }
    
    if($numberOfTries -eq ($totalTries - 1)) {
        Throw "Solr service did not come up...";
    }
    $numberOfTries++;

} until($available -eq $true)

exit 1;