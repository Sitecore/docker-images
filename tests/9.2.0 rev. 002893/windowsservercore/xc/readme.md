Please note that this xc in docker is still work in progress, however... This should get you xc products in sitecore's content tree already

Prequisite is that there is an intance of the identity server running on your local already with admin/b administrator credentials (dockerized identityserver is wip)

The compose file adds a network called "sitecore" with subnet 172.28.0.0/16:
172.28.0.1	host/local/gateway
172.28.0.2	sql
172.28.0.3	solr
172.28.0.4	xconnect
172.28.0.5	xconnect-automationengine
172.28.0.6	xconnect-indexworker
172.28.0.7	reserved for cd
172.28.0.8	cm
172.28.0.9	commerce-authoring

Add entries to your local hosts file to be able to connect to the listed instances from your local machine, you will probably only need add an entry for the cm (172.28.0.8 sitecore.sc) and commerce-authoring (172.28.0.9 authoring.commerce.sc)

Note that the compose file assumes that you've got the images build on your local, add remotes if they are on a remote repo

Transformations will be performed on container spin-up:
- Provide the correct url to the identity server that is running on your local in ".\startup\transforms\commerce-authoring\inetpub\wwwroot\Authoring\wwwroot\config.json"
- Provide the certificates used by the identity server to the commerce-authoring engine by adding them to "startup\certificates\commerce-authoring" (export them from your local)
	Make sure that "root" is mentioned in the filename of the root certificate
	Make sure that "my" is mentioned in the filename of the certificate which is used as SSL certificate by the IIS binding for the identityserver

Spin up the docker containers with a "docker-compose up"

Browse to sitecore.sc, after a few minutes you'll see the the well known sitecore lady, checking her phone

Login to sitecore, populate schema's and reindex all indexes

Perform a "Bootstrap Siteore Commerce" with postman

Stop the commerce-authoring container (with a "docker stop xc_commerce-authoring_1)
Restart the commerce-authoring container (with a "docker start xc_commerce-authoring_1)

Perform an "Ensure\Sync default content paths" with postman, check the status with "Check Long Running Command Status"
Perform an "Initialize Environment" with postman, check the status with "Check Long Running Command Status"

Add an item with template "/sitecore/templates/Commerce/Catalog/Commerce Catalog Folder" to the "sitecore/Content/Home" item, check the "Habitat_Master" checkbox. Voila... There's the commerce catalog!


ToDO:
Dockerized identityserver
Dockerized BizFX
Dockerized Redis
Optimizing current images/variants, get rid of SIF
What about the other commerce roles (minions, ops, shops)
Provide variants with JSS, SXA, CXA...
And lots more that I didn't think of right now