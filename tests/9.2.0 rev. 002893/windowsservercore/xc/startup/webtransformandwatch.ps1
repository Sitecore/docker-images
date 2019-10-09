[CmdletBinding()]
param(
    # Path to watch for changes
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$Path,
    # Destination path to keep updated
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$Destination,
    # Milliseconds to sleep between sync operations
    [Parameter(Mandatory = $false)]
    [int]$SleepMilliseconds = 200,
    # Default files to skip during sync
    [Parameter(Mandatory = $false)]
    [array]$DefaultExcludedFiles = @("*.user", "*.cs", "*.csproj", "packages.config", "*ncrunch*", ".gitignore", ".dockerignore", "*.example", "*.disabled"),
    # Additional files to skip during sync
    [Parameter(Mandatory = $false)]
    [array]$ExcludeFiles = @(),
    # Default directories to skip during sync
    [Parameter(Mandatory = $false)]
    [array]$DefaultExcludedDirectories = @("obj", "Properties", "node_modules"),
    # Additional directories to skip during sync
    [Parameter(Mandatory = $false)]
    [array]$ExcludeDirectories = @(),
    # Instance name
    [Parameter(Mandatory = $false)]
    [array]$InstanceName
)

function JsonTransform{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[ValidateScript( { Test-Path $_ -PathType 'Leaf' })] 
		[string]$Path,
		[Parameter(Mandatory = $true)]
		[ValidateScript( { Test-Path $_ -PathType 'Leaf' })] 
		[string]$TransformPath
	)

	Write-Host "Running Json transform '$TransformPath' on '$Path'..."
	$JdtDLLPath = "$PSScriptRoot\Microsoft.VisualStudio.Jdt.dll";
	$NewtonsoftDLLPath = "$PSScriptRoot\Newtonsoft.Json.dll";
	[System.Reflection.Assembly]::LoadFrom($JdtDLLPath) | out-null
	[System.Reflection.Assembly]::LoadFrom($NewtonsoftDLLPath) | out-null

	$target = [System.IO.File]::OpenRead($Path);
	$transformation = New-Object Microsoft.VisualStudio.Jdt.JsonTransformation($TransformPath);
	$transformedStream = $transformation.Apply($target);
	$transformedByteArray = $transformedStream.ToArray();
	[System.IO.File]::WriteAllBytes($Path, $transformedByteArray);
}

function XmlTransform{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[ValidateScript( { Test-Path $_ -PathType 'Leaf' })] 
		[string]$Path,
		[Parameter(Mandatory = $true)]
		[ValidateScript( { Test-Path $_ -PathType 'Leaf' })] 
		[string]$TransformPath
	)

	Write-Host "Running XDT transform '$TransformPath' on '$Path'..."

	$XdtDllPath = "$PSScriptRoot\Microsoft.Web.XmlTransform.dll";
	Add-Type -Path $XdtDllPath

	$target = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument;
	$target.PreserveWhitespace = $true
	$target.Load($Path);

	$transformation = New-Object Microsoft.Web.XmlTransform.XmlTransformation($TransformPath);

	if ($transformation.Apply($target) -eq $false)
	{
		throw "XDT transformation failed."
	}

	$target.Save($Path);
}

function Sync
{
    param(
        [Parameter(Mandatory = $true)]
        $Path,
        [Parameter(Mandatory = $true)]
        $Destination,
        [Parameter(Mandatory = $false)]
        $ExcludeFiles,
        [Parameter(Mandatory = $false)]
        $ExcludeDirectories
    )

    $command = @("robocopy", "`"$Path`"", "`"$Destination`"", "/E", "/XX", "/MT:1", "/NJH", "/NJS", "/FP", "/NDL", "/NP", "/NS", "/R:5", "/W:1")
    
    if ($ExcludeDirectories.Count -gt 0)
    {        
        $command += "/XD "

        $ExcludeDirectories | ForEach-Object {
            $command += "`"$_`" "
        }

        $command = $command.TrimEnd()
    }

    if ($ExcludeFiles.Count -gt 0)
    {        
        $command += "/XF "

        $ExcludeFiles | ForEach-Object {
            $command += "`"$_`" "
        }

        $command = $command.TrimEnd()
    }
    
    $commandString = $command -join " "

    $dirty = $false
    $raw = &([scriptblock]::create($commandString))
    $raw | ForEach-Object {
        $line = $_.Trim().Replace("`r`n", "").Replace("`t", " ")
        $dirty = ![string]::IsNullOrEmpty($line)

        if ($dirty)
        {
            Write-Host ("{0}: {1}" -f [DateTime]::Now.ToString("HH:mm:ss:fff"), $line) -ForegroundColor DarkGray            
        }
    }

    if ($dirty)
    {
        Write-Host ("{0}: Done syncing..." -f [DateTime]::Now.ToString("HH:mm:ss:fff")) -ForegroundColor Green
    }
}

if($InstanceName){
	$TransformsFolder = "transforms\$InstanceName"
	if(Test-Path -Path "$PSScriptRoot/$TransformsFolder"){
		#XML transforms
		Get-ChildItem -path "$PSScriptRoot/$TransformsFolder" -filter '*.config' -recurse | ForEach-Object {
			$relativePath = $_ | Resolve-Path -Relative
			$trasformPath = $relativePath.Replace(".\startup\", "")
			$relativePath = $relativePath.Replace(".\startup\$TransformsFolder", "")
			XmlTransform -Path "c:\$relativePath" -TransformPath "$PSScriptRoot\$trasformPath"
		}
		
		#Json transforms
		Get-ChildItem -path "$PSScriptRoot/$TransformsFolder" -filter '*.json' -recurse | ForEach-Object {
			$relativePath = $_ | Resolve-Path -Relative
			$trasformPath = $relativePath.Replace(".\startup\", "")
			$relativePath = $relativePath.Replace(".\startup\$TransformsFolder", "")
			JsonTransform -Path "c:\$relativePath" -TransformPath "$PSScriptRoot\$trasformPath"
		}
	}

	$HostsEntriesFile = "hostsentries\$InstanceName.txt"
	if(Test-Path -Path "$PSScriptRoot/$HostsEntriesFile"){
		#HostEntries
		foreach($line in Get-Content $PSScriptRoot/$HostsEntriesFile) {
			& Add-Content C:\Windows\System32\drivers\etc\hosts "$line"
			Write-Host "Added '$line' to hosts file";
		}
	}
	
	$CertificatesFolder = "certificates\$InstanceName"
	if(Test-Path -Path "$PSScriptRoot/$CertificatesFolder"){
		#Certificates
		Get-ChildItem -path "$PSScriptRoot/$CertificatesFolder" -filter '*.cer' -recurse | ForEach-Object {
			if($($_.name) -Match 'my') {
				& Import-Certificate -FilePath $($_.FullName) -CertStoreLocation cert:\LocalMachine\My
			}
			if($($_.name) -Match 'root') {
				& Import-Certificate -FilePath $($_.FullName) -CertStoreLocation cert:\LocalMachine\Root
			}
		}
	}
}

# Setup exclude rules
$fileRules = ($DefaultExcludedFiles + $ExcludeFiles) | Select-Object -Unique
$directoryRules = ($DefaultExcludedDirectories + $ExcludeDirectories) | Select-Object -Unique

Write-Host ("{0}: Excluding files: {1}" -f [DateTime]::Now.ToString("HH:mm:ss:fff"), ($fileRules -join ", "))
Write-Host ("{0}: Excluding directories: {1}" -f [DateTime]::Now.ToString("HH:mm:ss:fff"), ($directoryRules -join ", "))

# Cleanup old event if present in current session
Get-EventSubscriber -SourceIdentifier "FileDeleted" -ErrorAction "SilentlyContinue" | Unregister-Event

# Setup delete watcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $Path
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent $watcher Deleted -SourceIdentifier "FileDeleted" -MessageData $Destination {
    $destinationPath = Join-Path $event.MessageData $eventArgs.Name
    $delete = !(Test-Path $eventArgs.FullPath) -and (Test-Path $destinationPath)

    if ($delete)
    {
        try
        {
            Remove-Item -Path $destinationPath -Force -Recurse -ErrorAction "SilentlyContinue"

            Write-Host ("{0}: Deleted '{1}'..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"), $destinationPath) -ForegroundColor Green
        }
        catch
        {
            Write-Host ("{0}: Could not delete '{1}'..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"), $destinationPath) -ForegroundColor Red
        }
    }
} | Out-Null

try
{
    Write-Host ("{0}: Watching '{1}' for changes, will copy to '{2}'..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"), $Path, $Destination)

    # Main loop
    while ($true)
    {
        Sync -Path $Path -Destination $Destination -ExcludeFiles $fileRules -ExcludeDirectories $directoryRules

        Start-Sleep -Milliseconds $SleepMilliseconds
    }
}
finally 
{
    # Cleanup
    Get-EventSubscriber -SourceIdentifier "FileDeleted" | Unregister-Event

    if ($watcher -ne $null)
    {
        $watcher.Dispose()
        $watcher = $null
    }

    Write-Host ("{0}: Stopped." -f [DateTime]::Now.ToString("HH:mm:ss:fff")) -ForegroundColor Red
}