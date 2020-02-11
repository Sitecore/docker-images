function Write-InlineProgress
{
    [CmdletBinding(DefaultParameterSetName = 'normal')]
    param (
        # Describe the activity being performed.
        [Parameter(Position = 0, ParameterSetName = 'normal')]
        [Parameter(ParameterSetName = 'completed')]
        [string] $Activity,

        # Minimum padding for the activity text. When set to 0 (default) the size of the activity text
        # is automatically adjusted based on the window width.
        [Parameter(ParameterSetName = 'normal')]
        [ValidateRange(0, [int]::MaxValue)]
        [int] $ActivityPadding = 0,

        # Define the percent complete value for the progress bar.
        [Parameter(ParameterSetName = 'normal')]
        [ValidateRange(0, 100)]
        [int] $PercentComplete,

        # Display the percent complete.
        # Note! If the window width is below 40 the percent value will not be displayed.
        [Parameter(ParameterSetName = 'normal')]
        [switch] $HideStatus,

        [Parameter(ParameterSetName = 'normal')]
        [string]$StatusMessage,

        # Stop without any update to the progress bar.
        [Parameter(ParameterSetName = 'stop')]
        [switch] $Stop,

        # Output last progress result.
        [Parameter(ParameterSetName = 'stop')]
        [switch] $OutputLastProgress,

        # Stop the progress bar with a final update.
        [Parameter(ParameterSetName = 'completed')]
        [switch] $Completed,

        # Customize the progress character.
        [Parameter(ParameterSetName = 'normal')]
        [ValidateLength(1, 1)]
        [ValidateNotNull()]
        [string] $ProgressCharacter = '>',

        # Customize the progress fill character.
        [Parameter(ParameterSetName = 'normal')]
        [ValidateLength(1, 1)]
        [ValidateNotNull()]
        [string] $ProgressFillCharacter = '=',

        # Customize the fill character.
        [Parameter(ParameterSetName = 'normal')]
        [ValidateLength(1, 1)]
        [ValidateNotNull()]
        [string] $ProgressFill = ' ',

        # Customize the bracket before the progress bar.
        [Parameter(ParameterSetName = 'normal')]
        [ValidateLength(0, 1)]
        [string] $BarBracketStart = '[',

        # Customize the bracket after the progress bar.
        [Parameter(ParameterSetName = 'normal')]
        [ValidateLength(0, 1)]
        [string] $BarBracketEnd = ']'
    )

    $consoleAvailable = $true
    try
    {
        [System.Console]::CursorVisible > $null
    }
    catch
    {
        $consoleAvailable = $false
        if ($Error -and $Error.Count -gt 0 -and $Error[0].Exception.Message -eq 'Exception setting "CursorVisible": "The handle is invalid."')
        {
            $Global:Error.Remove($Global:Error[0])
        }
    }

    # this function only works when run from the console
    if ($Host.Name -notlike '*ISE*' -and $consoleAvailable)
    {
        if ($Stop)
        {
            [System.Console]::CursorVisible = $true
        }
        else
        {
            # if the buffer if full, we need to resize it to make sure that the progress bar don't break
            if (($host.UI.RawUI.CursorPosition.y + 1) -ge ($host.UI.RawUI.BufferSize.Height))
            {
                $size = New-Object System.Management.Automation.Host.Size(($host.UI.RawUI.BufferSize.Width), (($host.UI.RawUI.BufferSize.Height + 1000)))
                $host.UI.RawUI.BufferSize = $size
            }

            $cursorPosition = $host.UI.RawUI.CursorPosition
            [console]::CursorVisible = $false

            $windowWidth = [console]::WindowWidth

            if ($Completed)
            {
                [console]::Write("$($Activity)$($ProgressFill * ($windowWidth - $Activity.Length))")
                [console]::CursorVisible = $true
                [console]::WriteLine()
                return
            }

            # if screen is very small, don't display the percent
            if ($windowWidth -le 40)
            {
                $HideStatus = $true
            }

            # calculate the size of the activity part of the output string
            if ($ActivityPadding -eq 0)
            {
                $activityPart = $Activity.Length + 1 #[math]::Floor($windowWidth / 4)
            }
            else
            {
                $activityPart = $ActivityPadding
            }

            # if activity string is longer than the allocated part length, truncate it
            if ($Activity.Length -gt $activityPart)
            {
                $Activity = Out-TruncatedString -String $Activity -Length $activityPart
            }

            $progressString = New-Object System.Text.StringBuilder -ArgumentList $windowWidth

            # add activity text to the progress string
            [void]$progressString.Append("$($Activity.PadRight($ActivityPart, ' ')) ")

            # add the start bracket for the progress bar to the progress string
            [void]$progressString.Append($BarBracketStart)

            # calculate the width of the progress bar
            # the 5 is to account for the space of the percent information
            if ($HideStatus)
            {
                $progressBarWidth = [math]::Floor($windowWidth / 2) - ($progressString.Length) + 1
            }
            else
            {
                if ([string]::IsNullOrEmpty($StatusMessage))
                {
                    $progressBarWidth = [math]::Floor($windowWidth / 2) - (($progressString.Length) + 5)
                }
                else
                {
                    $progressBarWidth = [math]::Floor($windowWidth / 2) - (($progressString.Length) + $StatusMessage.Length)
                }
            }

            # add one to the progress bar width if no end bracket is used
            if (-not ($BarBracketEnd))
            {
                $progressBarWidth++
            }

            # calculate the bar character percentage and how much of the bar is filled and how much is not filled
            $barCharacterInPercent = ($progressBarWidth - 2) / 100
            $barProgressed = [math]::Ceiling($PercentComplete * $barCharacterInPercent)
            $barNotProgressed = [math]::Min(($progressBarWidth - 2) - $barProgressed, 0)

            # add the progress bar to progress string
            if ($barProgressed -gt 0)
            {
                if ($barNotProgressed -gt 0)
                {
                    [void]$progressString.Append(($ProgressFillCharacter * ($barProgressed - 1)))
                    [void]$progressString.Append($ProgressCharacter)
                }
                else
                {
                    [void]$progressString.Append(($ProgressFillCharacter * $barProgressed))
                }
            }
            [void]$progressString.Append("$($ProgressFill * $barNotProgressed)$($BarBracketEnd)")

            # add the percent complete to the progress string
            if (!$HideStatus)
            {
                if ([string]::IsNullOrEmpty($StatusMessage))
                {
                    [void]$progressString.Append(" $($PercentComplete.ToString().PadLeft(3, ' '))% ")
                }
                else
                {
                    [void]$progressString.Append(" $($StatusMessage.PadLeft(3, ' ')) ")
                }
            }

            [console]::Write(($progressString.ToString()))

            $host.UI.RawUI.CursorPosition = $cursorPosition
        }
    }
    else
    {
        Write-Host "$($Activity) $($StatusMessage)"
    }
}

function Out-TruncatedString
{
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $String,

        [Parameter(Position = 1)]
        [ValidateRange(0, [int32]::MaxValue)]
        [int] $Length = 0
    )

    $outString = $String

    if ($Length -gt 3)
    {
        if ($String.Length -gt $Length)
        {
            $outString = $String.Substring(0, ($Length - 3)) + '...'
        }
    }

    Write-Output $outString
}

function Invoke-FileDownload
{
    [CmdletBinding()]
    param(
        [string]$Url,
        [string]$Path,
        [System.Net.CookieContainer]$Cookies,
        [int]$Timeout = 15000
    )

    $uri = [uri]::new($url)
    $request = [System.Net.HttpWebRequest]::Create($uri)
    $request.Timeout = $Timeout

    if ($cookies)
    {
        $request.CookieContainer = $cookies
    }

    $downloadPath = $Path
    $hasMoreToRead = $true
    $buffer = New-Object byte[] 10KB
    [long]$totalBytesRead = 0
    [long]$readCount = 0

    try
    {
        $response = $request.GetResponse()
        $totalBytes = [System.Math]::Floor($response.ContentLength)
        $responseStream = $response.GetResponseStream()
        $fileStream = [System.IO.FileStream]::new($downloadPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::ReadWrite, 10KB, $true)

        do
        {
            $bytesRead = $responseStream.Read($buffer, 0, $buffer.length)
            if ($bytesRead -eq 0)
            {
                $hasMoreToRead = $false
                continue
            }

            $fileStream.Write($buffer, 0, $bytesRead)
            $totalBytesRead += $bytesRead
            $readCount += 1

            if ($readCount % 100 -eq 0)
            {
                $percentComplete = ($totalBytesRead / $totalBytes * 100)
                Write-InlineProgress -Activity "Downloading" -PercentComplete $percentComplete -StatusMessage "$([math]::round($totalBytesRead /1MB, 2))MB / $([math]::round($totalBytes /1MB, 2))MB"
            }
        }
        while ($hasMoreToRead)

        Write-InlineProgress -Activity "Download complete" -Completed
    }
    finally
    {
        $fileStream.Flush()
        $fileStream.Close()
        $fileStream.Dispose()
        $responseStream.Dispose()
    }
}