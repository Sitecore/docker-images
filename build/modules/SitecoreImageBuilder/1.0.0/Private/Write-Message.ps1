enum MessageLevel
{
    Debug
    Info
    Warning
    Verbose
    Error
}
function Write-Message
{
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Message,
        [Parameter()]
        [MessageLevel]$Level = [MessageLevel]::Info
    )

    $timeFormat = "HH:mm:ss:fff"

    $formattedMessage = "$(Get-Date -Format $timeFormat): $($Message)"

    switch ($Level)
    {
        ([MessageLevel]::Debug)
        {
            Write-Host $formattedMessage -ForegroundColor Cyan
            break
        }
        ([MessageLevel]::Info)
        {
            Write-Host $formattedMessage -ForegroundColor Green
            break
        }
        ([MessageLevel]::Verbose)
        {
            Write-Verbose $formattedMessage
            break
        }
        ([MessageLevel]::Warning)
        {
            Write-Warning $formattedMessage
            break
        }
        ([MessageLevel]::Error)
        {
            Write-Error $formattedMessage
            break
        }
        default
        {
            Write-Host $formattedMessage -ForegroundColor Green
        }
    }
}