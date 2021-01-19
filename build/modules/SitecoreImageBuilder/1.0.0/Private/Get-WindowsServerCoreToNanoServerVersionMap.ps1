function Get-WindowsServerCoreToNanoServerVersionMap
{
    Write-Output @{
        "20H2"     = "20H2";
        "2004"     = "2004";
        "1909"     = "1909";
        "1903"     = "1903";
        "ltsc2019" = "1809";
        "1803"     = "1803";
        "1709"     = "1709";
        "ltsc2016" = "sac2016"
    }
}

