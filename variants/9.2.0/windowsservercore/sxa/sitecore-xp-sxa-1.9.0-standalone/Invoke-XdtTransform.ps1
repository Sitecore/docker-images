[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Leaf' })] 
    [string]$Path,
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Leaf' })] 
    [string]$XdtPath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Leaf' })] 
    [string]$XdtDllPath
)

Write-Host "Running XDT transform '$XdtPath' on '$Path'..."

Add-Type -Path $XdtDllPath

$target = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument;
$target.PreserveWhitespace = $true
$target.Load($Path);

$transformation = New-Object Microsoft.Web.XmlTransform.XmlTransformation($XdtPath);

if ($transformation.Apply($target) -eq $false)
{
    throw "XDT transformation failed."
}

$target.Save($Path);
