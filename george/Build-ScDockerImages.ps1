$winversion = "1903"
$scversion = "9.2"

# build base images
Get-ChildItem .\base\ -Directory | Where-Object { Test-Path "$($_.FullName)\Dockerfile" } | ForEach-Object { Start-Process docker -ArgumentList "build", "--rm", "-t", "scbase-$($_.Name):$winversion", "--build-arg", "WINVERSION=$winversion", "-f", ".\base\$($_.Name)\Dockerfile", "." -NoNewWindow -Wait }

# build application images
Get-ChildItem .\application\ -Directory | Where-Object { Test-Path "$($_.FullName)\Dockerfile" } | ForEach-Object { Start-Process docker -ArgumentList "build", "--rm", "-t", "$($_.Name):$scversion-$winversion", "-t", "george.azurecr.io/$($_.Name):$scversion-$winversion", "--build-arg", "WINVERSION=$winversion", "--build-arg", "SCVERSION=$scversion", "-f", ".\application\$($_.Name)\Dockerfile", "."  -NoNewWindow -Wait }