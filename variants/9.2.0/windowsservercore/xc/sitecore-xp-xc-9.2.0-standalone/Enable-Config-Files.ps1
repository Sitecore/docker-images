[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ConfigDir,
    [parameter(Mandatory = $true)]
    [string]$ConfigFileList
)

foreach ($configFileName in $ConfigFileList.split(",")) {
    Write-Host "Enabling config file: $configFileName" -ForegroundColor Green
    $configFilePath = Join-Path $ConfigDir -ChildPath $configFileName
    $disabledFilePath = "$configFilePath.disabled"
    $exampleFilePath = "$configFilePath.example"

    if (Test-Path $configFilePath) {
        Write-Host "  config file is already enabled..."
    }
    elseif (Test-Path $disabledFilePath) {
        Rename-Item -Path $disabledFilePath -NewName $configFileName
        Write-Host "  successfully enabled $disabledFilePath"
    }
    elseif (Test-Path $exampleFilePath) {
        Rename-Item -Path $exampleFilePath -NewName $configFileName
        Write-Host "  successfully enabled $exampleFilePath"
    }
    else {
        Write-Host "  configuration file not found." -ForegroundColor Red
    }
}