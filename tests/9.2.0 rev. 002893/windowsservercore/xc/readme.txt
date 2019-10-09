references:
https://github.com/Sitecore/docker-images/blob/master/IMAGES.md
https://intranet.valtech.com/cf/pages/viewpage.action?spaceKey=GSP&title=Spin+up+local+SXA+instance+with+Docker

commands:
Spin up containers: 				docker-compose -f docker-compose.yml up
Stop and remove containers: 			docker-compose -f .\docker-compose.yml down
List all containers:				docker ps -a
List all images:				docker images -a
Attach powershell to a running contianer: 	docker exec -ti docker_cm_1 powershell
Copy file from a stopped container to host:	docker cp docker_cm_1:/inetpub\sc\Web.config Web.config
Copy folder from a stopped container to host:	docker cp docker_cm_1:/inetpub\sc D:\
Remove all images from filesystem:		docker rmi $(docker images -a -q)
Stop a running container:			docker stop docker_cm_1
Create jssbuster network:			docker network create -d nat --subnet=172.28.0.0/16 docker_jssbuster
Disconnect container from network:		docker network disconnect docker_jssbuster docker_sql_1
Remove unused networks:				docker network prune
Connect running container to network:		docker network connect --ip 172.28.0.2 docker_jssbuster docker_sql_1
						docker network connect --ip 172.28.0.3 docker_jssbuster docker_solr_1
						docker network connect --ip 172.28.0.4 docker_jssbuster docker_xconnect_1
						docker network connect --ip 172.28.0.5 docker_jssbuster docker_xconnect-automationengine_1
						docker network connect --ip 172.28.0.6 docker_jssbuster docker_xconnect-indexworker_1
						docker network connect --ip 172.28.0.7 docker_jssbuster docker_cd_1
						docker network connect --ip 172.28.0.8 docker_jssbuster docker_cm_1
Start all containers:				docker start $(docker ps -a -q)
Remove all unused stuff				docker system prune -a
Build a dockerfile				docker build -t sitecore-xp-xc-base:9.2.0-windowsservercore-ltsc2019 . --build-arg BASE_IMAGE=valtech.azurecr.io/sitecore-xp-base:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-standalone:9.2.0-windowsservercore-ltsc2019 . --build-arg BASE_IMAGE=sitecore-xp-xc-base:9.2.0-windowsservercore-ltsc2019
#Build a dockerfile				docker build -t sitecore-xp-xc-commerce-base:9.2.0-windowsservercore-ltsc2019 . --build-arg BASE_IMAGE=sitecore-xp-xc-base:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-standalone:9.2.0-windowsservercore-ltsc2019 . --build-arg BASE_IMAGE=sitecore-xp-xc-standalone:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-commerce-authoring:9.2.0-windowsservercore-ltsc2019 . --build-arg BASE_IMAGE=sitecore-xp-xc-base:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-commerce-minions:9.2.0-windowsservercore-ltsc2019 . --build-arg BUILD_IMAGE=sitecore-xp-xc-commerce-base:9.2.0-windowsservercore-ltsc2019 --build-arg BASE_IMAGE=sitecore-xp-xc-base:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-commerce-ops:9.2.0-windowsservercore-ltsc2019 . --build-arg BUILD_IMAGE=sitecore-xp-xc-commerce-base:9.2.0-windowsservercore-ltsc2019 --build-arg BASE_IMAGE=sitecore-xp-xc-base:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-commerce-shops:9.2.0-windowsservercore-ltsc2019 . --build-arg BUILD_IMAGE=sitecore-xp-xc-commerce-base:9.2.0-windowsservercore-ltsc2019 --build-arg BASE_IMAGE=sitecore-xp-xc-base:9.2.0-windowsservercore-ltsc2019

Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-solr:9.2.0-nanoserver-1903 . --build-arg BUILD_IMAGE=valtech.azurecr.io/sitecore-base:9.2.0-windowsservercore-1903 --build-arg BASE_IMAGE=valtech.azurecr.io/sitecore-xp-solr:9.2.0-nanoserver-1903
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-sqldev:9.2.0-windowsservercore-ltsc2019 . --build-arg BASE_IMAGE=valtech.azurecr.io/sitecore-xp-sqldev:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-xconnect:9.2.0-windowsservercore-ltsc2019 . --build-arg BUILD_IMAGE=valtech.azurecr.io/sitecore-xp-base:9.2.0-windowsservercore-ltsc2019 --build-arg BASE_IMAGE=valtech.azurecr.io/sitecore-xp-xconnect:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-xconnect-indexworker:9.2.0-windowsservercore-ltsc2019 . --build-arg BUILD_IMAGE=valtech.azurecr.io/sitecore-xp-base:9.2.0-windowsservercore-ltsc2019 --build-arg BASE_IMAGE=valtech.azurecr.io/sitecore-xp-xconnect-indexworker:9.2.0-windowsservercore-ltsc2019
Build a dockerfile				docker build -t sitecore-xp-xc-9.2.0-xconnect-automationengine:9.2.0-windowsservercore-ltsc2019 . --build-arg BUILD_IMAGE=valtech.azurecr.io/sitecore-xp-base:9.2.0-windowsservercore-ltsc2019 --build-arg BASE_IMAGE=valtech.azurecr.io/sitecore-xp-xconnect-automationengine:9.2.0-windowsservercore-ltsc2019

Reset IIS					invoke-command -scriptblock {iisreset}
Get Certificates				Get-ChildItem -Path 'Cert:\LocalMachine\My' -Recurse
Authenticate with Azure CLI:			az login
						az acr login --name valtech
Import certificate to LocalMachine\My: 		Import-Certificate -FilePath "f2478f6c3c372849c3b04780c495d5c2bac13b44.cer" -CertStoreLocation cert:\LocalMachine\My
Import certificate to LocalMachine\Root:	Import-Certificate -FilePath "2a345b61c35165664b98f0085b535cde286cf3e0.cer" -CertStoreLocation cert:\LocalMachine\Root

hostnames:
Sitecore CD: http://localhost:44002/
Sitecore CM: http://localhost:44001/
SOLR: http://localhost:44011/solr/#/

certificates:
xconnect		import password: 1234 thmb:78aa7d6fdc0db6fbeecc8a415f64c72ba2856441
xconnect-client		import password: 1234 thmb:0f3b89e572e92fe0e9e8cb82aaa334436a38a588