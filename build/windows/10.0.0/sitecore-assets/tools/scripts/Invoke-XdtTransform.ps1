<#
.SYNOPSIS
    Applies XDT transformations to files.
.DESCRIPTION
    Applies XDT transformation on either a single file (file transform) or an entire folder (folder transform). 
    For folder transform, it assumes: (1) XDT transformation files end in ".xdt", and (2) folder structures match.
.PARAMETER Path
    Specifies either the target file to transform (file transform) or a target folder to apply transforms (folder transform).
.PARAMETER XdtPath
    Specifies either the XDT transform file (file transform) or a folder containing XDT transform files (folder transform).
.PARAMETER XdtDllPath
    Specifies the location of the Microsoft.Web.XmlTransform.dll assembly. Default is 'C:\tools\bin\Microsoft.Web.XmlTransform.dll'. 
.EXAMPLE
    PS C:\> .\Invoke-XdtTransform.ps1 -Path 'C:\inetpub\wwwroot\Web.config' -XdtPath 'C:\transforms\Web.config.xdt'
    Example of file transform.
.EXAMPLE
    PS C:\> .\Invoke-XdtTransform.ps1 -Path 'C:\inetpub\wwwroot' -XdtPath 'C:\transforms'
    Example of folder transform.
.INPUTS
    None
.OUTPUTS
    None
#>
[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ })]
    [string]$Path,

    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ })]
    [string]$XdtPath,

    [Parameter(Mandatory = $false)]
    [ValidateScript( { Test-Path $_ -PathType 'Leaf' })]
    [string]$XdtDllPath = "C:\tools\bin\Microsoft.Web.XmlTransform.dll"
)

if (((Test-Path $Path -PathType Container) -and (Test-Path $XdtPath -PathType Leaf)) -or
    ((Test-Path $Path -PathType Leaf) -and (Test-Path $XdtPath -PathType Container))) {
    throw "'Path' and 'XdtPath' parameter types must match (both files or both folders)"
}

Add-Type -Path $XdtDllPath

function ApplyTransform($filePath, $xdtFilePath) {
    Write-Verbose "Applying XDT transformation '$xdtFilePath' on '$filePath'..."

    $target = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument;
    $target.PreserveWhitespace = $true
    $target.Load($filePath);
    
    $transformation = New-Object Microsoft.Web.XmlTransform.XmlTransformation($xdtFilePath);
    
    if ($transformation.Apply($target) -eq $false)
    {
        throw "XDT transformation failed."
    }
    
    $target.Save($filePath);
}

if (Test-Path $Path -PathType Leaf) {

    # File transform
    ApplyTransform $Path $XdtPath

} else {

    # Folder transform
    $transformations = @(Get-ChildItem $XdtPath -File -Include "*.xdt" -Recurse)

    if ($transformations.Length -eq 0) {
        Write-Verbose "No transformations in '$XdtPath'"
        return
    }

    # Assume folder structures match
    $targetFullPath = (Resolve-Path $Path).Path
    $xdtFullPath = (Resolve-Path $XdtPath).Path

    $transformations | ForEach-Object {
        $targetFilePath = $_.FullName.Replace($xdtFullPath, $targetFullPath).Replace(".xdt", "")

        if (-not(Test-Path $targetFilePath -PathType Leaf)) {
            Write-Verbose "No matching file '$targetFilePath' for transformation '$($_.FullName)'. Skipping..."
            return
        }

        ApplyTransform $targetFilePath $_.FullName
    }
}
