function Invoke-EnsureDirectoryExists([string]$path){
    [String[]]$entries = $path.Split(@('\', '/'));
    [String]$partialPath = '';

    foreach($entry in $entries)
    {
        if ([String]::IsNullOrWhiteSpace($partialPath)){
            $partialPath = $entry
        }else{
            $partialPath = Join-Path $partialPath $entry
        }
        if(-not(Test-Path $partialPath)) {
            New-Item $partialPath -ItemType Directory | Out-Null
        }
    }
}