


function CopySitecoreFiles($sitecoreContainerName, $outputDir){
    
    $dockerId = docker ps -q --filter name=${sitecoreContainerName}

    docker stop $dockerId

    $dockerIdAndPath = "${dockerId}:/inetpub/sc"

    docker cp $dockerIdAndPath "${outputDir}"

    docker start $dockerId
	
	Write-Output "Sitecore files from container, " $sitecoreContainerName  ", have been copied to " $outputDir
}


CopySitecoreFiles "windowsservercore_cm_1" "tests/9.2.0 rev. 002893/windowsservercore/data/cm"

CopySitecoreFiles "windowsservercore_cd_1" "tests/9.2.0 rev. 002893/windowsservercore/data/cd"
























