function Get-WindowsServerCoreToRuntimeWindowsServerCoreMap
{
    Write-Output @{
        "20H2"     = "2009";
        "2004"     = "2004";
        "1909"     = "1909";
        "1903"     = "1903";
        "ltsc2019" = "ltsc2019";
        "1803"     = "1803";
        "1709"     = "1709";
        "ltsc2016" = "sac2016"
    }
}

