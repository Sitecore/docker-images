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

    # this function only works when run from the console
    if ($Host.Name -notlike '*ISE*')
    {
        if ($Stop)
        {
            [console]::CursorVisible = $true
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
            $barNotProgressed = ($progressBarWidth - 2) - $barProgressed

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
        Write-Verbose "The progress indicator is not compatible with PowerShell ISE."
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

    if ($Length -gt 0)
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
        [System.Net.CookieContainer]$Cookies
    )

    Add-Type -AssemblyName System.Net.Http
    $handler = New-Object System.Net.Http.HttpClientHandler
    if ($cookies)
    {
        $handler.UseCookies = $true
        $handler.CookieContainer = $cookies
    }
    $client = New-Object -TypeName System.Net.Http.Httpclient $handler

    $task = $client.GetAsync($Url, [System.Net.Http.HttpCompletionOption]::ResponseHeadersRead)
    $task.Wait()

    $response = $task.Result
    $response.EnsureSuccessStatusCode() > $null
    $dispositionHeader = $response.Content.Headers.ContentDisposition
    $disposition = [System.Net.Mime.ContentDisposition]::new($dispositionHeader)
    $filename = $disposition.FileName
    $downloadPath = $Path #Join-Path -Path $path -ChildPath $fileName
    $totalBytes = $response.Content.Headers.ContentLength

    $readTask = $response.Content.ReadAsStreamAsync()
    $readTask.Wait()
    $contentStream = $readTask.Result

    [long]$totalBytesRead = 0
    [long]$readCount = 0
    [byte[]]$buffer = [byte[]]::CreateInstance([byte], 8192)
    $hasMoreToRead = $true

    try
    {
        $fileStream = [System.IO.FileStream]::new($downloadPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::ReadWrite, 8192, $true)
        do
        {
            $contentTask = $contentStream.ReadAsync($buffer, 0, $buffer.Length)
            $contentTask.Wait()
            $bytesRead = $contentTask.Result
            if ($bytesRead -eq 0)
            {
                $hasMoreToRead = $false
                continue
            }

            $fileStream.WriteAsync($buffer, 0, $bytesRead) > $null
            $totalBytesRead += $bytesRead
            $readCount += 1

            if ($readCount % 100 -eq 0)
            {
                $percentComplete = ($totalBytesRead / $totalBytes * 100)
                #Write-Progress -Activity "Downloading $($filename)" -Status "Downloaded $([math]::round($totalBytesRead /1MB, 0)) MB of $([math]::round($totalBytes /1MB, 0)) MB" -PercentComplete ($totalBytesRead / $totalBytes * 100)
                Write-InlineProgress -Activity "Downloading" -PercentComplete $percentComplete -StatusMessage "$([math]::round($totalBytesRead /1MB, 0))MB / $([math]::round($totalBytes /1MB, 0))MB"
            }
        }
        while ($hasMoreToRead)

        #Write-Progress -Activity "Download complete." -Status "Finishing up" -Completed
        Write-InlineProgress -Activity "Download complete" -Completed
    }
    finally
    {
        $contentStream.Dispose()
        $fileStream.Close()
        $fileStream.Dispose()
        $client.Dispose()
    }
}