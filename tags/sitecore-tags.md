# Official Sitecore images on scr.sitecore.com
This document provides a list of the images and tags available on the official Sitecore container registry hosted at scr.sitecore.com. 
The Sitecore container images are structured in namespaces according to product line:  
- **[sxp](#sxp):** Contains all *Sitecore Experience Platform (SXP)* image repositories. Primary platform repositories are found at the root.  
- **[sxp/nonproduction](#sxpnonproduction):** Images for SXP supporting roles intended for development and testing. No production support is provided for images labeled as nonproduction. 
- **[sxc](#sxc):** Contains all *Sitecore Experience Commerce (SXC)* image repositories. Primary SXC repositories are found at the root.  
- **[sxc/nonproduction](#sxcnonproduction):** Images for SXC supporting roles intended for development and testing. No production support is provided for images labeled as nonproduction..  
- **[sxp/modules](#sxpmodules):** Contains image repositories for SXP-specific modules.  
- **[tools](#tools):** Tools to support Sitecore products  
- **[demo](#demo):** Images in this namespace are built from the https://github.com/sitecore/Sitecore.Demo.Platform GitHub repository and are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details.  
- **[demo/base](#demobase):** Images in this namespace are built from the https://github.com/sitecore/Sitecore.Demo.Base GitHub repository and are base images for the /demo/lighthouse images. They are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details.  
- **[community](#community):** Images in this namespace are built from the https://github.com/sitecore/docker-images GitHub repository and are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details.  
- **[community/modules](#communitymodules):** Images in this namespace are module asset images built from the https://github.com/sitecore/docker-images GitHub repository and are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details. 
## community/modules 
Images in this namespace are module asset images built from the https://github.com/sitecore/docker-images GitHub repository and are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details. 
### custom-cmp-xm-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:aaeb381219a2a57e81b4b21fc1684615b5ce57494c4ddd03d138506f65036608 | 10/27/2020 22:11:44  | 11/22/2020 15:49:47 |
### custom-cmp-xp-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:0d2e235c368a9703a4678f52d8318947e844036a069bfa45f61b914f6d6d441f | 10/23/2020 15:50:42  | 11/22/2020 15:49:20 |
### custom-dam-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:0cdf663a40de7b56957b13d6e80aa3904b2462bc6ff687607d058d050134d312 | 10/23/2020 15:51:07  | 11/22/2020 15:50:32 |
### custom-def-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:f61a91d493ff91199e6de17ca3ee0937d2eaeae049bf8cdcb1541de1362ce8ea | 10/23/2020 15:51:34  | 11/22/2020 15:50:02 |
### custom-def-d365-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:ac1ad6a7ca252304bade833c328726bd54c7b6d83e4a0aab0a70b36aea0f8f67 | 10/23/2020 15:51:59  | 11/22/2020 15:48:07 |
### custom-def-ma-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:c2b66a88d32cb330da436f3925eb03dd022d6ce4da31ac1b57e6673e9f663389 | 10/27/2020 22:12:28  | 11/22/2020 15:50:17 |
### custom-def-sfdc-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:67cbcdb3496a106f2b42f48abcce399534e776deaead2a801f56867c8ab52989 | 10/23/2020 15:52:25  | 11/22/2020 15:50:47 |
### custom-ps-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:942f2dacaa3adba15d5cdd327cab9e1beb2a029226e41252cd85226da1b2a5ff | 10/23/2020 15:55:25  | 11/22/2020 15:49:34 |
### custom-sfcrm-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:67cbcdb3496a106f2b42f48abcce399534e776deaead2a801f56867c8ab52989 | 10/27/2020 22:09:38  | 11/22/2020 15:48:22 |
### custom-sfcrm-ts-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:92af773399b004cc3d562f6390d49322de45bfadf6b6da2aa57eb47b98c1471d | 10/27/2020 22:08:08  | 11/22/2020 15:47:18 |
### custom-sfmc-bde-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:74ee0b4b62a46e11598156df864babf62c53dcca53e2c3a5dbd71a3243add1ed | 10/23/2020 15:55:51  | 11/22/2020 15:48:50 |
### custom-sfmc-bde-ma-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:caee69b1693a61098240f3e2b1b3ba962935ce03af424f776fc6d1235a9b5066 | 10/27/2020 22:08:38  | 11/22/2020 15:47:36 |
### custom-sfmc-bde-ts-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:cc98871d4856167dcd0129c5ab8355527bf8d3d99cb21efe860a96bf83f31c76 | 10/27/2020 22:10:36  | 11/22/2020 15:49:04 |
### custom-sfmc-ce-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:2494de2e5c4b3b1773a5982446eb3c9c9f186f4a961b6a6aa2761791e466c36f | 10/23/2020 15:56:21  | 11/22/2020 15:48:36 |
### custom-xgenerator-assets
Tag         | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809 | amd64           | windows | sha256:a2d55f68a0a32da27fc0dac48f10c5c4c680f25fdd409c028f5b9964463bfb82 | 10/23/2020 15:56:48  | 11/22/2020 15:47:51 |
## community 
Images in this namespace are built from the https://github.com/sitecore/docker-images GitHub repository and are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details. 
### sitecore-custom-def-tenant-service
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:ae6a7bd4583a8b877d1b5afa063aa433d5161619f1c3c721b8dd1d09fb6b83a9 | 10/27/2020 22:20:07  | 11/16/2020 17:22:42 |
### sitecore-custom-ps
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:fcace4f73396db585e8325783d2a6a79cd8c4b1c01063cf789ab5f7c4b906edc | 10/23/2020 15:58:08  | 11/16/2020 17:23:03 |
### sitecore-xm1-custom-spe-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:ddf1b92747a662b6d0095999dc101142ab1cdd64d24d6f53e9cef4ecc6cf016f | 10/27/2020 22:18:35  | 11/16/2020 17:19:37 |
### sitecore-xm1-custom-spe-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:f762420a17dbda4f8cf50eb1afe6218665943c0e37d04c65bf81bf015f1fcc6b | 10/27/2020 22:17:07  | 11/16/2020 17:18:05 |
### sitecore-xm1-custom-spe-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:29ad5e235c60830b2ac84987600d20fe055b8f5e6145c17d62ccae75ef9eed29 | 10/27/2020 22:15:03  | 11/16/2020 17:15:47 |
### sitecore-xm1-custom-spe-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:433c6623f0c4bf5398c5ec7feedb245e997d1bf08698c32116df2f056ad48e88 | 10/27/2020 22:17:37  | 11/16/2020 17:18:29 |
### sitecore-xm1-custom-spe-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:e9981debc62d3dcbefc866ab64f8f40d678c7b86674cc3442082b48acab91ee4 | 10/27/2020 22:24:23  | 11/16/2020 17:26:51 |
### sitecore-xm1-custom-sxa-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:cdb3cf8c0dbfc0397d3a2398413d0149b2b795a56791aeb2c45f137d28b3a219 | 10/27/2020 22:25:29  | 11/16/2020 17:27:44 |
### sitecore-xm1-custom-sxa-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:10addbc4c192bff48d3e2c5348f857917c5de68d90da8337c20a01a12e0c0d4e | 10/27/2020 22:23:20  | 11/16/2020 17:26:16 |
### sitecore-xm1-custom-sxa-jss1400-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:5ae071d7fe9fc84b9968006d595bd82b6ced1ef4a9699cd15dfdc98a6a3b20f6 | 11/05/2020 09:07:33  | 11/16/2020 17:42:17 |
### sitecore-xm1-custom-sxa-jss1400-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:7d366aa34a14bcd1e87f308e29f9fb33d0cbf726113ca3beecf79de10ef9f140 | 11/05/2020 09:02:41  | 11/16/2020 17:38:34 |
### sitecore-xm1-custom-sxa-jss1400-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:bcbed8b88524e1702f584595b7edb9075b07d7467544a0f9acd2b8ff84bc59ec | 11/05/2020 08:58:10  | 11/16/2020 17:35:26 |
### sitecore-xm1-custom-sxa-jss1400-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:8fd181ae885dee945c55ef7221ea5d17700200a4a94ab6de3bb89db01875e683 | 11/05/2020 09:04:21  | 11/16/2020 17:39:44 |
### sitecore-xm1-custom-sxa-jss1400-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:9eafc1f6473b45ef4737939882aae7bcec1d6b51313aa2115623dd8f60c508fe | 11/05/2020 09:19:06  | 11/16/2020 17:52:05 |
### sitecore-xm1-custom-sxa-jss1400-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:4abafd59704250d55ffd5a5b3207e04e7cea790ac554786a400ca785a9051d01 | 11/05/2020 09:14:33  | 11/16/2020 17:49:13 |
### sitecore-xm1-custom-sxa-jss1400-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:775b28ec8e42affd61f7fc0efd4bfe1cd055e1d8edff5c81e39c779e4253ba8b | 11/05/2020 09:20:59  | 11/16/2020 17:53:30 |
### sitecore-xm1-custom-sxa-jss1500-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:c0775df98d1f1999dcf460a120d316075d63191a57ef1c60d67fe5648257afe5 | 11/05/2020 09:08:08  | 11/16/2020 17:42:33 |
### sitecore-xm1-custom-sxa-jss1500-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:2daba14606d0b88a53e450287e67da2bf3a53fb832ea78e5b63a281563d3e565 | 11/05/2020 09:03:20  | 11/16/2020 17:38:53 |
### sitecore-xm1-custom-sxa-jss1500-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:3ff3b478a123bb0d23ead8f359cbf22e007f42ff2bac168333fa26d6e1cddf0f | 11/05/2020 08:58:44  | 11/16/2020 17:35:46 |
### sitecore-xm1-custom-sxa-jss1500-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:039d7ea0410db41917de2e59a608a6f6e72909d714949083ba378a0a80a478ff | 11/05/2020 09:04:49  | 11/16/2020 17:40:22 |
### sitecore-xm1-custom-sxa-jss1500-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:5f1dbfe3f42c8741add01b13db37d22052d5a8b7048bba56f084d3c25c166f70 | 11/05/2020 09:19:42  | 11/16/2020 17:52:23 |
### sitecore-xm1-custom-sxa-jss1500-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:ef4ec72feb6b34c0cddd7769ceaeafb444f341db0401446ce6c4e1ff51f25ea7 | 11/05/2020 09:15:14  | 11/16/2020 17:49:29 |
### sitecore-xm1-custom-sxa-jss1500-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:6153e97f4f7a24aa3b3539dd4bdb45bba078e9328e22755859f49368e685b287 | 11/05/2020 09:21:29  | 11/16/2020 17:53:48 |
### sitecore-xm1-custom-sxa-jss-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:c0775df98d1f1999dcf460a120d316075d63191a57ef1c60d67fe5648257afe5 | 10/27/2020 22:32:15  | 11/16/2020 17:42:00 |
### sitecore-xm1-custom-sxa-jss-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:2daba14606d0b88a53e450287e67da2bf3a53fb832ea78e5b63a281563d3e565 | 10/27/2020 22:29:38  | 11/16/2020 17:38:16 |
### sitecore-xm1-custom-sxa-jss-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:3ff3b478a123bb0d23ead8f359cbf22e007f42ff2bac168333fa26d6e1cddf0f | 10/27/2020 22:28:01  | 11/16/2020 17:34:42 |
### sitecore-xm1-custom-sxa-jss-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:039d7ea0410db41917de2e59a608a6f6e72909d714949083ba378a0a80a478ff | 10/27/2020 22:30:43  | 11/16/2020 17:39:26 |
### sitecore-xm1-custom-sxa-jss-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:5f1dbfe3f42c8741add01b13db37d22052d5a8b7048bba56f084d3c25c166f70 | 10/27/2020 22:36:12  | 11/16/2020 17:51:44 |
### sitecore-xm1-custom-sxa-jss-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:ef4ec72feb6b34c0cddd7769ceaeafb444f341db0401446ce6c4e1ff51f25ea7 | 10/27/2020 22:34:57  | 11/16/2020 17:48:31 |
### sitecore-xm1-custom-sxa-jss-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:6153e97f4f7a24aa3b3539dd4bdb45bba078e9328e22755859f49368e685b287 | 10/27/2020 22:36:42  | 11/16/2020 17:52:41 |
### sitecore-xm1-custom-sxa-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:7be9ac348e5ba64884944033ff5d8eae7c16d14cdb951c309a1a513f4117c06e | 10/27/2020 22:22:10  | 11/16/2020 17:25:04 |
### sitecore-xm1-custom-sxa-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:4c115a39a4359d7c59575f99bc55d60636a902c7e016fa278d70051452d751b1 | 10/27/2020 22:23:51  | 11/16/2020 17:26:35 |
### sitecore-xm1-custom-sxa-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:8680e5206bc27002589b23e014bddbadb2528a6eaf53b2ad522bd042b336aa9a | 10/27/2020 22:30:10  | 11/16/2020 17:39:10 |
### sitecore-xm1-custom-sxa-solr
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:294ba36df7c971ddcd2b18d7dc6ee58a9e5ae4f1bc18925537e6ddfa80c24c4e | 10/27/2020 22:16:15  | 11/16/2020 17:17:23 |
### sitecore-xm1-custom-sxa-solr-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:8ecb1b0231d26346cec47f58db0dc32629b64adddcfeba77b28eb517d095c263 | 10/27/2020 22:19:41  | 11/16/2020 17:22:25 |
### sitecore-xp0-custom-spe-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:f418ed3195c5da576e4e82fd43099a6925eb4603567a7cd47e9c2b0173a49599 | 10/23/2020 16:16:47  | 11/16/2020 17:12:11 |
### sitecore-xp0-custom-spe-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:573fe46173827ddf94028f7744a77d6c5220897697436418825b71db2321e23d | 10/23/2020 16:19:03  | 11/16/2020 17:16:04 |
### sitecore-xp0-custom-sxa-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:9f28cb8ecec052314b582680e0f68b865e4533a4de7abed17cc6326409ad8813 | 10/23/2020 16:17:24  | 11/16/2020 17:23:25 |
### sitecore-xp0-custom-sxa-jss1400-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:eac42ad250b40ed3af995813d81d8867f7db1ea3fd50311bdc1d7648e3833043 | 11/05/2020 08:53:22  | 11/16/2020 17:29:41 |
### sitecore-xp0-custom-sxa-jss1400-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:4d9b863a44fac119a50c4e30627f16d1bcae0de8f18b3642475f11e5e27fd6d7 | 11/05/2020 08:59:31  | 11/16/2020 17:36:22 |
### sitecore-xp0-custom-sxa-jss1400-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:3d19432f0fa403086709759d937cdee5348451796388362184572f8e7803f3b0 | 11/05/2020 09:10:45  | 11/16/2020 17:45:11 |
### sitecore-xp0-custom-sxa-jss1400-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:76e68b1a5e3b08391bae7f1bda4041f1ce4357d5933fdf4d26b77253d5604a10 | 11/05/2020 09:16:02  | 11/16/2020 17:50:04 |
### sitecore-xp0-custom-sxa-jss1500-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:f2ffa47a34a381005ed79e54c2151c4c192c0e30e5bef6f414fefc7cd5de3d54 | 11/05/2020 08:54:22  | 11/16/2020 17:30:02 |
### sitecore-xp0-custom-sxa-jss1500-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:2736cfbfc23cfa6d416de2ad376496969a87d05306eeb5595f06e815b2fad30b | 11/05/2020 09:00:03  | 11/16/2020 17:36:36 |
### sitecore-xp0-custom-sxa-jss1500-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:daad7a68a79a24d1b1030365ca1f949f4056c34cdb69d91ad30750dbcbecaf8c | 11/05/2020 09:11:22  | 11/16/2020 17:45:37 |
### sitecore-xp0-custom-sxa-jss1500-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:462a1369078123cde8817a16e923553a43951ada3493071a28ecb2fde39c6b4f | 11/05/2020 09:16:34  | 11/16/2020 17:50:31 |
### sitecore-xp0-custom-sxa-jss-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:f2ffa47a34a381005ed79e54c2151c4c192c0e30e5bef6f414fefc7cd5de3d54 | 10/23/2020 16:17:59  | 11/16/2020 17:28:22 |
### sitecore-xp0-custom-sxa-jss-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:2736cfbfc23cfa6d416de2ad376496969a87d05306eeb5595f06e815b2fad30b | 10/23/2020 16:20:33  | 11/16/2020 17:36:04 |
### sitecore-xp0-custom-sxa-jss-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:daad7a68a79a24d1b1030365ca1f949f4056c34cdb69d91ad30750dbcbecaf8c | 10/23/2020 16:18:35  | 11/16/2020 17:44:37 |
### sitecore-xp0-custom-sxa-jss-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:462a1369078123cde8817a16e923553a43951ada3493071a28ecb2fde39c6b4f | 10/23/2020 16:21:02  | 11/16/2020 17:49:46 |
### sitecore-xp0-custom-sxa-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:761273c2b45b20a79f6fd7166e414ff5ca4c263eb406617c37968e169cb18c12 | 10/23/2020 16:19:33  | 11/16/2020 17:25:20 |
### sitecore-xp0-custom-sxa-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:71e90f3588c6f043aa82fd4cddcb2316fc364206ebaa47c900290d872386bcaf | 10/23/2020 16:20:03  | 11/16/2020 17:36:52 |
### sitecore-xp0-custom-sxa-solr
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:0e37fd5d38a2233786fd4765926aa4fdaf903afdf3ef2be1508e3765260bec61 | 10/23/2020 16:21:32  | 11/16/2020 17:14:35 |
### sitecore-xp1-custom-spe-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:16b0155ddb7c465ea1318c726bd76d0c4c062a50c16446f1590ed51ece03ff99 | 10/23/2020 16:03:33  | 11/16/2020 17:20:35 |
### sitecore-xp1-custom-spe-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:faf1876f1c7cd001e7203b2fa396c6fbeb22c73cdc5ad9e7815060016f9621f2 | 10/23/2020 15:59:58  | 11/16/2020 17:17:00 |
### sitecore-xp1-custom-spe-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:573fe46173827ddf94028f7744a77d6c5220897697436418825b71db2321e23d | 10/23/2020 16:06:42  | 11/16/2020 17:13:53 |
### sitecore-xp1-custom-spe-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:5fc38f4a8adf6a7fa30ff7f1e9a5e2dfdf58c5f45519cb1f28e3ee709dd308a7 | 10/23/2020 16:11:31  | 11/16/2020 17:18:50 |
### sitecore-xp1-custom-spe-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:17b26e83ba18a0a94c7459a802e4d3de6f9b7098db946c5185523f2ef91f0fea | 10/23/2020 16:12:00  | 11/16/2020 17:27:25 |
### sitecore-xp1-custom-sxa-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:c51db4199e6cb0784ac7542a719759cf07a63685782a569b53a358fe18cd91dd | 10/23/2020 16:04:41  | 11/16/2020 17:28:04 |
### sitecore-xp1-custom-sxa-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:86235cafb64f67ae26dbf8691e9f905d755a5e6ccfa264edd68bff8b0c069404 | 10/23/2020 16:00:39  | 11/16/2020 17:25:43 |
### sitecore-xp1-custom-sxa-jss1400-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:04e369254713b03303ec5c2e7be342b2e6c3fd1b0032c9a35bbf11a296e7260d | 11/05/2020 09:08:58  | 11/16/2020 17:43:23 |
### sitecore-xp1-custom-sxa-jss1400-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:636cb070db8d1facf2d1857eb625135ae91709813132f5064ee390abb6be6de7 | 11/05/2020 09:01:13  | 11/16/2020 17:37:27 |
### sitecore-xp1-custom-sxa-jss1400-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:4d9b863a44fac119a50c4e30627f16d1bcae0de8f18b3642475f11e5e27fd6d7 | 11/05/2020 08:56:21  | 11/16/2020 17:33:43 |
### sitecore-xp1-custom-sxa-jss1400-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:17a4b9fd2ee366d7e4c55830dd77003ab91b7efce5b5dec711b64c3f3b47fd62 | 11/05/2020 09:05:52  | 11/16/2020 17:41:23 |
### sitecore-xp1-custom-sxa-jss1400-ps-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:fc80be53018fb407ac8c836aff47b3635cd9671e1859267a99d0cf2bc140653b | 11/05/2020 09:23:43  | 11/16/2020 17:55:53 |
### sitecore-xp1-custom-sxa-jss1400-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:9f2f630135774b4b8fa5309039067a28f4f890072c1d33e9889dc14bfcf59697 | 11/05/2020 09:17:31  | 11/16/2020 17:51:08 |
### sitecore-xp1-custom-sxa-jss1400-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:76e68b1a5e3b08391bae7f1bda4041f1ce4357d5933fdf4d26b77253d5604a10 | 11/05/2020 09:12:45  | 11/16/2020 17:47:26 |
### sitecore-xp1-custom-sxa-jss1400-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:9741c11c99275cd2f9726b2976caa96be4fa71dd7ef442f00b9407464ac1f33f | 11/05/2020 09:22:19  | 11/16/2020 17:54:41 |
### sitecore-xp1-custom-sxa-jss1500-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:e250ee9ee18cd337b1042148915843eb8bd000a583bc950af7f3b42193ed4586 | 11/05/2020 09:09:35  | 11/16/2020 17:43:40 |
### sitecore-xp1-custom-sxa-jss1500-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:d4ad316bf2bd013559fe9134f841c3c4f3483f8b7809c10a76c5ff37956912c5 | 11/05/2020 09:01:48  | 11/16/2020 17:37:57 |
### sitecore-xp1-custom-sxa-jss1500-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:2736cfbfc23cfa6d416de2ad376496969a87d05306eeb5595f06e815b2fad30b | 11/05/2020 08:56:55  | 11/16/2020 17:33:59 |
### sitecore-xp1-custom-sxa-jss1500-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:91612677b9448dcdb49386325d11c9492494792acc7285d5ff27822cbfb8dfb4 | 11/05/2020 09:06:20  | 11/16/2020 17:41:40 |
### sitecore-xp1-custom-sxa-jss1500-ps-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:295a3801d8e03325fa198dfadf11caa71a46ef2251df7b76408f44bfd46735d5 | 11/05/2020 09:24:19  | 11/16/2020 17:56:10 |
### sitecore-xp1-custom-sxa-jss1500-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:1fe10afa08b46d7542f6a49b7c566ae7f704ed81fd3f36a71d0065e8980561f4 | 11/05/2020 09:18:11  | 11/16/2020 17:51:25 |
### sitecore-xp1-custom-sxa-jss1500-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:462a1369078123cde8817a16e923553a43951ada3493071a28ecb2fde39c6b4f | 11/05/2020 09:13:20  | 11/16/2020 17:47:45 |
### sitecore-xp1-custom-sxa-jss1500-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:0a2f30ed442645b3aa2382ca332f24d6d129271d984ead8f5179161fde54d62f | 11/05/2020 09:22:50  | 11/16/2020 17:54:57 |
### sitecore-xp1-custom-sxa-jss-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:e250ee9ee18cd337b1042148915843eb8bd000a583bc950af7f3b42193ed4586 | 10/23/2020 16:05:13  | 11/16/2020 17:42:53 |
### sitecore-xp1-custom-sxa-jss-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:d4ad316bf2bd013559fe9134f841c3c4f3483f8b7809c10a76c5ff37956912c5 | 10/23/2020 16:02:25  | 11/16/2020 17:37:11 |
### sitecore-xp1-custom-sxa-jss-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:2736cfbfc23cfa6d416de2ad376496969a87d05306eeb5595f06e815b2fad30b | 10/23/2020 16:09:40  | 11/16/2020 17:32:50 |
### sitecore-xp1-custom-sxa-jss-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:91612677b9448dcdb49386325d11c9492494792acc7285d5ff27822cbfb8dfb4 | 10/23/2020 16:14:27  | 11/16/2020 17:40:54 |
### sitecore-xp1-custom-sxa-jss-ps-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:295a3801d8e03325fa198dfadf11caa71a46ef2251df7b76408f44bfd46735d5 | 10/23/2020 16:05:48  | 11/16/2020 17:55:24 |
### sitecore-xp1-custom-sxa-jss-ps-cm
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:1fe10afa08b46d7542f6a49b7c566ae7f704ed81fd3f36a71d0065e8980561f4 | 10/23/2020 16:03:00  | 11/16/2020 17:50:51 |
### sitecore-xp1-custom-sxa-jss-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:462a1369078123cde8817a16e923553a43951ada3493071a28ecb2fde39c6b4f | 10/23/2020 16:10:36  | 11/16/2020 17:46:32 |
### sitecore-xp1-custom-sxa-jss-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:0a2f30ed442645b3aa2382ca332f24d6d129271d984ead8f5179161fde54d62f | 10/23/2020 16:14:58  | 11/16/2020 17:54:24 |
### sitecore-xp1-custom-sxa-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:761273c2b45b20a79f6fd7166e414ff5ca4c263eb406617c37968e169cb18c12 | 10/23/2020 16:07:46  | 11/16/2020 17:24:21 |
## community 
Images in this namespace are built from the https://github.com/sitecore/docker-images GitHub repository and are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details. 
### sitecore-xp1-custom-sxa-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:0fc134557af40b4894b76f7a85890dae081101931618b1ad365513899075e5e2 | 10/23/2020 16:13:22  | 11/16/2020 17:27:07 |
### sitecore-xp1-custom-sxa-ps-cd
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:cd29e28bbe590295ea7c11a35e54f1b9a136fbb461e55dda1a62adb70df216d2 | 10/27/2020 22:33:21  | 11/16/2020 17:44:13 |
### sitecore-xp1-custom-sxa-ps-mssql
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:71e90f3588c6f043aa82fd4cddcb2316fc364206ebaa47c900290d872386bcaf | 10/23/2020 16:08:45  | 11/16/2020 17:30:53 |
### sitecore-xp1-custom-sxa-ps-mssql-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:ff037d4ca924a1f65747930be83f7afacf61648d90730a4bedf883f437aedae5 | 10/23/2020 16:13:52  | 11/16/2020 17:40:39 |
### sitecore-xp1-custom-sxa-solr
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:0e37fd5d38a2233786fd4765926aa4fdaf903afdf3ef2be1508e3765260bec61 | 10/23/2020 16:15:34  | 11/16/2020 17:21:42 |
### sitecore-xp1-custom-sxa-solr-init
Tag             | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
--------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019 | amd64           | windows | sha256:726d38087590727eec915f805ae0ab75cbc3bba2569f14fc071d6c5102c80996 | 10/23/2020 16:16:13  | 11/16/2020 17:15:00 |
## demo/base 
Images in this namespace are built from the https://github.com/sitecore/Sitecore.Demo.Base GitHub repository and are base images for the /demo/lighthouse images. They are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details. 
### lighthouse-xp0-modules-base-cm
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:e1b88072970fd2ec87b1a981c2c2abc4b46e87a205a94c2dd4927109e16ed975 | 10/27/2020 22:06:46  | 11/20/2020 23:50:55 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:e1b88072970fd2ec87b1a981c2c2abc4b46e87a205a94c2dd4927109e16ed975 | 10/27/2020 22:06:28  | 11/20/2020 23:50:41 |
### lighthouse-xp0-modules-base-mssql
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:f7aee9f889881250d28aa71fe177b54f39a41bb00577f0c9a6d6725c84a63a08 | 10/27/2020 22:05:52  | 11/20/2020 23:44:50 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:f7aee9f889881250d28aa71fe177b54f39a41bb00577f0c9a6d6725c84a63a08 | 10/27/2020 22:05:33  | 11/20/2020 23:44:34 |
### lighthouse-xp1-modules-base-cd
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:b108f5b5ef9581becaa50bfe4708448533868a4d5584ea2d22f0a1cbc153de27 | 10/27/2020 22:07:35  | 11/20/2020 23:52:44 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:b108f5b5ef9581becaa50bfe4708448533868a4d5584ea2d22f0a1cbc153de27 | 10/27/2020 22:07:18  | 11/20/2020 23:52:31 |
## demo 
Images in this namespace are built from the https://github.com/sitecore/Sitecore.Demo.Platform GitHub repository and are meant to support non-production training, experimentation, and demonstration scenarios. Support for these images is community-driven and not provided by Sitecore Support. Please see the GitHub repository for more details. 
### lighthouse-id
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:071f2b6eef95502a46bf1ba2de66919f8833f66c6811226acb259b20e4e9b1b2 | 10/23/2020 15:26:07  | 11/27/2020 19:57:41 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:071f2b6eef95502a46bf1ba2de66919f8833f66c6811226acb259b20e4e9b1b2 | 10/23/2020 15:25:50  | 11/27/2020 19:57:29 |
### lighthouse-init
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:a7385bdc66de80639690afbfd7ae7a6f2e7fd5e3ce7ef394d97bf813698c2b55 | 10/23/2020 15:27:13  | 11/27/2020 19:58:11 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:a7385bdc66de80639690afbfd7ae7a6f2e7fd5e3ce7ef394d97bf813698c2b55 | 10/23/2020 15:26:56  | 11/27/2020 19:57:59 |
### lighthouse-mssql
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:a6b0ec45f116ca4e178b973259d8a396601675a514224923036dad481aa1ac8b | 10/23/2020 15:36:30  | 11/27/2020 20:01:23 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:a6b0ec45f116ca4e178b973259d8a396601675a514224923036dad481aa1ac8b | 10/23/2020 15:36:13  | 11/27/2020 20:01:09 |
### lighthouse-ps
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:73c87cac61f17dad0a7e99f49f338a44ce704fcd5d6e54115608a77a1af9e2c3 | 10/23/2020 15:39:08  | 11/27/2020 20:01:53 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:73c87cac61f17dad0a7e99f49f338a44ce704fcd5d6e54115608a77a1af9e2c3 | 10/23/2020 15:38:52  | 11/27/2020 20:01:42 |
### lighthouse-solr
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:0d371164573e24288344ffa2503ab1f0eb0cb45b2dd97b6359522c286ee618cf | 10/23/2020 15:40:29  | 11/27/2020 20:02:21 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:0d371164573e24288344ffa2503ab1f0eb0cb45b2dd97b6359522c286ee618cf | 10/23/2020 15:40:15  | 11/27/2020 20:02:10 |
### lighthouse-xp0-cd
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:d802923613da06d64dca18573dcc3d08696f9ed046b5c9879b45bf18d0315119 | 10/23/2020 15:45:34  | 11/27/2020 20:04:25 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:d802923613da06d64dca18573dcc3d08696f9ed046b5c9879b45bf18d0315119 | 10/23/2020 15:45:16  | 11/27/2020 20:04:12 |
### lighthouse-xp0-cm
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:14026011d1a1838350b9338144f2787175a536f219c4da2c58f35928ede68f9f | 10/23/2020 15:48:40  | 11/27/2020 20:05:41 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:14026011d1a1838350b9338144f2787175a536f219c4da2c58f35928ede68f9f | 10/23/2020 15:48:20  | 11/27/2020 20:05:27 |
### lighthouse-xp0-xconnect
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:0aa15dd72ec238925c8f6241ab8fc0981372b50db2c5a21d7766349e446b3828 | 10/23/2020 15:49:31  | 11/27/2020 20:06:07 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:0aa15dd72ec238925c8f6241ab8fc0981372b50db2c5a21d7766349e446b3828 | 10/23/2020 15:49:14  | 11/27/2020 20:05:56 |
### lighthouse-xp0-xdbsearchworker
Tag                    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
---------------------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-ltsc2019        | amd64           | windows | sha256:d93d24a94f1966a5c56d29df1dbfea1235c53da2d1a4a18bddae1082bc81389a | 10/23/2020 15:50:20  | 11/27/2020 20:06:32 |
10.0.0-ltsc2019-1000.0 | amd64           | windows | sha256:d93d24a94f1966a5c56d29df1dbfea1235c53da2d1a4a18bddae1082bc81389a | 10/23/2020 15:50:02  | 11/27/2020 20:06:22 |
## sxc/nonproduction 
This namespace includes supporting images for *Sitecore Experience Commerce (SXC)*. supporting roles intended for development and testing. No production support is provided for images labeled as nonproduction. 
### sitecore-xc0-mssql
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:cea9d368cce240efc72fd16c8eebdfad3b64a19f33d60658e9daff88118c7ed2 | 08/14/2020 09:57:26  | 10/27/2020 12:36:18 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:77c77650fa61bca4fe7bb9e3a9fca9c5ce84f257d3ee60e8d340083a662b3296 | 10/27/2020 13:28:57  | 11/19/2020 14:48:39 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:fe4b2c7a719935f018b0569276be19774989b3268098ef3b3fba864cce081ec1 | 11/19/2020 15:30:34  | 11/19/2020 15:30:34 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:a91d14cc89d2b6371de2a231c5d936bccdbf598c2ca919185360bd09234f1aa2 | 08/14/2020 11:42:22  | 11/19/2020 13:38:32 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:417449433f287755b6db29177a8745516389e6f98dccf6a89c2f2094eb06d81b | 08/14/2020 11:42:11  | 08/14/2020 11:42:11 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:4ed863c7510a7b8cf1dbdd8bc35b98b392437c2c3e99232dfdaf8aa08a52c8b5 | 08/14/2020 11:02:07  | 08/14/2020 11:02:07 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:e41807b1b36e97b50281e2a036223e2da8329078823077a32b4b4756607df5b6 | 10/05/2020 18:14:52  | 10/05/2020 18:14:52 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:1aac632fe9bfcabe3c3f174be8c4c21db2faa646f1501eefe467cd85d73083ca | 10/05/2020 17:31:20  | 10/05/2020 17:31:20 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:cb5bfab2561a1346b81fa16d9dcc61c22171de3fc1135538befc1b54479e7621 | 10/27/2020 13:03:24  | 10/27/2020 13:03:24 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:cea9d368cce240efc72fd16c8eebdfad3b64a19f33d60658e9daff88118c7ed2 | 10/27/2020 12:36:07  | 10/27/2020 12:36:07 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:28194317f3decd26360ce5e05ada57d7009a98fbe30b27bdb299e22b1e73895b | 10/27/2020 13:28:45  | 10/27/2020 13:28:45 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:a91d14cc89d2b6371de2a231c5d936bccdbf598c2ca919185360bd09234f1aa2 | 11/19/2020 13:38:19  | 11/19/2020 13:38:19 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:77c77650fa61bca4fe7bb9e3a9fca9c5ce84f257d3ee60e8d340083a662b3296 | 11/19/2020 14:48:27  | 11/19/2020 14:48:27 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:fe4b2c7a719935f018b0569276be19774989b3268098ef3b3fba864cce081ec1 | 11/19/2020 15:30:20  | 11/19/2020 15:30:20 |
### sitecore-xc0-solr
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:56802838a4d2873cce2368fe46d0d9e4c3f6a6dc47f039ddf9aaf0ceb839fbec | 08/14/2020 09:58:12  | 10/27/2020 12:36:50 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:6dfe9c9c62b58389063ea8a950b47ffec9dba537e9f3148a7e6c65f9fd9699b6 | 10/27/2020 13:29:26  | 11/19/2020 14:49:14 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:0472df2f2435c8275b3783d89d3b1cb6c1b47fb7c844a624db0ec4e6c5489752 | 11/19/2020 15:31:18  | 11/19/2020 15:31:18 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:fe0947bdf52028c30659e29ca27bc251cb0cd2ae38ee3494b8f5492c797cf09a | 08/14/2020 11:42:49  | 11/19/2020 13:39:15 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:df37f6904e3196f1879b08bafb8ae065f3a9aaf3901b1a0c6863bb3ceb32244e | 08/14/2020 11:42:39  | 08/14/2020 11:42:39 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:7eae4f1af79d3f1730cf46d1a444542f0e7f2fc9721fd957e4983406bf816d01 | 08/14/2020 11:02:30  | 08/14/2020 11:02:30 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:e938e12d9d8ff84d4b9dc06f40b0e1eab8921a427d5ae5aebe8c7eb39f398734 | 10/05/2020 18:15:16  | 10/05/2020 18:15:16 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:d88f64d9e1f9f2420fcbb1daefd6e968899e561b567fa260d329d2466c92bcca | 10/05/2020 17:31:43  | 10/05/2020 17:31:43 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:36fbd07df688abf75053b053873a11cc25f5877d9cfe8acbe5179ac4c8124e7e | 10/27/2020 13:03:56  | 10/27/2020 13:03:56 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:56802838a4d2873cce2368fe46d0d9e4c3f6a6dc47f039ddf9aaf0ceb839fbec | 10/27/2020 12:36:39  | 10/27/2020 12:36:39 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:379f7518b10fc1aaf8b1aed28ddb53892050558b122bbda60bb8b0d2692bd426 | 10/27/2020 13:29:14  | 10/27/2020 13:29:14 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:fe0947bdf52028c30659e29ca27bc251cb0cd2ae38ee3494b8f5492c797cf09a | 11/19/2020 13:38:59  | 11/19/2020 13:38:59 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:6dfe9c9c62b58389063ea8a950b47ffec9dba537e9f3148a7e6c65f9fd9699b6 | 11/19/2020 14:49:00  | 11/19/2020 14:49:00 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:0472df2f2435c8275b3783d89d3b1cb6c1b47fb7c844a624db0ec4e6c5489752 | 11/19/2020 15:30:55  | 11/19/2020 15:30:55 |
### sitecore-xc1-mssql
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:28d35e9d7f4dcde66d2c0178bfaa118605bf693f51e8f81f8fa931089cdd527d | 08/14/2020 09:53:33  | 10/27/2020 12:33:18 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:36e8d7c27e6f8575cb8dc145e252db93129e9287b83044e31638c468f1f31708 | 10/27/2020 13:25:53  | 11/19/2020 14:44:17 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b06c0aafc6858a4acc18256e212808661aaa88eff9a27f1c23d3c465d1e1f5ca | 11/19/2020 15:27:46  | 11/19/2020 15:27:46 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:4e1805ba4f39d2f151c9eafe035a9ce8902c0f7e2ea3218371a37f1162c6574e | 08/14/2020 11:39:40  | 11/19/2020 13:34:08 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:05affa8be99329cdb92b495d50fb5d8daf9fd54b31990b4044402bb12540d3cf | 08/14/2020 11:39:28  | 08/14/2020 11:39:28 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:98d283e55f16a6657d21ad27f05954b5ce300f0292d60053c9181bd76563b6a4 | 08/14/2020 10:59:47  | 08/14/2020 10:59:47 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:b8574acb68345712a73f2ce14fc936ab3e63d4ed1a7d74f2a97c3c4c44cbf922 | 10/05/2020 18:11:16  | 10/05/2020 18:11:16 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:ff62c0120afa1ab85e6c45fe8c3074f9380900d79f2994bc97e4e5e23da6150e | 10/05/2020 17:29:02  | 10/05/2020 17:29:02 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:b2a48f0bf9682dfabec868e2bc876f6dcdedf798a34893e339aa71a4efeeef84 | 10/27/2020 13:00:58  | 10/27/2020 13:00:58 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:28d35e9d7f4dcde66d2c0178bfaa118605bf693f51e8f81f8fa931089cdd527d | 10/27/2020 12:33:05  | 10/27/2020 12:33:05 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:83cf07a98c8a7c7e4a769a60f38dcf4db53d601e4b38b2bb5743be89375a7d53 | 10/27/2020 13:25:38  | 10/27/2020 13:25:38 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:4e1805ba4f39d2f151c9eafe035a9ce8902c0f7e2ea3218371a37f1162c6574e | 11/19/2020 13:33:51  | 11/19/2020 13:33:51 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:36e8d7c27e6f8575cb8dc145e252db93129e9287b83044e31638c468f1f31708 | 11/19/2020 14:44:00  | 11/19/2020 14:44:00 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b06c0aafc6858a4acc18256e212808661aaa88eff9a27f1c23d3c465d1e1f5ca | 11/19/2020 15:27:31  | 11/19/2020 15:27:31 |
### sitecore-xc1-solr
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:57737cf815c77b4f046990b23a89cf5440a9429e1c352ee949ac8a24175b696a | 08/14/2020 09:55:11  | 10/27/2020 12:34:20 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:5ec19843135dadb55ddee58db074bbae1697630604b39aa188d3d5c7b43fe75e | 10/27/2020 13:27:19  | 11/19/2020 14:46:55 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:5a45a065c9c119bd1984a7c9e7f1450338a11d76c5b39c41104c618924a37dc2 | 11/19/2020 15:28:46  | 11/19/2020 15:28:46 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:2dc3df7a18f89285ceaed9a10b795ad77abbe3dbeabb0c0e2c23169b087d82f6 | 08/14/2020 11:40:59  | 11/19/2020 13:36:42 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:ce624cce502a721aee840c5f869b0228c10cb4d689809a36ba4a8e50793e3408 | 08/14/2020 11:40:49  | 08/14/2020 11:40:49 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:aed0d95208bbda1d479d845d71e1677be7f780dbcb23a78fe7ddee33dbbe7ba6 | 08/14/2020 11:00:44  | 08/14/2020 11:00:44 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:7e30747687826a26460af273989b2b924fa1387fe2b4ea285ae770ec3e8c6066 | 10/05/2020 18:12:53  | 10/05/2020 18:12:53 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:1467837c2f3a51165743db38aa65757d6bb51dab3d0a2014dae22b4c6248e940 | 10/05/2020 17:30:06  | 10/05/2020 17:30:06 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:97a5de539511de65a0621fce753fdfe0c093a2922dbcf9a1fb4842285f3a994d | 10/27/2020 13:01:51  | 10/27/2020 13:01:51 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:57737cf815c77b4f046990b23a89cf5440a9429e1c352ee949ac8a24175b696a | 10/27/2020 12:34:05  | 10/27/2020 12:34:05 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:8546e81403086780a6e0f864279e25c387bcb75e4321dcce0956be418df40f26 | 10/27/2020 13:27:06  | 10/27/2020 13:27:06 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:2dc3df7a18f89285ceaed9a10b795ad77abbe3dbeabb0c0e2c23169b087d82f6 | 11/19/2020 13:36:26  | 11/19/2020 13:36:26 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:5ec19843135dadb55ddee58db074bbae1697630604b39aa188d3d5c7b43fe75e | 11/19/2020 14:45:43  | 11/19/2020 14:45:43 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:5a45a065c9c119bd1984a7c9e7f1450338a11d76c5b39c41104c618924a37dc2 | 11/19/2020 15:28:34  | 11/19/2020 15:28:34 |
### xc1-mssql
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:cea9d368cce240efc72fd16c8eebdfad3b64a19f33d60658e9daff88118c7ed2 | 08/14/2020 09:55:56  | 10/27/2020 12:34:51 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:77c77650fa61bca4fe7bb9e3a9fca9c5ce84f257d3ee60e8d340083a662b3296 | 10/27/2020 13:27:54  | 11/19/2020 14:47:30 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:fe4b2c7a719935f018b0569276be19774989b3268098ef3b3fba864cce081ec1 | 11/19/2020 15:29:18  | 11/19/2020 15:29:18 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:a91d14cc89d2b6371de2a231c5d936bccdbf598c2ca919185360bd09234f1aa2 | 08/14/2020 11:41:27  | 11/19/2020 13:37:20 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:417449433f287755b6db29177a8745516389e6f98dccf6a89c2f2094eb06d81b | 08/14/2020 11:41:17  | 08/14/2020 11:41:17 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:4ed863c7510a7b8cf1dbdd8bc35b98b392437c2c3e99232dfdaf8aa08a52c8b5 | 08/14/2020 11:01:10  | 08/14/2020 11:01:10 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:e41807b1b36e97b50281e2a036223e2da8329078823077a32b4b4756607df5b6 | 10/05/2020 18:13:17  | 10/05/2020 18:13:17 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:1aac632fe9bfcabe3c3f174be8c4c21db2faa646f1501eefe467cd85d73083ca | 10/05/2020 17:30:35  | 10/05/2020 17:30:35 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:cb5bfab2561a1346b81fa16d9dcc61c22171de3fc1135538befc1b54479e7621 | 10/27/2020 13:02:22  | 10/27/2020 13:02:22 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:cea9d368cce240efc72fd16c8eebdfad3b64a19f33d60658e9daff88118c7ed2 | 10/27/2020 12:34:39  | 10/27/2020 12:34:39 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:28194317f3decd26360ce5e05ada57d7009a98fbe30b27bdb299e22b1e73895b | 10/27/2020 13:27:40  | 10/27/2020 13:27:40 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:a91d14cc89d2b6371de2a231c5d936bccdbf598c2ca919185360bd09234f1aa2 | 11/19/2020 13:37:04  | 11/19/2020 13:37:04 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:77c77650fa61bca4fe7bb9e3a9fca9c5ce84f257d3ee60e8d340083a662b3296 | 11/19/2020 14:47:16  | 11/19/2020 14:47:16 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:fe4b2c7a719935f018b0569276be19774989b3268098ef3b3fba864cce081ec1 | 11/19/2020 15:29:06  | 11/19/2020 15:29:06 |
### xc1-solr
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:56802838a4d2873cce2368fe46d0d9e4c3f6a6dc47f039ddf9aaf0ceb839fbec | 08/14/2020 09:56:43  | 10/27/2020 12:35:23 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:6dfe9c9c62b58389063ea8a950b47ffec9dba537e9f3148a7e6c65f9fd9699b6 | 10/27/2020 13:28:27  | 11/19/2020 14:48:06 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:0472df2f2435c8275b3783d89d3b1cb6c1b47fb7c844a624db0ec4e6c5489752 | 11/19/2020 15:29:57  | 11/19/2020 15:29:57 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:fe0947bdf52028c30659e29ca27bc251cb0cd2ae38ee3494b8f5492c797cf09a | 08/14/2020 11:41:56  | 11/19/2020 13:37:58 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:df37f6904e3196f1879b08bafb8ae065f3a9aaf3901b1a0c6863bb3ceb32244e | 08/14/2020 11:41:46  | 08/14/2020 11:41:46 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:7eae4f1af79d3f1730cf46d1a444542f0e7f2fc9721fd957e4983406bf816d01 | 08/14/2020 11:01:44  | 08/14/2020 11:01:44 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:e938e12d9d8ff84d4b9dc06f40b0e1eab8921a427d5ae5aebe8c7eb39f398734 | 10/05/2020 18:14:29  | 10/05/2020 18:14:29 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:d88f64d9e1f9f2420fcbb1daefd6e968899e561b567fa260d329d2466c92bcca | 10/05/2020 17:30:58  | 10/05/2020 17:30:58 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:36fbd07df688abf75053b053873a11cc25f5877d9cfe8acbe5179ac4c8124e7e | 10/27/2020 13:02:53  | 10/27/2020 13:02:53 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:56802838a4d2873cce2368fe46d0d9e4c3f6a6dc47f039ddf9aaf0ceb839fbec | 10/27/2020 12:35:11  | 10/27/2020 12:35:11 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:379f7518b10fc1aaf8b1aed28ddb53892050558b122bbda60bb8b0d2692bd426 | 10/27/2020 13:28:15  | 10/27/2020 13:28:15 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:fe0947bdf52028c30659e29ca27bc251cb0cd2ae38ee3494b8f5492c797cf09a | 11/19/2020 13:37:44  | 11/19/2020 13:37:44 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:6dfe9c9c62b58389063ea8a950b47ffec9dba537e9f3148a7e6c65f9fd9699b6 | 11/19/2020 14:47:52  | 11/19/2020 14:47:52 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:0472df2f2435c8275b3783d89d3b1cb6c1b47fb7c844a624db0ec4e6c5489752 | 11/19/2020 15:29:45  | 11/19/2020 15:29:45 |
## sxc 
This namespace includes images for *Sitecore Experience Commerce (SXC)*. 
### sitecore-xc0-cm
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:ae33848f117edad4236364e15718dae99a9fd6b1c107311c9dfadf81c5713319 | 08/14/2020 10:21:12  | 10/27/2020 12:49:45 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:f5b18e6ba46170b4d7e38135bd3893ffd7c7c0c772e71294b9a4abdd03670fa1 | 10/27/2020 13:41:35  | 11/19/2020 15:11:40 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:840494474d323bee12e6b041f4595a6cce231c222847c66fe48a3ed6e042f0ba | 11/19/2020 15:48:22  | 11/19/2020 15:48:22 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:af2ac5e85718007e6e3a0f135d678fb91d630ac8e749b9f105e880b3a5b07b13 | 08/14/2020 12:01:44  | 11/19/2020 14:12:27 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:46d4e961fa83d32fc4a49a0231b9ab36633d88b7988dd0ddc7b4b2a45b7d0479 | 08/14/2020 12:01:34  | 08/14/2020 12:01:34 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:f0d909ab82e7f77a21f02229d2e802fa148d0a02cef9f9afca7855d1ef138acb | 08/14/2020 11:15:27  | 08/14/2020 11:15:27 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:a52c1a3ae5fa63fce003df1fff03300fd39a2e2591a1f31de18e4eb34046e296 | 10/05/2020 18:36:12  | 10/05/2020 18:36:12 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:1281e2c1a998bb1aa89fbc897140025cda69c29edb0d0017b77987fcdc7b3939 | 10/05/2020 17:46:21  | 10/05/2020 17:46:21 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:8c4df656dd177fc65be08ecaf706c52b407d2afe89c1b954b393d04dde7ffe68 | 10/27/2020 13:15:27  | 10/27/2020 13:15:27 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:ae33848f117edad4236364e15718dae99a9fd6b1c107311c9dfadf81c5713319 | 10/27/2020 12:49:32  | 10/27/2020 12:49:32 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:df14739d2d475110527c99b7b6223753f2b8d9d50548b970aa9443f45a7dd53f | 10/27/2020 13:41:21  | 10/27/2020 13:41:21 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:af2ac5e85718007e6e3a0f135d678fb91d630ac8e749b9f105e880b3a5b07b13 | 11/19/2020 14:12:13  | 11/19/2020 14:12:13 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:f5b18e6ba46170b4d7e38135bd3893ffd7c7c0c772e71294b9a4abdd03670fa1 | 11/19/2020 15:11:27  | 11/19/2020 15:11:27 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:840494474d323bee12e6b041f4595a6cce231c222847c66fe48a3ed6e042f0ba | 11/19/2020 15:48:07  | 11/19/2020 15:48:07 |
### sitecore-xc0-xconnect
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:1454e1abdd8ad33767d32587fe293455970e406d25f0de67ab80616c2e2b573c | 08/14/2020 10:24:46  | 10/27/2020 12:52:45 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:981dbf508da001dbf4a6d35da723c8eed0b5b889f153cd0f14fde04c8a191156 | 10/27/2020 13:43:40  | 11/19/2020 15:14:34 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:cc0b2bb1d18428a2bdedb80f92306b8512df06f936ecb6e638b0edce9df1e869 | 11/19/2020 15:51:52  | 11/19/2020 15:51:52 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:eb613d9934be220b749d55ab8525c80f1d8534ec6470c2dedb1cb6ac2789e7c5 | 08/14/2020 12:04:31  | 11/19/2020 14:15:37 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:3aa310b4ff3058381dd89582dd61a81f61d104720920e588e88122e4603d0c43 | 08/14/2020 12:04:22  | 08/14/2020 12:04:22 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:20ffdf89e7fe8a9bdd12016c2ff333973a735c03795bbfe66b2cd99cae270cb5 | 08/14/2020 11:17:22  | 08/14/2020 11:17:22 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:bb4f0faa587a966f1c6c12d87633e8cdce05c9a3984ebf25286fecc27c226527 | 10/05/2020 18:38:12  | 10/05/2020 18:38:12 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:ccc69a27c4c4e72aff6320b64dad5dd493994853313ef3555e4e064b98aa91e9 | 10/05/2020 17:47:57  | 10/05/2020 17:47:57 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:c9e6923f52a914fef51e87c934d3c2f1d9530a8766fb97f7b0c994454262c847 | 10/27/2020 13:17:25  | 10/27/2020 13:17:25 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:1454e1abdd8ad33767d32587fe293455970e406d25f0de67ab80616c2e2b573c | 10/27/2020 12:52:32  | 10/27/2020 12:52:32 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:0be30062d6df3ca4010cdd162ca936bd9440a7f016b3848f6843939dd3245af8 | 10/27/2020 13:43:27  | 10/27/2020 13:43:27 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:eb613d9934be220b749d55ab8525c80f1d8534ec6470c2dedb1cb6ac2789e7c5 | 11/19/2020 14:15:23  | 11/19/2020 14:15:23 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:981dbf508da001dbf4a6d35da723c8eed0b5b889f153cd0f14fde04c8a191156 | 11/19/2020 15:14:14  | 11/19/2020 15:14:14 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:cc0b2bb1d18428a2bdedb80f92306b8512df06f936ecb6e638b0edce9df1e869 | 11/19/2020 15:50:36  | 11/19/2020 15:50:36 |
### sitecore-xc0-xdbautomationworker
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:532a6dac506e735ae622399f6f66323b8db06f808c7e24f418c7fab4e95d63ce | 08/14/2020 10:23:55  | 10/27/2020 12:52:13 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:62d96cd64fb830ec3036bedfd78a5a6fe60cd79f4eb9c1d28740c7622e3d8530 | 10/27/2020 13:43:07  | 11/19/2020 15:13:42 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:87243a05dd17d89165dbe36cc5b4536af61eddfb7bcf12b42afe2503f90b8f49 | 11/19/2020 15:50:14  | 11/19/2020 15:50:14 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:b1ae2be240c58c17b0e92375023ae226ad644fb512f4e27317af30f8d6569d25 | 08/14/2020 12:03:59  | 11/19/2020 14:14:40 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:7c63b6bdafed04b0cefdab7c2c3c3b8f9900743ee596817177f6d7bb4e3438d1 | 08/14/2020 12:03:49  | 08/14/2020 12:03:49 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:44b3c6905731a2f6071d187586a71bc7f3b1c4de02412e6daa7c51399d4b0d60 | 08/14/2020 11:16:53  | 08/14/2020 11:16:53 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:faadd578332b5b00aac11f8abc512564098cc6f11d9d206449c38fe0c907cb99 | 10/05/2020 18:37:42  | 10/05/2020 18:37:42 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:c184b8ae688ea22b67d733bd3dad454e31aab79a735b8ffa1d650aea7c66ab93 | 10/05/2020 17:47:31  | 10/05/2020 17:47:31 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:ec8069872af485448237ceee7f6b5530bfebc8b98e1189335d492accdc5e9e07 | 10/27/2020 13:16:54  | 10/27/2020 13:16:54 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:532a6dac506e735ae622399f6f66323b8db06f808c7e24f418c7fab4e95d63ce | 10/27/2020 12:52:01  | 10/27/2020 12:52:01 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:933d1904c6ad8e079a8ac06f94cf0d0fa7ee599ac174a5dfd66e8f5ff39c60ba | 10/27/2020 13:42:55  | 10/27/2020 13:42:55 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:b1ae2be240c58c17b0e92375023ae226ad644fb512f4e27317af30f8d6569d25 | 11/19/2020 14:14:25  | 11/19/2020 14:14:25 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:62d96cd64fb830ec3036bedfd78a5a6fe60cd79f4eb9c1d28740c7622e3d8530 | 11/19/2020 15:13:27  | 11/19/2020 15:13:27 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:87243a05dd17d89165dbe36cc5b4536af61eddfb7bcf12b42afe2503f90b8f49 | 11/19/2020 15:50:04  | 11/19/2020 15:50:04 |
### sitecore-xc0-xdbsearchworker
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:03d52b38b864bb3ef345aeebb01f6d612bf74d90f3fd1b0e8223b80942fb8274 | 08/14/2020 10:22:19  | 10/27/2020 12:50:17 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:0142835ec5317645d71e2938c7e152bdb8289ff2b0437e1f0c1fb3e41481be06 | 10/27/2020 13:42:10  | 11/19/2020 15:12:19 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:bc6534e7fbcc34f699aee73d3f22f33ced4c1d67d0df1edd8c57ea14ad4ceea2 | 11/19/2020 15:48:53  | 11/19/2020 15:48:53 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:841fdd5c09cae9696f71a3726b9ddc1d1891c74d904cb3b145ab2a06c56000df | 08/14/2020 12:02:58  | 11/19/2020 14:13:16 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:7611e2c10e379165d6e5a7fb69e94b74c2f6ca8f60d26b4a55ec9fe25f3661e1 | 08/14/2020 12:02:05  | 08/14/2020 12:02:05 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:4da598534dc8f63464cbeee3c1eae191f58bdac014d0310b4fea7d0f9a1fe371 | 08/14/2020 11:15:58  | 08/14/2020 11:15:58 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:d5fb65ab0f01e988b7cae2d5c7d14ad770a22bf87547d2c2f7f2d133b352ead8 | 10/05/2020 18:36:43  | 10/05/2020 18:36:43 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:9ad145bd693cdfeb6b40c700863e5d0046da614d374e7e7e64ed3015710cd695 | 10/05/2020 17:46:47  | 10/05/2020 17:46:47 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:cb27aefa6ab4d05a51bdf0c1fa50b9cdc7cfd2333cf56344e226018db7602640 | 10/27/2020 13:15:58  | 10/27/2020 13:15:58 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:03d52b38b864bb3ef345aeebb01f6d612bf74d90f3fd1b0e8223b80942fb8274 | 10/27/2020 12:50:04  | 10/27/2020 12:50:04 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:4d32723d969b33efb696217207ec151a697c7a5c8ed54f00e054608e796aae3d | 10/27/2020 13:41:55  | 10/27/2020 13:41:55 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:841fdd5c09cae9696f71a3726b9ddc1d1891c74d904cb3b145ab2a06c56000df | 11/19/2020 14:13:04  | 11/19/2020 14:13:04 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:0142835ec5317645d71e2938c7e152bdb8289ff2b0437e1f0c1fb3e41481be06 | 11/19/2020 15:12:06  | 11/19/2020 15:12:06 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:bc6534e7fbcc34f699aee73d3f22f33ced4c1d67d0df1edd8c57ea14ad4ceea2 | 11/19/2020 15:48:41  | 11/19/2020 15:48:41 |
### sitecore-xc1-cd
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:6406c22add5f66c3e415637b816cc513d61574cfc4b431cee6b593a0e2e074c1 | 08/14/2020 10:05:02  | 10/27/2020 12:40:43 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:e92b10fe403997384e709d4ec1818f06d3a3521cb5e5c87cd87d274684399651 | 10/27/2020 13:31:59  | 11/19/2020 14:56:37 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:50ba8d458e701b4c106a307360c221b0ab356ab5a931198540fb78ee06c513e3 | 11/19/2020 15:34:48  | 11/19/2020 15:34:48 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:0848d06fd8f6b72d751d18a84a908af51aa5b78996dca3450a089b9f0c73f2de | 08/14/2020 11:49:56  | 11/19/2020 13:53:33 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:63b2193cf5268cb6cf17a3e424a683f6db1e0a69f47bdb9e62c58d46c572f39f | 08/14/2020 11:49:46  | 08/14/2020 11:49:46 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:b7660d3e56e9ea70cc879cbb2de04d906359b8192311852946d4ff6444bdf481 | 08/14/2020 11:06:48  | 08/14/2020 11:06:48 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:3393654220fc074e49984b6826dbc76729e5e4cbf6a5b638cb8d1893255c00ef | 10/05/2020 18:24:57  | 10/05/2020 18:24:57 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:404cff69e49e9cd07337608420f550aef6139e83c0a72c0e133ada5275315f0b | 10/05/2020 17:36:49  | 10/05/2020 17:36:49 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:0af7d72aeed79bf7e042610c98a65d0971f98400f1932c07a3afce900a726590 | 10/27/2020 13:06:40  | 10/27/2020 13:06:40 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:6406c22add5f66c3e415637b816cc513d61574cfc4b431cee6b593a0e2e074c1 | 10/27/2020 12:40:27  | 10/27/2020 12:40:27 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:d8e389f6609ff7bebbeb50118f5798a2ebe5b22d355844e3c30104810a259066 | 10/27/2020 13:31:45  | 10/27/2020 13:31:45 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:0848d06fd8f6b72d751d18a84a908af51aa5b78996dca3450a089b9f0c73f2de | 11/19/2020 13:53:16  | 11/19/2020 13:53:16 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:e92b10fe403997384e709d4ec1818f06d3a3521cb5e5c87cd87d274684399651 | 11/19/2020 14:56:19  | 11/19/2020 14:56:19 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:50ba8d458e701b4c106a307360c221b0ab356ab5a931198540fb78ee06c513e3 | 11/19/2020 15:34:36  | 11/19/2020 15:34:36 |
### sitecore-xc1-cm
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:a97453392a6f3d795c646ee9427acbcdcad6a580434510cb276b800866e4a2f1 | 08/14/2020 10:02:42  | 10/27/2020 12:38:34 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:646a2dfb7555e0967859ddae8557b67f4ee8d94e5652578bc49445c1f23cb5c8 | 10/27/2020 13:30:50  | 11/19/2020 14:54:01 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:1e07d0b0afe269d0418afcf3e5bfded2f943fcdd440e36c7da437f181ba6e236 | 11/19/2020 15:33:33  | 11/19/2020 15:33:33 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:22ffdbd7be717120bdaa42b98cf4a2c4f3a5cf0ada694346d1b46b8ed9f80bd8 | 08/14/2020 11:48:13  | 11/19/2020 13:49:56 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:df09ab2b9366ceccdf55c54d2ebab0cc3034f7a8965371f60484e368f245ecf9 | 08/14/2020 11:48:01  | 08/14/2020 11:48:01 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:1d61712ea2b16107a519f5b778e4915c006dc1d268f3d2bee23ebda36bab1d95 | 08/14/2020 11:05:20  | 08/14/2020 11:05:20 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:7b4c494e137bb9babae6f5186471ec47bc6986b93d4481029b852ec81c4ae466 | 10/05/2020 18:22:47  | 10/05/2020 18:22:47 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:80eacc8a35ae358e03ee2d001186491a90738f87bcd17838478d0ab9e91e4694 | 10/05/2020 17:35:20  | 10/05/2020 17:35:20 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:76e0d74390b32672c6a7326726cb9a1705fbd20ac00a1d643cbd5018cb2a03c7 | 10/27/2020 13:05:38  | 10/27/2020 13:05:38 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:a97453392a6f3d795c646ee9427acbcdcad6a580434510cb276b800866e4a2f1 | 10/27/2020 12:38:20  | 10/27/2020 12:38:20 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:1ca00b5939e4f858a7c8c4fc92efbb1f71e0495ae6ad44449cb9133672658c3d | 10/27/2020 13:30:37  | 10/27/2020 13:30:37 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:22ffdbd7be717120bdaa42b98cf4a2c4f3a5cf0ada694346d1b46b8ed9f80bd8 | 11/19/2020 13:49:37  | 11/19/2020 13:49:37 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:646a2dfb7555e0967859ddae8557b67f4ee8d94e5652578bc49445c1f23cb5c8 | 11/19/2020 14:53:38  | 11/19/2020 14:53:38 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:1e07d0b0afe269d0418afcf3e5bfded2f943fcdd440e36c7da437f181ba6e236 | 11/19/2020 15:33:18  | 11/19/2020 15:33:18 |
### sitecore-xc1-mssql-init
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:2413827b5d1c3ebab57deb10634563f2ea960d76bcf8fe51bd0d50b243c88a76 | 08/14/2020 10:09:03  | 10/27/2020 12:43:10 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:ce7da99f4dc67eb282ab34b015892c1a16478b2e70ce113d813d119639e8fa81 | 10/27/2020 13:34:49  | 11/19/2020 15:00:36 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:10cf50e586c0489ae759792297298ea19feee960aa315867aac1605f59123f00 | 11/19/2020 15:39:17  | 11/19/2020 15:39:17 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:4c0dee76c09396d94cccd264935636a4b6d9a082775c25d0dab2f6b917207cff | 08/14/2020 11:52:39  | 11/19/2020 13:57:15 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:f0b287efff54adad63ef0bc6dfea1df246bac9c814a9e0fc19e58fefb5504fc5 | 08/14/2020 11:52:23  | 08/14/2020 11:52:23 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:0f95a5553b5764f42ec375cea5c526371bd577e6dbfebdf9aaa91e74a6f8509d | 08/14/2020 11:09:02  | 08/14/2020 11:09:02 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:9d87620130a08434649ee3c1dc3048db98473c66041adfae13374abf8eaf6648 | 10/05/2020 18:27:11  | 10/05/2020 18:27:11 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:26125369d4b7a3a10ec67dab3f54d5a48b6689f271f110dd18eef6ec83b679cc | 10/05/2020 17:39:43  | 10/05/2020 17:39:43 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:10d19f09817e11fae2669453ef11c4eafdbcc922e30302e8bab3623b492acbfb | 10/27/2020 13:08:56  | 10/27/2020 13:08:56 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:2413827b5d1c3ebab57deb10634563f2ea960d76bcf8fe51bd0d50b243c88a76 | 10/27/2020 12:42:57  | 10/27/2020 12:42:57 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:e377994e2f50720a087a32e31486b0f1330517404c71519b9941ae53d11968ee | 10/27/2020 13:34:37  | 10/27/2020 13:34:37 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:4c0dee76c09396d94cccd264935636a4b6d9a082775c25d0dab2f6b917207cff | 11/19/2020 13:57:01  | 11/19/2020 13:57:01 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:ce7da99f4dc67eb282ab34b015892c1a16478b2e70ce113d813d119639e8fa81 | 11/19/2020 15:00:21  | 11/19/2020 15:00:21 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:10cf50e586c0489ae759792297298ea19feee960aa315867aac1605f59123f00 | 11/19/2020 15:39:00  | 11/19/2020 15:39:00 |
### sitecore-xc1-prc
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:2c05e10a13919b4b51b70162ff1bc9ca97eee124367dc0c7a14b8964150e5fe1 | 08/14/2020 10:14:08  | 10/27/2020 12:46:20 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:d813e06ad6065bf0881d32a1c7e6d19aa05a1be14dba8955d95a8439cd6bc5de | 10/27/2020 13:37:51  | 11/19/2020 15:05:57 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:7457d33550a0baaf25fd6fecedf33bb094e45ff2721bb75c02a851d578a53062 | 11/19/2020 15:43:22  | 11/19/2020 15:43:22 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:b80005b1d654f723c35442767b97feb2e17d4c68656b459ade01e62994a11059 | 08/14/2020 11:57:06  | 11/19/2020 14:03:06 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:cce265655015b8d661385ef161f86e11ea0cab4a43b16bfdeca27524863cf983 | 08/14/2020 11:56:56  | 08/14/2020 11:56:56 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:ddd4e8bddd788e416bb7413a605d816a16bf97bb6773e03628d269f4b0a4d58a | 08/14/2020 11:12:08  | 08/14/2020 11:12:08 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:2d9f3a3562e181595d85496ec6855acb60bcbd8beecc10a073aa55b98300db31 | 10/05/2020 18:30:49  | 10/05/2020 18:30:49 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:bf67f342886e92b547b713ea960b53edc60c45ca722582c80acdb0470a198c80 | 10/05/2020 17:42:34  | 10/05/2020 17:42:34 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:7e47edf2cacbfd65105cf85522aa2a5762e417ab365b685e16a4d405967bd463 | 10/27/2020 13:12:00  | 10/27/2020 13:12:00 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:2c05e10a13919b4b51b70162ff1bc9ca97eee124367dc0c7a14b8964150e5fe1 | 10/27/2020 12:46:07  | 10/27/2020 12:46:07 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:3bf7a88257c80b373084cdaa8a52137d67cf3ce7e458c66c32352f6501cf0802 | 10/27/2020 13:37:39  | 10/27/2020 13:37:39 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:b80005b1d654f723c35442767b97feb2e17d4c68656b459ade01e62994a11059 | 11/19/2020 14:02:53  | 11/19/2020 14:02:53 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:d813e06ad6065bf0881d32a1c7e6d19aa05a1be14dba8955d95a8439cd6bc5de | 11/19/2020 15:05:42  | 11/19/2020 15:05:42 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:7457d33550a0baaf25fd6fecedf33bb094e45ff2721bb75c02a851d578a53062 | 11/19/2020 15:42:41  | 11/19/2020 15:42:41 |
### sitecore-xc1-rep
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:3b41dcc51323270592f6c3421b7da0dc61ecdf6060b44e7f7a690c9bf12a6307 | 08/14/2020 10:18:04  | 10/27/2020 12:48:17 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:a5997be14ec5e2f7fbba7b9eb4bd1f3e17a3340f7bee681c35a628d8fd45b2d1 | 10/27/2020 13:39:59  | 11/19/2020 15:09:20 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:4e9a25e5c86b08e2d8e4fcf264798b6c170136bf8698fce31ab42e50d9c46b9a | 11/19/2020 15:46:39  | 11/19/2020 15:46:39 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:051390437676ea9048469ed4008bfe912152b8ef2f97b34e6fe7dcf78428a1f5 | 08/14/2020 11:59:37  | 11/19/2020 14:08:12 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:772e200a53b797e15ffa3fcd0c57b16ca8b901ab2b550e940903ea802dd2106e | 08/14/2020 11:59:27  | 08/14/2020 11:59:27 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:3f50bc13e4bb7e6d1a801e3771d066a6e5e6b5f581bd5a07838dce1adf51b26f | 08/14/2020 11:14:02  | 08/14/2020 11:14:02 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:7fdfed460d9c1fad997a08e708f4509daec1899c7a6db2b3c57903c89fa06b9c | 10/05/2020 18:33:39  | 10/05/2020 18:33:39 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:eaca566d78db6f84be67e4e6a3ac573327fd3a30b6f042217647e47ed00d2388 | 10/05/2020 17:44:38  | 10/05/2020 17:44:38 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:3ab886012e5d7aaca23614e46f584028ff9a3edc06f1032fec033daa20d793bc | 10/27/2020 13:13:57  | 10/27/2020 13:13:57 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:3b41dcc51323270592f6c3421b7da0dc61ecdf6060b44e7f7a690c9bf12a6307 | 10/27/2020 12:48:05  | 10/27/2020 12:48:05 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:fca6ba0d1112b2ac729797901ec2e62d271f99cbfd9c7c1355030a7d802d51cf | 10/27/2020 13:39:47  | 10/27/2020 13:39:47 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:051390437676ea9048469ed4008bfe912152b8ef2f97b34e6fe7dcf78428a1f5 | 11/19/2020 14:07:56  | 11/19/2020 14:07:56 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:a5997be14ec5e2f7fbba7b9eb4bd1f3e17a3340f7bee681c35a628d8fd45b2d1 | 11/19/2020 15:09:08  | 11/19/2020 15:09:08 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:4e9a25e5c86b08e2d8e4fcf264798b6c170136bf8698fce31ab42e50d9c46b9a | 11/19/2020 15:46:27  | 11/19/2020 15:46:27 |
### sitecore-xc1-solr-init
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:2056eac42bcb9008fc4e09094947252b3777d3f1e25b42d7b22bfdb9da5de2c8 | 08/14/2020 10:10:03  | 10/27/2020 12:43:46 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:f5c6c01853581eb6e8cafd3772fe44acbf7c455744b076472fd10e6ffd627a94 | 10/27/2020 13:35:24  | 11/19/2020 15:01:26 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:124167dbbd07c0f49ea182c3ee8257db3f575c0b67d49e42dfd64b45b176e490 | 11/19/2020 15:39:58  | 11/19/2020 15:39:58 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:e12dc63ce11deabbab565cead4aa9605228688a3036f711fbf8b60d93d3348e8 | 08/14/2020 11:53:17  | 11/19/2020 13:58:24 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:51a707b60450b13d9c45e08394919078d0c9016c49f88366fdffcb63857dfaef | 08/14/2020 11:53:06  | 08/14/2020 11:53:06 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:9092df911e944bd137c70c0f2ecb7fcce7a06ae92c854f74681de71315534383 | 08/14/2020 11:09:40  | 08/14/2020 11:09:40 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:b5c60d0b26b0120305510ea5737ea5aff35ace9822a7fa6724b8a67a657578ec | 10/05/2020 18:27:46  | 10/05/2020 18:27:46 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:7b3a4fb357f27cc9ec9f4a1cf51514cd12b8ff6a39a6ddc9e07ab0cec0d1eb02 | 10/05/2020 17:40:14  | 10/05/2020 17:40:14 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:6713cfef857bd81138ba3df57f94a3db24a2cda10ad670e03cd7c4f6cd24338f | 10/27/2020 13:09:30  | 10/27/2020 13:09:30 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:2056eac42bcb9008fc4e09094947252b3777d3f1e25b42d7b22bfdb9da5de2c8 | 10/27/2020 12:43:33  | 10/27/2020 12:43:33 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:3269b58a8d2c1421376179b566103d83ea47e25986a2aaad8e82ddab34c42b95 | 10/27/2020 13:35:13  | 10/27/2020 13:35:13 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:e12dc63ce11deabbab565cead4aa9605228688a3036f711fbf8b60d93d3348e8 | 11/19/2020 13:58:11  | 11/19/2020 13:58:11 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:f5c6c01853581eb6e8cafd3772fe44acbf7c455744b076472fd10e6ffd627a94 | 11/19/2020 15:01:13  | 11/19/2020 15:01:13 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:124167dbbd07c0f49ea182c3ee8257db3f575c0b67d49e42dfd64b45b176e490 | 11/19/2020 15:39:45  | 11/19/2020 15:39:45 |
### sitecore-xc1-xdbautomation
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:c6a3c689cd91c5f61cdee1071824d042dd5dc2c2d80767d96f42ba4a3524b955 | 08/14/2020 10:12:25  | 10/27/2020 12:45:16 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:5c437060ad1c7f046d1680d8010945365bd813b6133ce0debed2f052d7207aad | 10/27/2020 13:36:54  | 11/19/2020 15:03:51 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:ea2680ebdbe11278e996c4680672a378aa3e63c2e03354994b3a9cfabdd26552 | 11/19/2020 15:41:40  | 11/19/2020 15:41:40 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:59e8f97962834b3ec14283d401f0fa81e85c412644c9e4c738d186cf69994349 | 08/14/2020 11:55:24  | 11/19/2020 14:00:36 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:01c1effc06b39345e8f7d4ee80b1c822d4401057e498e29b6c07fe8115492a1d | 08/14/2020 11:55:14  | 08/14/2020 11:55:14 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:148ce95d3cf7274392d9e2a6bebc73a26d307bea4f46b9f42870a1012417938b | 08/14/2020 11:11:11  | 08/14/2020 11:11:11 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:714b7aee7691b24edde2dc495c0539f3d8a67b72c87704f5f905e38b9b345f75 | 10/05/2020 18:29:01  | 10/05/2020 18:29:01 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:48db6694311a862456247e80256404ef6ae6719637e1c690c35c114ee0d411cc | 10/05/2020 17:41:23  | 10/05/2020 17:41:23 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:144b17dff25a44dad7eecf1343ad223feba299371d8d1334f01018797360cfb5 | 10/27/2020 13:11:06  | 10/27/2020 13:11:06 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:c6a3c689cd91c5f61cdee1071824d042dd5dc2c2d80767d96f42ba4a3524b955 | 10/27/2020 12:45:05  | 10/27/2020 12:45:05 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:156a04d49cd589384cc1ef2c67c9a59ad851c6b9651d3b68dbdf15a21bb6b906 | 10/27/2020 13:36:43  | 10/27/2020 13:36:43 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:59e8f97962834b3ec14283d401f0fa81e85c412644c9e4c738d186cf69994349 | 11/19/2020 14:00:23  | 11/19/2020 14:00:23 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:5c437060ad1c7f046d1680d8010945365bd813b6133ce0debed2f052d7207aad | 11/19/2020 15:03:38  | 11/19/2020 15:03:38 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:ea2680ebdbe11278e996c4680672a378aa3e63c2e03354994b3a9cfabdd26552 | 11/19/2020 15:41:25  | 11/19/2020 15:41:25 |
### sitecore-xc1-xdbautomationworker
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:4b39b22953c1718ec66d89ba6f61e4b49fb8094e90573a95106f2e0973c67001 | 08/14/2020 10:15:56  | 10/27/2020 12:47:22 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:df300890b427dccf30be5aa4d7b8c24e15dc26076b53e1ea2d9db797554a8dec | 10/27/2020 13:38:58  | 11/19/2020 15:07:32 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:f8ffe1d5589a2c99f9d780d31f0dede0321e1bb64a11090d3385f42d71d631ed | 11/19/2020 15:45:31  | 11/19/2020 15:45:31 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:db24726c0fd0317c4636876eb8232439be01a80b7ad0b60370d5e3241f94e872 | 08/14/2020 11:58:16  | 11/19/2020 14:04:48 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:0b2dc894e5430909ca61d4068f343d27782e74d51129dc812cf1dc6cdc4fa11e | 08/14/2020 11:58:06  | 08/14/2020 11:58:06 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:30202ce8735ad78700f4ba29a629c6dddd7126f9e4b0a6ddeec41770d29a24a4 | 08/14/2020 11:13:09  | 08/14/2020 11:13:09 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:980dca7d0638adff18b3cfdaca8c9b81b9246516bf93edda91411aeb234a2f40 | 10/05/2020 18:31:56  | 10/05/2020 18:31:56 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:3dfa832b0d12bb605c657c0eb3ba4ed400a654c5d0f4fcb428546f8491a7656c | 10/05/2020 17:43:28  | 10/05/2020 17:43:28 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:968ffc7cb5bf9e3886f19f8500756e1131e58a574ce4ba91c6312440344c07e4 | 10/27/2020 13:13:00  | 10/27/2020 13:13:00 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:4b39b22953c1718ec66d89ba6f61e4b49fb8094e90573a95106f2e0973c67001 | 10/27/2020 12:47:10  | 10/27/2020 12:47:10 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:21421ec107fe3012814ab212acbddc755e4e2a5c8e5f4d5c18d8970a07ceeb20 | 10/27/2020 13:38:45  | 10/27/2020 13:38:45 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:db24726c0fd0317c4636876eb8232439be01a80b7ad0b60370d5e3241f94e872 | 11/19/2020 14:04:34  | 11/19/2020 14:04:34 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:df300890b427dccf30be5aa4d7b8c24e15dc26076b53e1ea2d9db797554a8dec | 11/19/2020 15:07:19  | 11/19/2020 15:07:19 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:f8ffe1d5589a2c99f9d780d31f0dede0321e1bb64a11090d3385f42d71d631ed | 11/19/2020 15:44:23  | 11/19/2020 15:44:23 |
### sitecore-xc1-xdbcollection
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:e2ba5712eb2f6c60ca45aaa913f8cdb8891b3388aa0c3cb42e309fa0ebeef5d4 | 08/14/2020 10:15:05  | 10/27/2020 12:46:53 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:66c44774e8b37a3fbc0b39b22ece70ff01164852495ba97cb5bf82f049977957 | 10/27/2020 13:38:22  | 11/19/2020 15:06:45 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:dcca975391456a06dc6f5a87ed323a93a332931bfbee3ee58298a42bbef03413 | 11/19/2020 15:44:02  | 11/19/2020 15:44:02 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:56adc70c53d9e7467139fb855ffd3331b9b4b31aa5240b1474f58fef261a74d9 | 08/14/2020 11:57:41  | 11/19/2020 14:04:00 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:1fc5be6df9a49b2080a6cbe41019ef74fa4570aa2e2babe4c7329d331148671e | 08/14/2020 11:57:31  | 08/14/2020 11:57:31 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:fc1abe8fb96d6f43ca7661ef4fa38236c1c6a237a9ae1fa3a5b52aebfda54ecb | 08/14/2020 11:12:39  | 08/14/2020 11:12:39 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:b9dbb236cc602561716c9cb4a136ddf7a643a0695d399058b42ec221a0d159fd | 10/05/2020 18:31:24  | 10/05/2020 18:31:24 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:9a2d110a9756e5c84fee1a7daf5e50a862e5f34c88d49cd6ce0b94321108e0f7 | 10/05/2020 17:43:02  | 10/05/2020 17:43:02 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:710785cee005c3da0b5ae902495dbc0afd64ba4c8eccc63a32bd42522ebac114 | 10/27/2020 13:12:30  | 10/27/2020 13:12:30 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:e2ba5712eb2f6c60ca45aaa913f8cdb8891b3388aa0c3cb42e309fa0ebeef5d4 | 10/27/2020 12:46:41  | 10/27/2020 12:46:41 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:bdaa8a77305b3cfb55608a90d7be41a7b7f3fa360d900abad3fa9a5ba9bf00fa | 10/27/2020 13:38:10  | 10/27/2020 13:38:10 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:56adc70c53d9e7467139fb855ffd3331b9b4b31aa5240b1474f58fef261a74d9 | 11/19/2020 14:03:47  | 11/19/2020 14:03:47 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:66c44774e8b37a3fbc0b39b22ece70ff01164852495ba97cb5bf82f049977957 | 11/19/2020 15:06:31  | 11/19/2020 15:06:31 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:dcca975391456a06dc6f5a87ed323a93a332931bfbee3ee58298a42bbef03413 | 11/19/2020 15:43:46  | 11/19/2020 15:43:46 |
### sitecore-xc1-xdbsearch
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:6d94c7352ad0556263a069130257eff113b89fdbeb0a730f42d08e7d0e2d5574 | 08/14/2020 10:18:57  | 10/27/2020 12:48:47 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:5c217cf8e840e4d3be5b27e50aab927049fa13a76b4ac1c9e9d47a89547e333e | 10/27/2020 13:40:29  | 11/19/2020 15:09:57 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:cc572492e3bc9db19dcbb5b73b7f9bde84b482d475986dfb4b98308421b66a5c | 11/19/2020 15:47:10  | 11/19/2020 15:47:10 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:7c250c9b9164dfc46b9768161efb719ed41dd4af9a28a7bad5b0012e16f086b1 | 08/14/2020 12:00:08  | 11/19/2020 14:09:03 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:9b4519a3d01257661dad743439d3083fd634151ddc63675191636c51319b0186 | 08/14/2020 11:59:59  | 08/14/2020 11:59:59 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:eb985ac2403da880f85f7b38a7f218e7d5362bd68b49bd67be92613cd515c1b6 | 08/14/2020 11:14:29  | 08/14/2020 11:14:29 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:8625599a04ccc4dcbce24e1a5a7962d5db1895e29b4f45d8059df83d6afe79c2 | 10/05/2020 18:34:07  | 10/05/2020 18:34:07 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:69a8ae4385c7435034ffdde628c0468ef56648e5abbe5858d2520d4f556f5819 | 10/05/2020 17:45:05  | 10/05/2020 17:45:05 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:4e05bfddaedadc9845ef2e3e76f6e6e8e1e22f569f5b1651fdc32fb7fc648099 | 10/27/2020 13:14:26  | 10/27/2020 13:14:26 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:6d94c7352ad0556263a069130257eff113b89fdbeb0a730f42d08e7d0e2d5574 | 10/27/2020 12:48:35  | 10/27/2020 12:48:35 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:4bcd238957eba2312610bc0fddee1b6fc2932f35384376937e4e681838e99b59 | 10/27/2020 13:40:18  | 10/27/2020 13:40:18 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:7c250c9b9164dfc46b9768161efb719ed41dd4af9a28a7bad5b0012e16f086b1 | 11/19/2020 14:08:49  | 11/19/2020 14:08:49 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:5c217cf8e840e4d3be5b27e50aab927049fa13a76b4ac1c9e9d47a89547e333e | 11/19/2020 15:09:45  | 11/19/2020 15:09:45 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:cc572492e3bc9db19dcbb5b73b7f9bde84b482d475986dfb4b98308421b66a5c | 11/19/2020 15:46:58  | 11/19/2020 15:46:58 |
### sitecore-xc1-xdbsearchworker
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:03d52b38b864bb3ef345aeebb01f6d612bf74d90f3fd1b0e8223b80942fb8274 | 08/14/2020 10:23:06  | 10/27/2020 12:51:44 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:0142835ec5317645d71e2938c7e152bdb8289ff2b0437e1f0c1fb3e41481be06 | 10/27/2020 13:42:38  | 11/19/2020 15:12:50 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:c7312c6a1a4b6ed59b9e8103c165d53504920c9242f7ff7fc74ccc7d1fe674fd | 11/19/2020 15:49:32  | 11/19/2020 15:49:32 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:841fdd5c09cae9696f71a3726b9ddc1d1891c74d904cb3b145ab2a06c56000df | 08/14/2020 12:03:29  | 11/19/2020 14:13:50 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:84ca17c86bcf8361041519e769a48c0f945429877fe152f050858344c35ca559 | 08/14/2020 12:03:20  | 08/14/2020 12:03:20 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:caf7979551ae9189fee592e81fefbb3efc8b64acc425c644176f1a568f114a56 | 08/14/2020 11:16:25  | 08/14/2020 11:16:25 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:8e33a2ed0fc44be007edbd25f1285130bcbe06c530e989171ee72c37f5f1fd0f | 10/05/2020 18:37:14  | 10/05/2020 18:37:14 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:9ad145bd693cdfeb6b40c700863e5d0046da614d374e7e7e64ed3015710cd695 | 10/05/2020 17:47:07  | 10/05/2020 17:47:07 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:cb27aefa6ab4d05a51bdf0c1fa50b9cdc7cfd2333cf56344e226018db7602640 | 10/27/2020 13:16:26  | 10/27/2020 13:16:26 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:03d52b38b864bb3ef345aeebb01f6d612bf74d90f3fd1b0e8223b80942fb8274 | 10/27/2020 12:51:33  | 10/27/2020 12:51:33 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:4d32723d969b33efb696217207ec151a697c7a5c8ed54f00e054608e796aae3d | 10/27/2020 13:42:26  | 10/27/2020 13:42:26 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:841fdd5c09cae9696f71a3726b9ddc1d1891c74d904cb3b145ab2a06c56000df | 11/19/2020 14:13:35  | 11/19/2020 14:13:35 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:0142835ec5317645d71e2938c7e152bdb8289ff2b0437e1f0c1fb3e41481be06 | 11/19/2020 15:12:38  | 11/19/2020 15:12:38 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:c7312c6a1a4b6ed59b9e8103c165d53504920c9242f7ff7fc74ccc7d1fe674fd | 11/19/2020 15:49:11  | 11/19/2020 15:49:11 |
### sitecore-xc-bizfx
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:9ea040c911c1afba0b42f09301abfc278698d6901f12b738746c3c24bc9a1e95 | 08/14/2020 10:25:44  | 10/27/2020 12:53:20 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:2812fceeb31c8dc2090f0034b5a4d743829f173abe85278419e4e613177b3014 | 10/27/2020 13:44:19  | 11/19/2020 15:15:51 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:c5a044725a6e47c6b7231f11fff98a9188bfc795e42433b8244be9a2a41c4492 | 11/19/2020 15:52:41  | 11/19/2020 15:52:41 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:005c17792e21de5a8b6ae26ea9b687875b7a9b72b36e852d88c926e2908c231e | 08/14/2020 12:07:23  | 11/19/2020 14:17:31 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:ffff2e803b54aae4621e62c78f5804aec235b2a3644f1d232f64907c85e68a88 | 08/14/2020 12:07:13  | 08/14/2020 12:07:13 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:ad35ad8f7ad81989fc9761237b4ee9d0160c7ce234a54b0d6f04f09272421dfe | 08/14/2020 11:21:13  | 08/14/2020 11:21:13 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:f6e0176c07ca4bfae00b4be5b001edb382c1cca59a52d128a43dd1dff1fc5423 | 10/05/2020 18:39:11  | 10/05/2020 18:39:11 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:23e471438219bfa0f60884a73a60ae347a5b14ba5b6f3033de87a815b8dbe768 | 10/05/2020 17:48:37  | 10/05/2020 17:48:37 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:2da670d68f1c45bb8059241d068efeac2bd715b2642081b308d6041c78c88dce | 10/27/2020 13:19:06  | 10/27/2020 13:19:06 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:9ea040c911c1afba0b42f09301abfc278698d6901f12b738746c3c24bc9a1e95 | 10/27/2020 12:53:08  | 10/27/2020 12:53:08 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:6ad20d2c71df07fa80fe12dc439cb45797c1358a06d9c7c6c585a5f1a2548f39 | 10/27/2020 13:44:06  | 10/27/2020 13:44:06 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:005c17792e21de5a8b6ae26ea9b687875b7a9b72b36e852d88c926e2908c231e | 11/19/2020 14:17:16  | 11/19/2020 14:17:16 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:2812fceeb31c8dc2090f0034b5a4d743829f173abe85278419e4e613177b3014 | 11/19/2020 15:15:37  | 11/19/2020 15:15:37 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:c5a044725a6e47c6b7231f11fff98a9188bfc795e42433b8244be9a2a41c4492 | 11/19/2020 15:52:27  | 11/19/2020 15:52:27 |
### sitecore-xc-engine
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:357818256d6665c52929049f4466f56f80b82d3b65dd4b9b7ef5118ff47bcd53 | 08/14/2020 10:27:21  | 10/27/2020 12:54:18 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:634a7eed78648ecf9bcbef046108277d28bc7371e7b52e39661894327cad7a87 | 10/27/2020 13:45:16  | 11/19/2020 15:17:34 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:49d45a36666f4f78426efa056c0a67e2926a5ce664320110c42149b17eea7b2e | 11/19/2020 15:54:00  | 11/19/2020 15:54:00 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:e2a177b1ea9fb184af61f67b3ef9d6b980aec5438d8264154abbe342fcce4fe8 | 08/14/2020 12:09:12  | 11/19/2020 14:19:43 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:921f789e0936108f20e0ab1e8675d7b1380618b9695b8491a7f8a6145f3159fd | 08/14/2020 12:09:01  | 08/14/2020 12:09:01 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:43394003cb2fba851563e9e065e85c84eee3a46623129390d9e6700acfe38597 | 08/14/2020 11:22:27  | 08/14/2020 11:22:27 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:99b894c26f2546d4bd8cc158a7e1bf0a28fcf7bb1aff16e66b769c901f5dd944 | 10/05/2020 18:40:18  | 10/05/2020 18:40:18 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:9c76987c38071f54640eeca85123d970d6c0c62d0a7e8ca2a41b8f68cd68192f | 10/05/2020 17:49:40  | 10/05/2020 17:49:40 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:12567ce828076c2913ff8e9bd139b98f0be250dfafc36490c29e2c7ca2208eef | 10/27/2020 13:19:51  | 10/27/2020 13:19:51 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:357818256d6665c52929049f4466f56f80b82d3b65dd4b9b7ef5118ff47bcd53 | 10/27/2020 12:54:06  | 10/27/2020 12:54:06 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:90e766df5a7121395f3d65b0ab59167d47552be47fed1c715eef9a5b5dc2ec8d | 10/27/2020 13:45:04  | 10/27/2020 13:45:04 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:e2a177b1ea9fb184af61f67b3ef9d6b980aec5438d8264154abbe342fcce4fe8 | 11/19/2020 14:19:24  | 11/19/2020 14:19:24 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:634a7eed78648ecf9bcbef046108277d28bc7371e7b52e39661894327cad7a87 | 11/19/2020 15:17:19  | 11/19/2020 15:17:19 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:49d45a36666f4f78426efa056c0a67e2926a5ce664320110c42149b17eea7b2e | 11/19/2020 15:53:47  | 11/19/2020 15:53:47 |
### sitecore-xc-id
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:5ab10e459701928badb1c46d6b0b8ef9d1e5ca12cb69322694cdd785c41dfff8 | 08/14/2020 10:28:56  | 10/27/2020 12:56:04 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:cf731c2e4f81f9cbbbcbf2c89feb3f9990fbe1e4aecbd0f2ce1fa0eb1daab0a7 | 10/27/2020 13:46:06  | 11/19/2020 15:19:08 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:278f1fafd388ccd570ee9165ea417ebb3251522f67a64cfe9369e1c0612d4b07 | 11/19/2020 15:55:47  | 11/19/2020 15:55:47 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:b5ca86b9a4f76053de4539e916f8d3a90fd593845ee6e37ffb30dca9d938c875 | 08/14/2020 12:10:21  | 11/19/2020 14:22:17 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:2d5dab54eb416027c76ee0ceef569e06ffad4d91cbfe5ce5d8f6a3fee1480965 | 08/14/2020 12:10:11  | 08/14/2020 12:10:11 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:2e2bd21a3e48b4a82cba01a02f134e68f14bcf44a2efc1e49ab208405202566f | 08/14/2020 11:23:07  | 08/14/2020 11:23:07 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:563e942fd96d43fc37eeacc2426a18b9788b109a4d4cf39b598b659e3bdc27df | 10/05/2020 18:41:28  | 10/05/2020 18:41:28 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:74f0b65765ecb487d607dd03c15fac5161c9ada82e215a97be7f41a88010b685 | 10/05/2020 17:50:44  | 10/05/2020 17:50:44 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:3a13225a746882e237417cfc62931f813f2ded9f0587b1eb5986af6744159df4 | 10/27/2020 13:20:47  | 10/27/2020 13:20:47 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:5ab10e459701928badb1c46d6b0b8ef9d1e5ca12cb69322694cdd785c41dfff8 | 10/27/2020 12:55:13  | 10/27/2020 12:55:13 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:66506a9e25f41186a666680788ecfa0f3d3e942a43a7c775e9922d9fb842031b | 10/27/2020 13:45:54  | 10/27/2020 13:45:54 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:b5ca86b9a4f76053de4539e916f8d3a90fd593845ee6e37ffb30dca9d938c875 | 11/19/2020 14:22:04  | 11/19/2020 14:22:04 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:cf731c2e4f81f9cbbbcbf2c89feb3f9990fbe1e4aecbd0f2ce1fa0eb1daab0a7 | 11/19/2020 15:18:54  | 11/19/2020 15:18:54 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:278f1fafd388ccd570ee9165ea417ebb3251522f67a64cfe9369e1c0612d4b07 | 11/19/2020 15:55:32  | 11/19/2020 15:55:32 |
### xc1-cd
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:ded8648886c3fa5ace6e7ff7e6461419d65a118966abb7e0a52a5bf50c6fb81e | 08/14/2020 10:06:41  | 10/27/2020 12:41:56 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:e53e7ce14c33270d9b87f38e27d01b28d21eaf3bf69b59baffce518160e04d7c | 10/27/2020 13:33:14  | 11/19/2020 14:57:59 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:191de7aff572ec9848badf4a679d105af58d8974e0e0bbab2e226765e1591ddb | 11/19/2020 15:36:59  | 11/19/2020 15:36:59 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:8a056467d216490131b8af08d5ec3a668bc90e0fe5bff4fb2f29e8de6ba44d97 | 08/14/2020 11:51:00  | 11/19/2020 13:54:59 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:0b10d4286c7fefaaf810924ccae7f5a626fd8ce057631c20bc4d6647cee68dab | 08/14/2020 11:50:50  | 08/14/2020 11:50:50 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:dedf0c0c1619c2e03bc3bac450da0cb00de6128ee2fd05168e9d04a39ba3248d | 08/14/2020 11:07:44  | 08/14/2020 11:07:44 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:806a98ca81f018578ff4e274e8d86997a67c4e2a64785b122442f00f807356c8 | 10/05/2020 18:25:50  | 10/05/2020 18:25:50 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:ae755c619d7f23ea1861880dadfeacfaede9a9518f27fba69e1fa4e7fa28f0c4 | 10/05/2020 17:37:42  | 10/05/2020 17:37:42 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:b25c9f553271e2305dc1a7964da0b9bc35905267f055af36c4eae43b2313e597 | 10/27/2020 13:07:45  | 10/27/2020 13:07:45 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:ded8648886c3fa5ace6e7ff7e6461419d65a118966abb7e0a52a5bf50c6fb81e | 10/27/2020 12:41:43  | 10/27/2020 12:41:43 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:29579a4579cff63b9ae176d13caaff04df3d87271a7e968b9ef0c2a6342035c7 | 10/27/2020 13:33:02  | 10/27/2020 13:33:02 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:8a056467d216490131b8af08d5ec3a668bc90e0fe5bff4fb2f29e8de6ba44d97 | 11/19/2020 13:54:45  | 11/19/2020 13:54:45 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:e53e7ce14c33270d9b87f38e27d01b28d21eaf3bf69b59baffce518160e04d7c | 11/19/2020 14:57:41  | 11/19/2020 14:57:41 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:191de7aff572ec9848badf4a679d105af58d8974e0e0bbab2e226765e1591ddb | 11/19/2020 15:36:45  | 11/19/2020 15:36:45 |
### xc1-cm
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:12a77cdba41416a89c90ecc212656f078c6351201c46fde9d31797679e87a1f5 | 08/14/2020 10:05:49  | 10/27/2020 12:41:18 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:c657f95fdf2f0abf83186e50d88bbd292689d35db04e7cd2fe8d2f5823ac27c1 | 10/27/2020 13:32:33  | 11/19/2020 14:57:16 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:64cc7573c7ab8e05b715009fedd2780aa3a2cd1f8954494130bd83a408d9f2b0 | 11/19/2020 15:35:32  | 11/19/2020 15:35:32 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:12569b6a2083bc971a67287b9b9617a2018260c159a500d07c396a1ac72f1dee | 08/14/2020 11:50:29  | 11/19/2020 13:54:18 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:06ea57aa33ac56a5e16d4d85172de4783398a7cea54d61efbda8c85c929f7d31 | 08/14/2020 11:50:18  | 08/14/2020 11:50:18 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:d6d031c7b594fda2c7c9aaf31f8201c159581a5c7fa331b36f47a55a56e1d509 | 08/14/2020 11:07:17  | 08/14/2020 11:07:17 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:cf59732287a4b3c909a1231aae175a0c8201ab37912fa148693eecbe07f0d2bb | 10/05/2020 18:25:25  | 10/05/2020 18:25:25 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:5a4dc09b4bb2a45f034a7b0765fea046c7e3fe149353a87fc2c209fe945b8a3a | 10/05/2020 17:37:15  | 10/05/2020 17:37:15 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:7fba6bcfeef23b62a289c7093661717f01fbbcb4c08db8f9db1eaa3e589e0d5f | 10/27/2020 13:07:13  | 10/27/2020 13:07:13 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:12a77cdba41416a89c90ecc212656f078c6351201c46fde9d31797679e87a1f5 | 10/27/2020 12:41:06  | 10/27/2020 12:41:06 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:6f86fecd194d8d295a027232e0608e119940ba584748a5669078563732ffdd06 | 10/27/2020 13:32:20  | 10/27/2020 13:32:20 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:12569b6a2083bc971a67287b9b9617a2018260c159a500d07c396a1ac72f1dee | 11/19/2020 13:54:00  | 11/19/2020 13:54:00 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:c657f95fdf2f0abf83186e50d88bbd292689d35db04e7cd2fe8d2f5823ac27c1 | 11/19/2020 14:57:02  | 11/19/2020 14:57:02 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:64cc7573c7ab8e05b715009fedd2780aa3a2cd1f8954494130bd83a408d9f2b0 | 11/19/2020 15:35:17  | 11/19/2020 15:35:17 |
### xc1-mssql-init
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:9507270d9a801366eeecdd8295a9be0a74b46772d056d80e40a5d63d2fa1e9fa | 08/14/2020 10:11:35  | 10/27/2020 12:44:47 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:429ca85f8f939600d1683621349443c10756835bb8d0d4961ddd835e58b8791e | 10/27/2020 13:36:24  | 11/19/2020 15:03:08 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:21e3b2d7ae0c779b128bbcbf2f58608b3728981cc163e836c06a4e809bf350e1 | 11/19/2020 15:41:03  | 11/19/2020 15:41:03 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:ed59477346e4536a7b49bc15ddcd433c73afca1145d85d34f3dcc3570cd6c54d | 08/14/2020 11:54:10  | 11/19/2020 13:59:39 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:673a0cacbb00d00498ed1444a398452d16e84654450d87f13001abd1e4f3752f | 08/14/2020 11:54:00  | 08/14/2020 11:54:00 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:76ae5adfe6bfb368ec889c2b523ed8edc132bba7da51e91438e42569dc17b4ed | 08/14/2020 11:10:34  | 08/14/2020 11:10:34 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:a03c2b03c6bda1022ddb89c209e234d8ad202a6848f19966257b7c5980f0fce8 | 10/05/2020 18:28:32  | 10/05/2020 18:28:32 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:6cb7c09fd540b088244c9916882fe1607c65f639bb917b999d6764b6c11ad027 | 10/05/2020 17:40:57  | 10/05/2020 17:40:57 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:de5c9a79106723b2865b2e9e55feff705ad19fea53c3a5bdef656570526ae4a4 | 10/27/2020 13:10:32  | 10/27/2020 13:10:32 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:9507270d9a801366eeecdd8295a9be0a74b46772d056d80e40a5d63d2fa1e9fa | 10/27/2020 12:44:35  | 10/27/2020 12:44:35 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:cfef7e5dac7f2476eee67694a0991020c199816a276cee4b43424b66fb2a9a95 | 10/27/2020 13:36:13  | 10/27/2020 13:36:13 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:ed59477346e4536a7b49bc15ddcd433c73afca1145d85d34f3dcc3570cd6c54d | 11/19/2020 13:59:27  | 11/19/2020 13:59:27 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:429ca85f8f939600d1683621349443c10756835bb8d0d4961ddd835e58b8791e | 11/19/2020 15:02:56  | 11/19/2020 15:02:56 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:21e3b2d7ae0c779b128bbcbf2f58608b3728981cc163e836c06a4e809bf350e1 | 11/19/2020 15:40:51  | 11/19/2020 15:40:51 |
### xc1-solr-init
Tag                                         | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                 | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:f55b95208b70f6bf48b6854d9092785f3a9cc83af36d5c1c5c9a7ce12cd1029a | 08/14/2020 10:10:52  | 10/27/2020 12:44:18 |
10.0.0-2004                                 | 10.0.19041.630  | 2004        | amd64           | windows | sha256:4cec73884cbb8b1929cbe96c141f8f56802d758cc9e1eb81cb58ff22edea166f | 10/27/2020 13:35:56  | 11/19/2020 15:02:02 |
10.0.0-2009                                 | 10.0.19042.630  | 2009        | amd64           | windows | sha256:64087664f63cafaf81b75294af0df89327c34c490b8c70ed75aa08047aba6951 | 11/19/2020 15:40:33  | 11/19/2020 15:40:33 |
10.0.0-ltsc2019                             | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:8d44ff7a557e5dd19726892385dce8e25e258a0684a569434b13ad10959d6d94 | 08/14/2020 11:53:45  | 11/19/2020 13:59:04 |
10.0.0.60238.10214-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:2820447d9b8716d0f23fa2b02111684910778b2cf5f012705b40ee3ca36485aa | 08/14/2020 11:53:35  | 08/14/2020 11:53:35 |
10.0.0.60238.10214-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:2c72782048fa08e434994247854b15b7b3379f72bb3edda02025c74004fd5325 | 08/14/2020 11:10:08  | 08/14/2020 11:10:08 |
10.0.0.60238.10218-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:a073602c878e8d14f11d9a95b9182e2a2e9197f76bc807a8e9ec3d6104e8d8a5 | 10/05/2020 18:28:10  | 10/05/2020 18:28:10 |
10.0.0.60238.10218-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:5e51aae4e906eb9ca8e5b02a6199ed7ee7942def43eb3e8d3bbef4f4dce2a960 | 10/05/2020 17:40:37  | 10/05/2020 17:40:37 |
10.0.0.60238.10220-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:808e5765ad75ff30a98669ecc2c9db7a8b4b0f096955720f8f31a5f755dcc77b | 10/27/2020 13:10:02  | 10/27/2020 13:10:02 |
10.0.0.60238.10220-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:f55b95208b70f6bf48b6854d9092785f3a9cc83af36d5c1c5c9a7ce12cd1029a | 10/27/2020 12:44:06  | 10/27/2020 12:44:06 |
10.0.0.60238.10220-10.0.19041.572-2004      | 10.0.19041.572  | 2004        | amd64           | windows | sha256:d3cccfd8073a81cec8a14c24e3ee9f9073f8d52d1db7fa22ab0fda12a3cc4c4b | 10/27/2020 13:35:43  | 10/27/2020 13:35:43 |
10.0.0.60238.10224-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:8d44ff7a557e5dd19726892385dce8e25e258a0684a569434b13ad10959d6d94 | 11/19/2020 13:58:49  | 11/19/2020 13:58:49 |
10.0.0.60238.10224-10.0.19041.630-2004      | 10.0.19041.630  | 2004        | amd64           | windows | sha256:4cec73884cbb8b1929cbe96c141f8f56802d758cc9e1eb81cb58ff22edea166f | 11/19/2020 15:01:48  | 11/19/2020 15:01:48 |
10.0.0.60238.10224-10.0.19042.630-2009      | 10.0.19042.630  | 2009        | amd64           | windows | sha256:64087664f63cafaf81b75294af0df89327c34c490b8c70ed75aa08047aba6951 | 11/19/2020 15:40:21  | 11/19/2020 15:40:21 |
## sxp/modules 
This namespace includes images for modules of the *Sitecore Experience Platform (SXP)*. 
### jss-xm1-assets
Tag                                   | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
14.0.0-1809                           | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:eb41ad910d74aa5f395e03133a9c12817e6171bf3ed56b1da57a6950fa327724 | 08/03/2020 15:17:41  | 08/03/2020 15:17:41 |
14.0.0.00368.71-10.0.17763.1339-1809  | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:eb41ad910d74aa5f395e03133a9c12817e6171bf3ed56b1da57a6950fa327724 | 08/03/2020 15:17:27  | 08/03/2020 15:17:27 |
15.0.0-1809                           | 10.0.17763.1518 | 1809        | amd64           | windows | sha256:7e05c46cf20be912f64cdec30ff5cafbc8986fcc8f9bf26af1058a1103b7ce40 | 10/29/2020 08:39:13  | 10/29/2020 08:39:13 |
15.0.0.00398.129-10.0.17763.1518-1809 | 10.0.17763.1518 | 1809        | amd64           | windows | sha256:7e05c46cf20be912f64cdec30ff5cafbc8986fcc8f9bf26af1058a1103b7ce40 | 10/29/2020 08:39:00  | 10/29/2020 08:39:00 |
15.0.1-1809                           | 10.0.17763.1577 | 1809        | amd64           | windows | sha256:4d8f9ec3b18e204d47e4d5535ee00810818ed3945f34386f8b5a190cae0601a0 | 11/20/2020 10:07:07  | 11/20/2020 10:07:07 |
15.0.1.00403.169-10.0.17763.1577-1809 | 10.0.17763.1577 | 1809        | amd64           | windows | sha256:4d8f9ec3b18e204d47e4d5535ee00810818ed3945f34386f8b5a190cae0601a0 | 11/20/2020 10:06:55  | 11/20/2020 10:06:55 |
### jss-xp1-assets
Tag                                   | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
14.0.0-1809                           | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:ca24e19d2f96d239852a1fba4bf35782abf46616f66434a1ff5db6e8ef8e1ccf | 08/03/2020 15:18:20  | 08/03/2020 15:18:20 |
14.0.0.00368.71-10.0.17763.1339-1809  | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:ca24e19d2f96d239852a1fba4bf35782abf46616f66434a1ff5db6e8ef8e1ccf | 08/03/2020 15:18:04  | 08/03/2020 15:18:04 |
15.0.0-1809                           | 10.0.17763.1518 | 1809        | amd64           | windows | sha256:0d07867e755c7a2b84dc5da7a71e1556f4506c8304a3a7d49648c578f7426a77 | 10/29/2020 08:39:41  | 10/29/2020 08:39:41 |
15.0.0.00398.129-10.0.17763.1518-1809 | 10.0.17763.1518 | 1809        | amd64           | windows | sha256:0d07867e755c7a2b84dc5da7a71e1556f4506c8304a3a7d49648c578f7426a77 | 10/29/2020 08:39:29  | 10/29/2020 08:39:29 |
15.0.1-1809                           | 10.0.17763.1577 | 1809        | amd64           | windows | sha256:95693717166f097331d978e983213b50125f3e62b889133fc555c2fdfb257271 | 11/20/2020 10:07:36  | 11/20/2020 10:07:36 |
15.0.1.00403.169-10.0.17763.1577-1809 | 10.0.17763.1577 | 1809        | amd64           | windows | sha256:95693717166f097331d978e983213b50125f3e62b889133fc555c2fdfb257271 | 11/20/2020 10:07:23  | 11/20/2020 10:07:23 |
### sitecore-management-services-xm1-assets
Tag                                  | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
2.0.0-1809                           | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:5366b11e17dc8eb43f336744a856dcced7fabb973e8a79800444a023a1ee356b | 08/03/2020 15:19:01  | 08/03/2020 15:19:01 |
2.0.0.00202.210-10.0.17763.1339-1809 | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:5366b11e17dc8eb43f336744a856dcced7fabb973e8a79800444a023a1ee356b | 08/03/2020 15:18:44  | 08/03/2020 15:18:44 |
### sitecore-management-services-xp1-assets
Tag                                  | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
2.0.0-1809                           | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:5366b11e17dc8eb43f336744a856dcced7fabb973e8a79800444a023a1ee356b | 08/03/2020 15:19:37  | 08/03/2020 15:19:37 |
2.0.0.00202.210-10.0.17763.1339-1809 | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:5366b11e17dc8eb43f336744a856dcced7fabb973e8a79800444a023a1ee356b | 08/03/2020 15:19:22  | 08/03/2020 15:19:22 |
### spe-assets
Tag                            | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
6.1.1-1809                     | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:411ab60d60e443db0e2a94065d48cf19d76e42ed44f749f26f19db821509ef68 | 08/03/2020 15:15:30  | 08/03/2020 15:15:30 |
6.1.1.205-10.0.17763.1339-1809 | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:411ab60d60e443db0e2a94065d48cf19d76e42ed44f749f26f19db821509ef68 | 08/03/2020 15:15:15  | 08/03/2020 15:15:15 |
### sxa-xm1-assets
Tag                                  | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809                          | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:ae0c32d1b852ae82b2cb9acf390b824fa433bf7a4a5e5d997eb79fdfa903b792 | 08/03/2020 15:16:16  | 08/03/2020 15:16:16 |
10.0.0.3138.205-10.0.17763.1339-1809 | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:ae0c32d1b852ae82b2cb9acf390b824fa433bf7a4a5e5d997eb79fdfa903b792 | 08/03/2020 15:15:57  | 08/03/2020 15:15:57 |
### sxa-xp1-assets
Tag                                  | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809                          | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:8790d05189b0cee679dc696ee2898d88daa6be228fb2038ade80235645f33f41 | 08/03/2020 15:17:05  | 08/03/2020 15:17:05 |
10.0.0.3138.205-10.0.17763.1339-1809 | 10.0.17763.1339 | 1809        | amd64           | windows | sha256:8790d05189b0cee679dc696ee2898d88daa6be228fb2038ade80235645f33f41 | 08/03/2020 15:16:43  | 08/03/2020 15:16:43 |
## sxp/nonproduction 
This namespace includes images for *Sitecore Experience Platform (SXP)* supporting roles intended for development and testing. No production support is provided for images labeled as nonproduction. 
### mssql-developer
Tag                                             | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
2017-10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:55eb10b9ad4ee5b5fbcc2220276e5c2b3bd41686ace15a3211a3eac4d0e9faa0 | 08/03/2020 13:55:46  | 10/22/2020 21:09:17 |
2017-10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:6c49b05515567729109248fcc6cb55264f70ed220bb2d7429e56a36b88dedce9 | 10/22/2020 22:14:17  | 11/18/2020 12:21:55 |
2017-10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:d51ecbeb56dfd98ba6637adc1225b836d906ed13dddd74473f282066ab5cfd3a | 11/18/2020 13:14:24  | 11/18/2020 13:14:24 |
2017-10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:6c3a4c7d4757fb5b98380d4757a187046f2af6c00dec7769766b30cfa71a2214 | 08/03/2020 14:41:52  | 11/18/2020 11:36:47 |
2017-10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:d51ecbeb56dfd98ba6637adc1225b836d906ed13dddd74473f282066ab5cfd3a | 11/18/2020 13:14:11  | 11/18/2020 13:14:11 |
2017-10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:376ad4f7f5949bcdd644a7bf4b3464d3cb90e9bf8bfd8b9e5ea9e4dca5fe954a | 10/22/2020 22:14:04  | 10/22/2020 22:14:04 |
2017-10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:bca15b37ecb04eea7915318bc1ec8769d1cbb533ab324a9ce0529eaba72b28b5 | 08/03/2020 13:55:29  | 08/03/2020 13:55:29 |
2017-10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:e114329cdaf57d65b98a651ed402392b7e9204cf68f6dd5c17072ce503d29e76 | 08/03/2020 19:59:01  | 08/03/2020 19:59:01 |
2017-10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:dbae4fba18f1998a0dbef63447e4c2cdf00abce46fe9071839536e37b283cd4b | 08/03/2020 14:41:40  | 08/03/2020 14:41:40 |
2017-10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:e4349ec0b9a79036f426977b0e9077de62f0db90de1583dfec1aa105a81ac0e0 | 08/03/2020 20:26:17  | 08/03/2020 20:26:17 |
2017-10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:46363e4204761ded3ef39b0d4e862cee2f0499bb304afb91e63cd9b4ff17c77e | 08/25/2020 10:46:42  | 08/25/2020 10:46:42 |
2017-10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:c533735c35dd6e11a834e3d24c7f005913d24abffea8aa1b34504e0f06ba83e4 | 08/25/2020 11:18:06  | 08/25/2020 11:18:06 |
2017-10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:573a4cbf3021ae3c5885e57dd53112dbf607df6374ac133d666e342604c85989 | 09/15/2020 09:35:04  | 09/15/2020 09:35:04 |
2017-10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:38f367f7576f55dd653502e218b6d27ee488fdad91425772348aaa8b84d0e0f2 | 09/15/2020 10:11:51  | 09/15/2020 10:11:51 |
2017-10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:55eb10b9ad4ee5b5fbcc2220276e5c2b3bd41686ace15a3211a3eac4d0e9faa0 | 10/22/2020 21:09:05  | 10/22/2020 21:09:05 |
2017-10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:914b97747097c2399c3ee757419d7d154ab3cfef906a3689f42a336457e39c17 | 10/22/2020 21:41:55  | 10/22/2020 21:41:55 |
2017-10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:6c3a4c7d4757fb5b98380d4757a187046f2af6c00dec7769766b30cfa71a2214 | 11/18/2020 11:36:32  | 11/18/2020 11:36:32 |
2017-10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:6c49b05515567729109248fcc6cb55264f70ed220bb2d7429e56a36b88dedce9 | 11/18/2020 12:21:40  | 11/18/2020 12:21:40 |
### solr
Tag                                              | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
8.4.0-10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:78f508a7cf0738faa4994ab7dc2c523c0949fa7ce65b825809db986eff3efc02 | 08/03/2020 13:56:48  | 10/22/2020 21:10:04 |
8.4.0-10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:3e4a41c636742b80b3313c87cfc447837f9d394ac14a27d1d26c5dea17bf494b | 10/22/2020 22:15:18  | 11/18/2020 12:23:29 |
8.4.0-10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:c0e1eefed82a7c5f765298da52207bb97a77d4ee66d7ef23f972f70224a7298d | 11/18/2020 13:15:33  | 11/18/2020 13:15:33 |
8.4.0-10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:23d806633c161da15027ba7b2466468aed33e44ded2c891f26302aa02c3974ea | 08/03/2020 14:42:48  | 11/18/2020 11:38:35 |
8.4.0-10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:c0e1eefed82a7c5f765298da52207bb97a77d4ee66d7ef23f972f70224a7298d | 11/18/2020 13:15:20  | 11/18/2020 13:15:20 |
8.4.0-10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:88128d8c9c596c54897765d8cafd89dd7e557c0a5c3dd2cb80cb6535241ee8cb | 10/22/2020 22:15:06  | 10/22/2020 22:15:06 |
8.4.0-10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:97c74a29ec539102105b7fbdc22e12cc8a492683ce8103f659b36cee94669c97 | 08/03/2020 13:56:30  | 08/03/2020 13:56:30 |
8.4.0-10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:3d695da0b975ae5341aa631b3a7f7cbc63a76fd9dc1879d240fd2edbbaeb8b8e | 08/03/2020 19:59:34  | 08/03/2020 19:59:34 |
8.4.0-10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:5f29f8e85abc5686b93cd390e649455d15c347d6435437f4a89bedfab4e506ac | 08/03/2020 14:42:36  | 08/03/2020 14:42:36 |
8.4.0-10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:41f1d1843d36b82c8be6120a49c45c0ce428a92d0179232ad4248cad078dbce4 | 08/03/2020 20:27:11  | 08/03/2020 20:27:11 |
8.4.0-10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:3c263e8f7f1574e5e01ee455fbd27d79391a8089014072d129bac23f93dbebe5 | 08/25/2020 10:47:22  | 08/25/2020 10:47:22 |
8.4.0-10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:708816c90f822a602469dce16eb522afee8c4704f9b3b1bf1b4327759942029b | 08/25/2020 11:18:58  | 08/25/2020 11:18:58 |
8.4.0-10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:84f92f57656aa67dfa49593b2f95e5d58bab52222fcb69dc6c1e5afc5fa39901 | 09/15/2020 09:35:41  | 09/15/2020 09:35:41 |
8.4.0-10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:9083120187cef16815c9da42d2347e5870b7f45a15fb9ed0d0672488e976b54d | 09/15/2020 10:12:36  | 09/15/2020 10:12:36 |
8.4.0-10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:78f508a7cf0738faa4994ab7dc2c523c0949fa7ce65b825809db986eff3efc02 | 10/22/2020 21:09:51  | 10/22/2020 21:09:51 |
8.4.0-10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:291b7b90f664fde30c2a2514ad4595d286a287e755b249c59d589b5a7eccb457 | 10/22/2020 21:42:40  | 10/22/2020 21:42:40 |
8.4.0-10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:23d806633c161da15027ba7b2466468aed33e44ded2c891f26302aa02c3974ea | 11/18/2020 11:38:23  | 11/18/2020 11:38:23 |
8.4.0-10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:3e4a41c636742b80b3313c87cfc447837f9d394ac14a27d1d26c5dea17bf494b | 11/18/2020 12:23:14  | 11/18/2020 12:23:14 |
## sxp 
This namespace includes images of the *Sitecore Experience Platform (SXP)*. 
### sitecore-id
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fef3e3dcba3b4859c3b09ba845a55dfa496b6c2a754adf3f9b20803a456bed83 | 08/03/2020 13:58:04  | 10/22/2020 21:11:03 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:c45ca1bfc6e9534495b61aa6f9898bbac420b75e811082e3e0ac0a94d0f7bf3c | 10/22/2020 22:16:47  | 11/18/2020 12:25:18 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:dc914cdba31566dfe1ba1a627baa5f09ab55405f4410869358a72ddd06022920 | 11/18/2020 13:16:54  | 11/18/2020 13:16:54 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:cc5709f0989e9a242ec4574f07ec27dd8d64665a4f21dc64fbff1752d9f814ae | 08/03/2020 14:44:03  | 11/18/2020 11:40:29 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:dc914cdba31566dfe1ba1a627baa5f09ab55405f4410869358a72ddd06022920 | 11/18/2020 13:16:40  | 11/18/2020 13:16:40 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:a51e4d594627d0c90aa3633f85048671131d3c09720569a4675b54281fba4c6b | 10/22/2020 22:16:35  | 10/22/2020 22:16:35 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:3cc30d992a7d054b3990fcc1894c9369b5cd28919c01e02e82c06d9644959060 | 08/03/2020 13:57:48  | 08/03/2020 13:57:48 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:0813f06712e6b77e6902e49c9e25e4524888f60322c0c1554ebdbc7daaa3e8ce | 08/03/2020 20:00:35  | 08/03/2020 20:00:35 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:1008795d914eb0510cab1a0d8ee54109ff23727c180150cce87a47d067747f7f | 08/03/2020 14:43:52  | 08/03/2020 14:43:52 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:428899f0088164733368166efd4adaf5b3f4d93809a39002069d554e5078f874 | 08/03/2020 20:28:06  | 08/03/2020 20:28:06 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:119d09b112cfaad9eed336febfc0830c441a0d0a66ab7fd221eb29db48031384 | 08/25/2020 10:48:41  | 08/25/2020 10:48:41 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:71f86002dd9a8c1e532d8f152ab10bb0f6e15e1991d33cac8c7496562e95daa4 | 08/25/2020 11:20:03  | 08/25/2020 11:20:03 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:a546f9465d80c1317236abe689f71af1e08f4c06887bb611313c026a218e48c9 | 09/15/2020 09:37:42  | 09/15/2020 09:37:42 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:86d7f54f9e880bdc881aa8924b1249efef6b4fb436fbeab6371bb94fe44f3fd9 | 09/15/2020 10:14:05  | 09/15/2020 10:14:05 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fef3e3dcba3b4859c3b09ba845a55dfa496b6c2a754adf3f9b20803a456bed83 | 10/22/2020 21:10:53  | 10/22/2020 21:10:53 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:e25651d060570ac25d84354432fa679dfe289a97c2b80a902e20d9dd47111181 | 10/22/2020 21:43:54  | 10/22/2020 21:43:54 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:cc5709f0989e9a242ec4574f07ec27dd8d64665a4f21dc64fbff1752d9f814ae | 11/18/2020 11:40:08  | 11/18/2020 11:40:08 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:c45ca1bfc6e9534495b61aa6f9898bbac420b75e811082e3e0ac0a94d0f7bf3c | 11/18/2020 12:25:00  | 11/18/2020 12:25:00 |
### sitecore-redis
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fbedd37686ad4ae012900dac865e1657490939cf185ca08d35f3fbfda8151b7c | 08/03/2020 13:58:44  | 10/22/2020 21:11:30 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:54926329773f3edffd77ad979bd99ec7476087dbbd09da60f524fa4d8fd688be | 10/22/2020 22:17:40  | 11/18/2020 12:25:48 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:13b20b70c4132b684f05f119fade1acdad401dd139d6ddde1cd1a805747f0d99 | 11/18/2020 13:17:45  | 11/18/2020 13:17:45 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:17198a8f450e7e9fa7b44cd4c917b2a3e31383432da0f76f8ff93b8e9962bb75 | 08/03/2020 14:44:52  | 11/18/2020 11:41:32 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:13b20b70c4132b684f05f119fade1acdad401dd139d6ddde1cd1a805747f0d99 | 11/18/2020 13:17:33  | 11/18/2020 13:17:33 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:b56c72fb4db7d62f1aa900b07855f67d5e6fd6c19cb6317c8470e2543fc872b0 | 10/22/2020 22:17:27  | 10/22/2020 22:17:27 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:bdd870b6ddbf50b61432f7a8e3708523f8496b75d36b33abb259137cf2b1d99b | 08/03/2020 13:58:28  | 08/03/2020 13:58:28 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:1fbdef6b4b1a1a756f14a0b8c6f07dbde0172e6de01f37dcd936fbf8b85ce7ee | 08/03/2020 20:01:00  | 08/03/2020 20:01:00 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:07158d9185bc8f32f18fcd811061b35c476390f5fffd7ac0584d6f9ca4c80d7a | 08/03/2020 14:44:40  | 08/03/2020 14:44:40 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:db6fc2fb3fa87ded8397b7ceb335f58601d8c2f5ec5b9c744be7cbfa0f49e663 | 08/03/2020 20:28:29  | 08/03/2020 20:28:29 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:908f306a656c6713cb44aafca7db08d3d8615997b80d4bbd946c695d8b00b952 | 08/25/2020 10:49:03  | 08/25/2020 10:49:03 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:3cb2e1d0c9d4d1bc8aa873e1ba6a66812a1a6c65f035bd057ae4c818f13c72b9 | 08/25/2020 11:20:28  | 08/25/2020 11:20:28 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:19a8493c5b9ef1f1bda2006f2282ee81392292f62ce93ee38ada0e2f15ed20e2 | 09/15/2020 09:38:02  | 09/15/2020 09:38:02 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:87cc353586c62d31641726e3e4e7b5503944a490f7c2237c481bdb366b388287 | 09/15/2020 10:14:48  | 09/15/2020 10:14:48 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fbedd37686ad4ae012900dac865e1657490939cf185ca08d35f3fbfda8151b7c | 10/22/2020 21:11:19  | 10/22/2020 21:11:19 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:926d7ee4b7b8735359f64f68559a1bc91ea6da87c98d15efa9dd08b28f5baf90 | 10/22/2020 21:44:38  | 10/22/2020 21:44:38 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:17198a8f450e7e9fa7b44cd4c917b2a3e31383432da0f76f8ff93b8e9962bb75 | 11/18/2020 11:41:19  | 11/18/2020 11:41:19 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:54926329773f3edffd77ad979bd99ec7476087dbbd09da60f524fa4d8fd688be | 11/18/2020 12:25:37  | 11/18/2020 12:25:37 |
### sitecore-xm1-cd
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:01ad1123a55f4d2fde6c8d0bca8314e874e285ad9d087b341290912a0954b4f0 | 08/03/2020 14:02:08  | 10/22/2020 21:13:12 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:39bc68a2e3449af0d4df64c5f5eb207647afc1c436f9d9b79c033015ffb5ae7b | 10/22/2020 22:19:48  | 11/18/2020 12:28:04 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:56ac22ade48b5eb45d3e17eec8ebe68e0ddb600a44e128bbda020dcb62162985 | 11/18/2020 13:20:53  | 11/18/2020 13:20:53 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:b16a927a1a1bea25283835e91dfb589e8e3651f958aebf0d6463b7dbfc3efe96 | 08/03/2020 14:51:33  | 11/18/2020 11:48:27 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:56ac22ade48b5eb45d3e17eec8ebe68e0ddb600a44e128bbda020dcb62162985 | 11/18/2020 13:20:34  | 11/18/2020 13:20:34 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:7fd959b09d946301798b646d670ef517e83a3f545e1cb3e196cb15492c48b3ff | 10/22/2020 22:19:21  | 10/22/2020 22:19:21 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:73d047fba8e07a1ae2e639c38eb95e60c484df254c77f29e9b95801aea335f47 | 08/03/2020 14:01:52  | 08/03/2020 14:01:52 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:38ea54848d38a93ac0b484d7734e555dbb7ccc5d5639264b41d9d15d92dd1a3f | 08/03/2020 20:02:33  | 08/03/2020 20:02:33 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:c8cd3149eafabd05302287af29aab5f06d699147b51a7c65d39c2b142e6a6b7b | 08/03/2020 14:51:21  | 08/03/2020 14:51:21 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:e605fe117d3bdef317d0efd6b4fb01eadcbf53702a545918f8e3354b53c6a768 | 08/03/2020 20:32:09  | 08/03/2020 20:32:09 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:1b05fb0fcf152df4340a472a40460d0fad602dd5dccad02f61bf49c9da9ea2c5 | 08/25/2020 10:50:57  | 08/25/2020 10:50:57 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:721c1f5499c49c040757bd2b9632b5d74d918b2c0806409224e4d67a55bdcd71 | 08/25/2020 11:22:24  | 08/25/2020 11:22:24 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:7bd202966ce25aac8a593e46cdb21f81f27b4c9ccea002425534277fef277e53 | 09/15/2020 09:41:04  | 09/15/2020 09:41:04 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:9ba0f7e9f70478f38dd07b6f7cf8271210f8b3fdb3f6b5e57e77a8b4d064f5da | 09/15/2020 10:20:53  | 09/15/2020 10:20:53 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:01ad1123a55f4d2fde6c8d0bca8314e874e285ad9d087b341290912a0954b4f0 | 10/22/2020 21:12:59  | 10/22/2020 21:12:59 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:fea409f37a5481798971507e4f5a64fb6c4404f928c5a14fbba4b1bf507b95bf | 10/22/2020 21:49:47  | 10/22/2020 21:49:47 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:b16a927a1a1bea25283835e91dfb589e8e3651f958aebf0d6463b7dbfc3efe96 | 11/18/2020 11:47:48  | 11/18/2020 11:47:48 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:39bc68a2e3449af0d4df64c5f5eb207647afc1c436f9d9b79c033015ffb5ae7b | 11/18/2020 12:27:51  | 11/18/2020 12:27:51 |
### sitecore-xm1-cm
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:996d78fe73a8ab3228e1d9910ceb5115007cc9c31f3e6c0ea2b5b4423c9e56e1 | 08/03/2020 14:03:24  | 10/22/2020 21:14:21 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:16760a1ec8225c7e0f87bf16347f5d4a99addc31a2b965337422d72bf4e9338e | 10/22/2020 22:21:11  | 11/18/2020 12:29:58 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:cc0a8dfb0684c99c0215c024df41a31eda809bdd1ba981f596133de91714fe61 | 11/18/2020 13:22:01  | 11/18/2020 13:22:01 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:178a99aa6dc4ea3ae4946179316c2ff1427906fd36a2e0918091e10423dbbde4 | 08/03/2020 14:52:54  | 11/18/2020 11:50:13 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:cc0a8dfb0684c99c0215c024df41a31eda809bdd1ba981f596133de91714fe61 | 11/18/2020 13:21:48  | 11/18/2020 13:21:48 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:78ab31633db07474a0c1342cfdcf3a79ee31e665b2fa24ca0b3527fdad7fe5e9 | 10/22/2020 22:20:59  | 10/22/2020 22:20:59 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:c6a8d76586670669833022a6bc8d19809e57696454c08f818e7a284081e34252 | 08/03/2020 14:03:09  | 08/03/2020 14:03:09 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:aad446f0b5384383021c05cdbb3e6954165f666cbbd6bf5116491319ece2ae90 | 08/03/2020 20:03:35  | 08/03/2020 20:03:35 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:084985817c61a6ac369acd98502a3364e7a6aa386affb98cda8b1fbc9c94616c | 08/03/2020 14:52:43  | 08/03/2020 14:52:43 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:90dcd49fe74b4525f258c332375fd558d33003da4d2deedb5eb9b9a43bdb6386 | 08/03/2020 20:33:16  | 08/03/2020 20:33:16 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:0cb6572aeeeab8f4b4a3445a114e2745cc3764558ba04ad9ce4e1e95e76e9e7e | 08/25/2020 10:52:29  | 08/25/2020 10:52:29 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:74a3e88307f40266a4caf98e8466235cc8be384e9246fd04636a0990bb0455db | 08/25/2020 11:23:17  | 08/25/2020 11:23:17 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:b8f784404eb6acabb0907b511f956fa4f0c1fd5d9e10c120948a7471389eee6f | 09/15/2020 09:42:26  | 09/15/2020 09:42:26 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:0006967e39475032b19b5fa905cb6fee95c2532ce8933b1e94edc7f9410dcf8f | 09/15/2020 10:22:16  | 09/15/2020 10:22:16 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:996d78fe73a8ab3228e1d9910ceb5115007cc9c31f3e6c0ea2b5b4423c9e56e1 | 10/22/2020 21:14:09  | 10/22/2020 21:14:09 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:4fc7c6b9493c1d82afbcd3e366fa49573ebb9baf06b0376c47ff87523a13d56d | 10/22/2020 21:51:06  | 10/22/2020 21:51:06 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:178a99aa6dc4ea3ae4946179316c2ff1427906fd36a2e0918091e10423dbbde4 | 11/18/2020 11:50:00  | 11/18/2020 11:50:00 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:16760a1ec8225c7e0f87bf16347f5d4a99addc31a2b965337422d72bf4e9338e | 11/18/2020 12:29:44  | 11/18/2020 12:29:44 |
### sitecore-xm1-mssql
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:60a80b9132a2b0c5e5a790ff410180d2b61e0149f37eb062bda20f4aebe80a0a | 08/03/2020 14:04:17  | 10/22/2020 21:15:07 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:f56b37ea053982d4c9d1eb1224889554977ad3c0657fe239ba7bef29fc73325a | 10/22/2020 22:22:01  | 11/18/2020 12:31:14 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:034cf79bb3caa48f874639882cc897b976e37c0b56f19684ae65d75098db7750 | 11/18/2020 13:22:53  | 11/18/2020 13:22:53 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:8cad029e6b97476859e028699568f625ead279e13f651706a3284f9d44c8d1a2 | 08/03/2020 14:53:43  | 11/18/2020 11:51:28 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:034cf79bb3caa48f874639882cc897b976e37c0b56f19684ae65d75098db7750 | 11/18/2020 13:22:39  | 11/18/2020 13:22:39 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:77232e86e5c1b3f255453adc55e1eeeac10d3969033394b094ba5b037e0a72eb | 10/22/2020 22:21:49  | 10/22/2020 22:21:49 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:8af1a68fc6cb10e8ebff6155b7b8f48c3629f374cdc92487c28b83b6d698780b | 08/03/2020 14:04:02  | 08/03/2020 14:04:02 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:53c6bf7e23dd3d4777a88faa407bb12f5aa87c4aabd5c4e9c3f6ce97254aaf7f | 08/03/2020 20:04:22  | 08/03/2020 20:04:22 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:5b710f794f3922a71c7f8d325b0320eca8cda97e85cd4c7d7f3acdbad61302e4 | 08/03/2020 14:53:29  | 08/03/2020 14:53:29 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:0377680b3331cc40d0de2260f45b505f32a01bd3326489659587e4b0f73d74cf | 08/03/2020 20:33:59  | 08/03/2020 20:33:59 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:68fd40af1de417756e5af08b6257be99294ef79f82146650c19bb58d7733cb14 | 08/25/2020 10:53:46  | 08/25/2020 10:53:46 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:3829b6fafca5205fc6488f08149a1f4e0795be7065ce0159d9ed8cb79742416d | 08/25/2020 11:24:54  | 08/25/2020 11:24:54 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:961cb8920f455f7544e10eec4c8e4d3347df54599736570cd6098e750b739d02 | 09/15/2020 09:43:10  | 09/15/2020 09:43:10 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:a7286bb7e8d5709d67ace17e76f246207a089afb06edfc35a95aad3dabcb01cb | 09/15/2020 10:22:58  | 09/15/2020 10:22:58 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:60a80b9132a2b0c5e5a790ff410180d2b61e0149f37eb062bda20f4aebe80a0a | 10/22/2020 21:14:55  | 10/22/2020 21:14:55 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:8c4322e69ef96d74a613b3c9d769959e8c5620716148abb823c79d87c3b4b76d | 10/22/2020 21:51:53  | 10/22/2020 21:51:53 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:8cad029e6b97476859e028699568f625ead279e13f651706a3284f9d44c8d1a2 | 11/18/2020 11:50:53  | 11/18/2020 11:50:53 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:f56b37ea053982d4c9d1eb1224889554977ad3c0657fe239ba7bef29fc73325a | 11/18/2020 12:31:01  | 11/18/2020 12:31:01 |
### sitecore-xm1-mssql-init
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:bac434ea821b5e558ea951a088f1707870032ae089b05f32b9ca6d02bb7dd994 | 08/03/2020 14:05:08  | 10/22/2020 21:15:39 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:04aebfc84fbcc703a8473fd856f48e5cbf20c86b5b5b01d66caf119fcdfb2e12 | 10/22/2020 22:22:37  | 11/18/2020 12:32:14 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:12eba1172c19c33f63d21735852dc3f6f7ea047a01759d2db9dda6c403347dcd | 11/18/2020 13:23:30  | 11/18/2020 13:23:30 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:a99780c2a134eeeee9d85920916c74f51c6c37b7f32440151f6896d0eebc478f | 08/03/2020 14:54:19  | 11/18/2020 11:52:16 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:12eba1172c19c33f63d21735852dc3f6f7ea047a01759d2db9dda6c403347dcd | 11/18/2020 13:23:18  | 11/18/2020 13:23:18 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:f85b0f2b38db2da537fac266e8ad292457d8aaefa869d8fa25d74a98f97bb278 | 10/22/2020 22:22:27  | 10/22/2020 22:22:27 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:be9331725fe7f06aecf776feae24e9f41bf4a0b78145dd4d0dabe0da666d86cc | 08/03/2020 14:04:51  | 08/03/2020 14:04:51 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:9d23cbbd4990e0c77d0f3900c2239d42fd24bd4bfba807b8f6d60ea0547c8916 | 08/03/2020 20:04:57  | 08/03/2020 20:04:57 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:cb088919652760b42672bc5d023c669742e657cea25a4971c4ac16a082ecfa01 | 08/03/2020 14:54:09  | 08/03/2020 14:54:09 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:12d97b9279c93156713e1e1761a3be7f9b106d88ae3bb7531ee7e28a384c553a | 08/03/2020 20:34:34  | 08/03/2020 20:34:34 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:98c08890e9b0241afb02bbc98ba8b7b4b98b3a733c640d05e66706b9e80e2a7b | 08/25/2020 10:54:16  | 08/25/2020 10:54:16 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:bc340190333486ad03cb17c8d3d590f4d852452143ada3c1f71aa9aadef83538 | 08/25/2020 11:25:22  | 08/25/2020 11:25:22 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:bb4c505b17d0a0c63a881b590638da528fb35a3ff5a2c74011e8f0042e83493f | 09/15/2020 09:43:39  | 09/15/2020 09:43:39 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:e6e088a8d89c3e48e48ee15a7d95a2ac6777b55eb18bdbb9e496d41686a36e35 | 09/15/2020 10:23:29  | 09/15/2020 10:23:29 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:bac434ea821b5e558ea951a088f1707870032ae089b05f32b9ca6d02bb7dd994 | 10/22/2020 21:15:28  | 10/22/2020 21:15:28 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:a1aa7d7c3f35fa7f643a06e9d6cec00e55064ea4056900f46c2d18dd27ccdc9d | 10/22/2020 21:52:27  | 10/22/2020 21:52:27 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:a99780c2a134eeeee9d85920916c74f51c6c37b7f32440151f6896d0eebc478f | 11/18/2020 11:52:01  | 11/18/2020 11:52:01 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:04aebfc84fbcc703a8473fd856f48e5cbf20c86b5b5b01d66caf119fcdfb2e12 | 11/18/2020 12:31:59  | 11/18/2020 12:31:59 |
### sitecore-xm1-solr
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:b85b8596015aa88a184c4657325f26d5e36b62bca155ffb085e1b897ea700007 | 08/03/2020 14:05:57  | 10/22/2020 21:16:10 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:30f815731e9f0ed9beb1d6daa6f578d0b66f2ad256faa4369d8fbd047c7fd3f0 | 10/22/2020 22:23:11  | 11/18/2020 12:32:59 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:eb904a33183740d2f164a5011b50df8104c8d1d496bbbe6abc2db16fbb64703b | 11/18/2020 13:24:09  | 11/18/2020 13:24:09 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:bad1df983f7283f6b07ef3c78660f1f14bd84a84483f6df09f4c02a6f30a82a3 | 08/03/2020 14:54:53  | 11/18/2020 11:52:57 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:eb904a33183740d2f164a5011b50df8104c8d1d496bbbe6abc2db16fbb64703b | 11/18/2020 13:23:55  | 11/18/2020 13:23:55 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:473fb15c8822b4bfb9d11219f2ca53c14290b9ae05f4497b9da480f6109a0b02 | 10/22/2020 22:23:01  | 10/22/2020 22:23:01 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:e8d4c861a0495548ce3a7e9a320004d51f3f3f8e3e00f320c42bfdf64e093cab | 08/03/2020 14:05:41  | 08/03/2020 14:05:41 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:e1204098531bfb2ab60468a968bfc7165f28ea3bee3eadd3c9966325a65b3e2f | 08/03/2020 20:05:29  | 08/03/2020 20:05:29 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:6ed1365a512018f8df48cee74765542f118852072c93cea6eef5a516cb48bd9c | 08/03/2020 14:54:43  | 08/03/2020 14:54:43 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:b9f95b0115e0829dfc3012ec1117845d06de362f4f674bb30e776dfa8d42ff4d | 08/03/2020 20:35:06  | 08/03/2020 20:35:06 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:10c2bdc26381e6581fd56a4ef812954062dab3bb7ddfd6547b04c022249d0e53 | 08/25/2020 10:54:45  | 08/25/2020 10:54:45 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:0d77039e51288e274485335321a3f68a8c3b382e766258f0773ae4abbc99d32f | 08/25/2020 11:25:49  | 08/25/2020 11:25:49 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:120a3806c51694603dc57e81b134ebeb77c8a3af2b2451ff4d9128df0dd866bb | 09/15/2020 09:44:04  | 09/15/2020 09:44:04 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:bc3fd5346aaf88791f724854a0a100a06a232dbd659e4cbc0de9722294886634 | 09/15/2020 10:23:57  | 09/15/2020 10:23:57 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:b85b8596015aa88a184c4657325f26d5e36b62bca155ffb085e1b897ea700007 | 10/22/2020 21:15:59  | 10/22/2020 21:15:59 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:756ca08a9d21cd2fbb4734c8f1c523f92c91059c80d1d4438d4e269d643337df | 10/22/2020 21:52:58  | 10/22/2020 21:52:58 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:bad1df983f7283f6b07ef3c78660f1f14bd84a84483f6df09f4c02a6f30a82a3 | 11/18/2020 11:52:44  | 11/18/2020 11:52:44 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:30f815731e9f0ed9beb1d6daa6f578d0b66f2ad256faa4369d8fbd047c7fd3f0 | 11/18/2020 12:32:42  | 11/18/2020 12:32:42 |
### sitecore-xm1-solr-init
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:2a62b513c15d0cc9ce738774662391e258c9fe01b6d8a25b84aa706130eb835c | 08/03/2020 14:06:48  | 10/22/2020 21:16:44 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:21b1c22827fd7e874ff91fb2480f092a9ef6c11acdb34a21dc2d50c7ed204265 | 10/22/2020 22:23:47  | 11/18/2020 12:33:59 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b91f4ffaf84f761feb59951bae2fb49290c12f7381e7649b2bf09ba245834348 | 11/18/2020 13:25:01  | 11/18/2020 13:25:01 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:7be1d9e430aac3a784d385465ae628ce7f226d4bc3a1be21b068ed14e2d0d06e | 08/03/2020 14:55:28  | 11/18/2020 11:53:39 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b91f4ffaf84f761feb59951bae2fb49290c12f7381e7649b2bf09ba245834348 | 11/18/2020 13:24:44  | 11/18/2020 13:24:44 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:68c913cde8b0368a6e62cc07d6ff2b336c8e281ba3b859ea5fff6d28847a0564 | 10/22/2020 22:23:36  | 10/22/2020 22:23:36 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:600a7bc72f16558f0a328cbf83fade30a49fb18e5ebc1c6c08ad22367e0afcbc | 08/03/2020 14:06:31  | 08/03/2020 14:06:31 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:e543b554f75bcd05b4c4a90f9043f8599dc9abe74326ddb280b4d24403602b22 | 08/03/2020 20:06:04  | 08/03/2020 20:06:04 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:539c326a4421f7561165d4b3c984b4fb8d652c03f1c8f1df70be9a3dc301aebb | 08/03/2020 14:55:17  | 08/03/2020 14:55:17 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:377b40c09a4f8058dc7f65777704f7aa6d592e04decbfdcab6ddbc33909f82db | 08/03/2020 20:35:40  | 08/03/2020 20:35:40 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:3682c9bb21091e0842e1e9e3ab5fe6812178050173959a0ad69bd98b6fa5dea1 | 08/25/2020 10:55:15  | 08/25/2020 10:55:15 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:8baff14a1d6fe9e44fa2a65c804120ad45142ba32e1f78ed9ad560297270391a | 08/25/2020 11:26:19  | 08/25/2020 11:26:19 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:1dd014fcf280b0aac719a3de066a11a470dc9b1ba95e87b9d1a04b828a128a7d | 09/15/2020 09:44:32  | 09/15/2020 09:44:32 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:97a8cf3a3e1e33d2bf300a86c1c0dc0fb26ae331f841b7a02360d7f07b6c450f | 09/15/2020 10:24:27  | 09/15/2020 10:24:27 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:2a62b513c15d0cc9ce738774662391e258c9fe01b6d8a25b84aa706130eb835c | 10/22/2020 21:16:33  | 10/22/2020 21:16:33 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:b59d61f78ed6a749403de1911892630dc77ab8fbab605e13873b30e772e624b3 | 10/22/2020 21:53:32  | 10/22/2020 21:53:32 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:7be1d9e430aac3a784d385465ae628ce7f226d4bc3a1be21b068ed14e2d0d06e | 11/18/2020 11:53:26  | 11/18/2020 11:53:26 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:21b1c22827fd7e874ff91fb2480f092a9ef6c11acdb34a21dc2d50c7ed204265 | 11/18/2020 12:33:41  | 11/18/2020 12:33:41 |
### sitecore-xp0-cm
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:61f231281b668633ec249f0373e83afc0367050848b407a239991e7d374c6e1c | 08/03/2020 14:28:20  | 10/22/2020 21:31:09 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:ca9aa37dd87fe589918f4dacf75c3ed4e63c2a30c8c691d57c9e0d57caf14655 | 10/22/2020 22:38:47  | 11/18/2020 12:56:02 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:fb506bf10d2b3c5a6c1aa5305aa87a3fe7b862e258837d0299ead0d4de9af299 | 11/18/2020 13:46:04  | 11/18/2020 13:46:04 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:e15515c22ca3839ddbf4a87b43cb05d4bc764fd38f21732182ee075c85d77a04 | 08/03/2020 15:11:39  | 11/18/2020 12:14:15 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:fb506bf10d2b3c5a6c1aa5305aa87a3fe7b862e258837d0299ead0d4de9af299 | 11/18/2020 13:45:50  | 11/18/2020 13:45:50 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:05350db2028c4e582cf355f5cbc054eac72490ab6eef6422902f0c2278f68e49 | 10/22/2020 22:38:36  | 10/22/2020 22:38:36 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:d7602d7f2a753d3cfbed0aef9c6fa0a02779580ab64bbac45eee8e15240f90c5 | 08/03/2020 14:28:03  | 08/03/2020 14:28:03 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:0b5198496ca51d67ee8a51f2ad334c678d1715909e38d5721012f123f712a841 | 08/03/2020 20:19:30  | 08/03/2020 20:19:30 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:cc8e2b17c3fa160b8e1a185a3fc5c4aa311cb3ee1eb3c19df25246c8f522d0b0 | 08/03/2020 15:11:29  | 08/03/2020 15:11:29 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:df862d88d186610362aa288453663d479760cc5c44f0dd2523ada8cfab6830f7 | 08/03/2020 20:50:28  | 08/03/2020 20:50:28 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:589bc5bed0141757a496b004915082d1d27c2afcbd0f82a675d0917b66b280f2 | 08/25/2020 11:12:49  | 08/25/2020 11:12:49 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:293b3916482ae6458a0c13578fb9be84e5f10b6213b6ef95964f825a2f9ad37c | 08/25/2020 11:38:33  | 08/25/2020 11:38:33 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:f6e456de9b67b516f152fa83774e150c1d9523663686875cea3d1ef739251fe7 | 09/15/2020 09:59:27  | 09/15/2020 09:59:27 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:194bb5324497eadeadb24bf9fe72bc9ee0578cdd162199a86be4427f01e4edac | 09/15/2020 10:38:15  | 09/15/2020 10:38:15 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:61f231281b668633ec249f0373e83afc0367050848b407a239991e7d374c6e1c | 10/22/2020 21:30:59  | 10/22/2020 21:30:59 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:d250537a9a86a3717d9c27219c849694c6fdf2b808b45de4cc030167fee45804 | 10/22/2020 22:08:10  | 10/22/2020 22:08:10 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:e15515c22ca3839ddbf4a87b43cb05d4bc764fd38f21732182ee075c85d77a04 | 11/18/2020 12:13:00  | 11/18/2020 12:13:00 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:ca9aa37dd87fe589918f4dacf75c3ed4e63c2a30c8c691d57c9e0d57caf14655 | 11/18/2020 12:55:47  | 11/18/2020 12:55:47 |
### sitecore-xp0-cortexprocessingworker
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:8663bf2b35a831fb202d4a761b900e2a05681f94d98add310b9b17cb9c5e03df | 08/03/2020 14:33:13  | 10/22/2020 21:34:00 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:baa9306c9534c7f7d8d38ca75d6d44a5ee2185f337aa4acad00e708750704ebe | 10/22/2020 22:41:40  | 11/18/2020 12:59:33 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:66155c6e321720e33338d761dc96c7c8ae74940ed5b0606867552ea3663645ba | 11/18/2020 13:49:24  | 11/18/2020 13:49:24 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:09e4ed72f6ee884fe74bc3a664d46805dc7109b02476e4023f674c17e8ac7156 | 08/03/2020 15:14:36  | 11/18/2020 12:18:01 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:66155c6e321720e33338d761dc96c7c8ae74940ed5b0606867552ea3663645ba | 11/18/2020 13:49:12  | 11/18/2020 13:49:12 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:c7793e00ffffb4725b6fb6ac34bfab9cfebc417ef94213b7ee2ff5cc8e4a198f | 10/22/2020 22:41:31  | 10/22/2020 22:41:31 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:67650603f18842d86bec1e03914fe1cb2ce73ce8c745d9a86cb7fbba535e29cf | 08/03/2020 14:32:55  | 08/03/2020 14:32:55 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:157bfd31dddd9924982bdbb55172520486ae7af3e111e730995886c96c98ccd0 | 08/03/2020 20:22:22  | 08/03/2020 20:22:22 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:a589f6a8d1004d20fc370fb4410fabfdb48cb227dd0549d1d98d322d500e33a7 | 08/03/2020 15:14:27  | 08/03/2020 15:14:27 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:5fdf187b97c029eefb94c5bd6eea8c92f6513986dd29a655585d174c094ba47d | 08/03/2020 20:53:37  | 08/03/2020 20:53:37 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:4cc9c976b4f5425a21662fcb3c880a3d158b7d4477260263c03c7a67e2fcfc63 | 08/25/2020 11:15:49  | 08/25/2020 11:15:49 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:82646be5ec3e0358d64b4415e385162ab6a4b36375039d7a57d1b6299e0e8eb3 | 08/25/2020 11:41:10  | 08/25/2020 11:41:10 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:4ec139f138412e9244a8ff6f1ea51ff589af51559731233c0e4f6a82b708e3e0 | 09/15/2020 10:02:10  | 09/15/2020 10:02:10 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:fd7dd84363ecab6bd18f9acf760ded9fa13ab742400f7cf290795ae03776c41c | 09/15/2020 10:41:02  | 09/15/2020 10:41:02 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:8663bf2b35a831fb202d4a761b900e2a05681f94d98add310b9b17cb9c5e03df | 10/22/2020 21:33:48  | 10/22/2020 21:33:48 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:ba300bc5e20de99d6083d6661ffb6915bff75ced6cf6b965639c7b2ba26a43f4 | 10/22/2020 22:10:56  | 10/22/2020 22:10:56 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:09e4ed72f6ee884fe74bc3a664d46805dc7109b02476e4023f674c17e8ac7156 | 11/18/2020 12:17:49  | 11/18/2020 12:17:49 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:baa9306c9534c7f7d8d38ca75d6d44a5ee2185f337aa4acad00e708750704ebe | 11/18/2020 12:59:19  | 11/18/2020 12:59:19 |
### sitecore-xp0-mssql
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fa13c28f11d009f895674bd7b450b8504e94304bdd925c655152173232e855bd | 08/03/2020 14:29:01  | 10/22/2020 21:31:35 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:a5108f46ebdb0495ef33bd29151c99e7235e3e21f3aa525513e9a6e05e6dcd67 | 10/22/2020 22:39:13  | 11/18/2020 12:56:33 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:25d0059c25d5494764833a6300d16c1b84e4284ec4ef23acd7794e1fdd8f2af5 | 11/18/2020 13:46:33  | 11/18/2020 13:46:33 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:1fdd6f2a224a00b16c9321daa5980072bbf48ddeb6ce46b711fe480c826a8ba7 | 08/03/2020 15:12:04  | 11/18/2020 12:14:45 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:25d0059c25d5494764833a6300d16c1b84e4284ec4ef23acd7794e1fdd8f2af5 | 11/18/2020 13:46:22  | 11/18/2020 13:46:22 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:4212b16e6dda3455860046d00ea392c7e1e20155f00796b69077e47c5aabbcc4 | 10/22/2020 22:39:02  | 10/22/2020 22:39:02 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:ebe7c47b233760bde3807ca001d5070338199707fb0c474a55660f459b3740e2 | 08/03/2020 14:28:46  | 08/03/2020 14:28:46 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:87fe9697f11dfe3e1cf90e86ea9bf416abfe393b6879ff8bf8deddfd0df419bf | 08/03/2020 20:19:56  | 08/03/2020 20:19:56 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:ee33037091f303cae9c01d66f66789501f45d8cb8df8ed5c79a50b49d2936479 | 08/03/2020 15:11:54  | 08/03/2020 15:11:54 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:93ccdc1b32e0508e884cf869591ba7834b0cb16b72684ece185b21797ff3142d | 08/03/2020 20:50:57  | 08/03/2020 20:50:57 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:5a8f487899dd16a9d17328d501e4e022609200802a4c40841cbaec44c3546188 | 08/25/2020 11:13:15  | 08/25/2020 11:13:15 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:6906c2496fefafc509be70fc814c4d6ed12da9e99b63abd3be0bb79b9302a94d | 08/25/2020 11:38:59  | 08/25/2020 11:38:59 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:b880b0e6cd9c36d8e3cf7ef768e76d30ba5e0fbfe36dab54e039d98a61e4658c | 09/15/2020 09:59:50  | 09/15/2020 09:59:50 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:849a1bf63d780307e460d4612e719fdf563a1ca3a14e57c676fcc31df25b7286 | 09/15/2020 10:38:36  | 09/15/2020 10:38:36 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fa13c28f11d009f895674bd7b450b8504e94304bdd925c655152173232e855bd | 10/22/2020 21:31:24  | 10/22/2020 21:31:24 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:d38170bd083b83af80849aba6c9d7a7b38255e455b61fd0b579c87e15ab347e1 | 10/22/2020 22:08:36  | 10/22/2020 22:08:36 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:1fdd6f2a224a00b16c9321daa5980072bbf48ddeb6ce46b711fe480c826a8ba7 | 11/18/2020 12:14:33  | 11/18/2020 12:14:33 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:a5108f46ebdb0495ef33bd29151c99e7235e3e21f3aa525513e9a6e05e6dcd67 | 11/18/2020 12:56:20  | 11/18/2020 12:56:20 |
### sitecore-xp0-solr
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:f2f4c81654b2dbcbb7ecc0a12c7a67367c6734f3f955469c3fbd046477a2a667 | 08/03/2020 14:29:48  | 10/22/2020 21:32:03 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:deb39b0d1806836994fef366b9384eaf3dcb6a70cd7bff2d0042ecb06f891182 | 10/22/2020 22:39:39  | 11/18/2020 12:57:04 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:068f844ba84eab6324981f9d8cba930bf439fddc700489b815687aa9d7a65e41 | 11/18/2020 13:47:08  | 11/18/2020 13:47:08 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:c9d7f2cd3e796147c20e9d7b48e0213a2ec7ad52216338034cb7531cc18ea657 | 08/03/2020 15:12:34  | 11/18/2020 12:15:14 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:068f844ba84eab6324981f9d8cba930bf439fddc700489b815687aa9d7a65e41 | 11/18/2020 13:46:52  | 11/18/2020 13:46:52 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:09e30d22c99e22098abb26bfe24b1505408ce1fd070e82c5c53f048af3f1fae1 | 10/22/2020 22:39:29  | 10/22/2020 22:39:29 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:a820fd464559b9b78f747cd88bd4ced94fb76f01ceb214efe83b17c82881fb6a | 08/03/2020 14:29:31  | 08/03/2020 14:29:31 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:21e55797ac628bb749a060ba7ddfca2342a1b0e1ef4d8a4f3420ea6228e57f4a | 08/03/2020 20:20:25  | 08/03/2020 20:20:25 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:fa8f70e08724b9e8aaf71d67504a23835c42523c78ac08281bd0293a283fcff5 | 08/03/2020 15:12:22  | 08/03/2020 15:12:22 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:6fd1d0fe78b42ed84e2279b105404f2ec561730fca53c78347088f0a7d4a80e1 | 08/03/2020 20:51:28  | 08/03/2020 20:51:28 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:d021fecfa4a73db7485875ab8c5b96ab4234b18a78408c0e662c189cce066967 | 08/25/2020 11:13:41  | 08/25/2020 11:13:41 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:7f704e7bc389ba984fc7cc29b77b4be83e28bdf66f811226c743375735b40829 | 08/25/2020 11:39:23  | 08/25/2020 11:39:23 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:4a38ebad0ac2f793fe36b89c64c22046287ab42b12105cd13817f8b176f8141d | 09/15/2020 10:00:14  | 09/15/2020 10:00:14 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:52d9c54e01617b6c01c3a01dd16b0330c7148faa827d6c63e7fbb3407f9457f8 | 09/15/2020 10:39:11  | 09/15/2020 10:39:11 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:f2f4c81654b2dbcbb7ecc0a12c7a67367c6734f3f955469c3fbd046477a2a667 | 10/22/2020 21:31:52  | 10/22/2020 21:31:52 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:5edc9901310d9790a968d14e72ad3fcec08290c466ee05c36e7e733dbcddf665 | 10/22/2020 22:09:03  | 10/22/2020 22:09:03 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:c9d7f2cd3e796147c20e9d7b48e0213a2ec7ad52216338034cb7531cc18ea657 | 11/18/2020 12:15:03  | 11/18/2020 12:15:03 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:deb39b0d1806836994fef366b9384eaf3dcb6a70cd7bff2d0042ecb06f891182 | 11/18/2020 12:56:52  | 11/18/2020 12:56:52 |
### sitecore-xp0-xconnect
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:e98f8a688717c9e7f39ee24f8ccfcc7d0f9403d0c5a75a37cac5e37a5ac96493 | 08/03/2020 14:30:40  | 10/22/2020 21:32:35 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:7c8029d4834ca405f6e7949a742720937ce78b0385b74c9d8179568fcfc70c33 | 10/22/2020 22:40:22  | 11/18/2020 12:57:42 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:c0c2030de102cae8296246067a266f107df057fafbea95b44f37480108750cd2 | 11/18/2020 13:47:45  | 11/18/2020 13:47:45 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:5be274c5712d1e5293aa94490966d2e2828fd3aaf624aef547a7d0369baf0d2b | 08/03/2020 15:13:06  | 11/18/2020 12:16:19 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:c0c2030de102cae8296246067a266f107df057fafbea95b44f37480108750cd2 | 11/18/2020 13:47:32  | 11/18/2020 13:47:32 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:f3d3d94ec37631fa2ca18924daabed91f9429977d52b845fbf1656c33c394595 | 10/22/2020 22:39:58  | 10/22/2020 22:39:58 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:82ce165ed8b25e9cd703b4c621429f7cb783c78b8f6b258105bbbe82976000d7 | 08/03/2020 14:30:23  | 08/03/2020 14:30:23 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:7f9283c5041a7ae240a06f76d4734d35b6db6c5db9f4954af94384aa66e4a130 | 08/03/2020 20:21:01  | 08/03/2020 20:21:01 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:ec747aa66ad713dd8855d1f428e4799550d7909aa9d141c4ea1920a032f1ceeb | 08/03/2020 15:12:55  | 08/03/2020 15:12:55 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:501a3efecd0942a2bd82ab4974dd4333c38247ebbb63d58c5f4f54f446808932 | 08/03/2020 20:52:02  | 08/03/2020 20:52:02 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:5d144b60a1cb1684579041fca2c708c6616e2fab14d0be266a4994448fd65590 | 08/25/2020 11:14:12  | 08/25/2020 11:14:12 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:270328e19edbe625a83fde0a94654501b4af3e5c060f342e4dedde32ef5cd7ac | 08/25/2020 11:39:50  | 08/25/2020 11:39:50 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:d8e3e6ef412fb6ff9e8d49a9bcd0ae3fc2c1b1c82f292d41b6443247c581adc4 | 09/15/2020 10:00:43  | 09/15/2020 10:00:43 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:8cc836c3bc7fe563b5b3b33cdb9f8b5dc723b9aeb39f4c6e9016e90e24dfe8b2 | 09/15/2020 10:39:38  | 09/15/2020 10:39:38 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:e98f8a688717c9e7f39ee24f8ccfcc7d0f9403d0c5a75a37cac5e37a5ac96493 | 10/22/2020 21:32:24  | 10/22/2020 21:32:24 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:428b70a07c04526c9cb624107e207c23c53929d53850c38a45ac5f4812b5e98b | 10/22/2020 22:09:35  | 10/22/2020 22:09:35 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:5be274c5712d1e5293aa94490966d2e2828fd3aaf624aef547a7d0369baf0d2b | 11/18/2020 12:15:42  | 11/18/2020 12:15:42 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:7c8029d4834ca405f6e7949a742720937ce78b0385b74c9d8179568fcfc70c33 | 11/18/2020 12:57:29  | 11/18/2020 12:57:29 |
### sitecore-xp0-xdbautomationworker
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:a95cc55e05554fde0e52a48b70e35f9ec3c9753293d4478d29e1ffe27a9c2d71 | 08/03/2020 14:32:29  | 10/22/2020 21:33:32 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:8032690195fcc871cb8cfd6fbdd7694154eeb0df602f0a78f0c7d9b76e1ae5db | 10/22/2020 22:41:17  | 11/18/2020 12:58:55 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:159d8ffbbbb86c0b1d5e7cb8167213595d58b8181c6398a81df1a8cce1d589b7 | 11/18/2020 13:48:54  | 11/18/2020 13:48:54 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:36bcecee3613f7b1b316c854cfbae722bee3b7c267253ded1881b063ed8c4186 | 08/03/2020 15:14:11  | 11/18/2020 12:17:28 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:159d8ffbbbb86c0b1d5e7cb8167213595d58b8181c6398a81df1a8cce1d589b7 | 11/18/2020 13:48:41  | 11/18/2020 13:48:41 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:789e6480f47c3767bcb43ffcd9ef86e616e9d51f4a9aabda266016ff38c9edc2 | 10/22/2020 22:41:06  | 10/22/2020 22:41:06 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:82544eb89e0c1b8a968fb0cd035da0f9ec4b2ce1b934c33bd4e2078492256bf3 | 08/03/2020 14:32:13  | 08/03/2020 14:32:13 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:192c2ca2e3f2f9ea748eb07a68f396f644a68bfdaf8f11eb7835143c36ae2a5f | 08/03/2020 20:21:56  | 08/03/2020 20:21:56 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:40abbcc58ad4bb3a467a588d3acc1c3fe3848eb6e59048917f1512e6f725b06a | 08/03/2020 15:14:01  | 08/03/2020 15:14:01 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:432f317b36220c2821b4c5feeacc64cb64051379784551cdff853a9fa332d4b7 | 08/03/2020 20:53:08  | 08/03/2020 20:53:08 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:86250ce8c9aba8ff6dd12a0fd50231966016f237db1acec2e79d513400a9e1c6 | 08/25/2020 11:15:18  | 08/25/2020 11:15:18 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:4b3abc06cc09a55b8bdfdeabe4ff7f09249e5b6789748bc037e84625e7059dde | 08/25/2020 11:40:45  | 08/25/2020 11:40:45 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:9443bc31cb0bf4e1d6e916fe45ee0ec3d1e8234455acb9d249049ef53f49478b | 09/15/2020 10:01:29  | 09/15/2020 10:01:29 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:409de3e289bbfa76b79f151be23360067639f3808dc6cc373601b78816ebaeda | 09/15/2020 10:40:40  | 09/15/2020 10:40:40 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:a95cc55e05554fde0e52a48b70e35f9ec3c9753293d4478d29e1ffe27a9c2d71 | 10/22/2020 21:33:21  | 10/22/2020 21:33:21 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:d530effc8b97efadd7c699ae6d87d2c51232fab0b94ee99b9c48d919ef1436c5 | 10/22/2020 22:10:30  | 10/22/2020 22:10:30 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:36bcecee3613f7b1b316c854cfbae722bee3b7c267253ded1881b063ed8c4186 | 11/18/2020 12:17:14  | 11/18/2020 12:17:14 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:8032690195fcc871cb8cfd6fbdd7694154eeb0df602f0a78f0c7d9b76e1ae5db | 11/18/2020 12:58:44  | 11/18/2020 12:58:44 |
### sitecore-xp0-xdbsearchworker
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:869bd9ec7da8f4a614b73e37d4ac1e0299b637a04509da6a0ac1cd05890ecdf3 | 08/03/2020 14:31:35  | 10/22/2020 21:33:01 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:d0e9e4fcddab8522ad88aca5c9c9ca17125b6ae6bbe5d83624d3d0f5dfd4bd0a | 10/22/2020 22:40:46  | 11/18/2020 12:58:18 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:d6ae3ea4a62890bffb9b9f69adef129c450f523377fee8a1f3262b0c98c4c978 | 11/18/2020 13:48:18  | 11/18/2020 13:48:18 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:ecd91cabe9aa1179b92bdb82c7a6b50177b46c3e450a1610b8c087923f460bb1 | 08/03/2020 15:13:39  | 11/18/2020 12:16:49 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:d6ae3ea4a62890bffb9b9f69adef129c450f523377fee8a1f3262b0c98c4c978 | 11/18/2020 13:48:06  | 11/18/2020 13:48:06 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:1e47a2e82c222bef18dde782c71cca75ad7b2662f5ea8e3c7454be79e135a902 | 10/22/2020 22:40:36  | 10/22/2020 22:40:36 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:424fdbd1ec695bd79ac39fb0fb69fb712454c6119ce582b7bd905f78b265f736 | 08/03/2020 14:31:18  | 08/03/2020 14:31:18 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:a98f4bf0772d97efaa5b33b7dad179f8a39f59cb2db923cfcd51af87f6c3824a | 08/03/2020 20:21:28  | 08/03/2020 20:21:28 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:e75a1a619ad04dcd0a11d6c154e0a74878b517a8e4ae4c5be5fa588e9db87ed8 | 08/03/2020 15:13:25  | 08/03/2020 15:13:25 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:732a303b29f5edc44880b091e0801c2761e86fd3c4bdf40451a88866adee17e0 | 08/03/2020 20:52:31  | 08/03/2020 20:52:31 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:b893fbc8f6c536695a274504937a947afdc5387208577b0331af727ad0b9011c | 08/25/2020 11:14:39  | 08/25/2020 11:14:39 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:f877c6ea7805b653b49fb96d40559907a5fbfe715314b81f61fed102d8af4c9d | 08/25/2020 11:40:17  | 08/25/2020 11:40:17 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:b29fc5fd239d3d69063af7da15471a417cce1711d1708d622d1567943d64ad8b | 09/15/2020 10:01:04  | 09/15/2020 10:01:04 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:b0e6c2aeeeb843326da7a593a614bcfb9d600de965ed92efa0dd6792d6eb2100 | 09/15/2020 10:40:13  | 09/15/2020 10:40:13 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:869bd9ec7da8f4a614b73e37d4ac1e0299b637a04509da6a0ac1cd05890ecdf3 | 10/22/2020 21:32:51  | 10/22/2020 21:32:51 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:c1911b71a6aa3676cb74d3c69a87efc31f37a40448b3ac99cc360e3275de2bb0 | 10/22/2020 22:10:00  | 10/22/2020 22:10:00 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:ecd91cabe9aa1179b92bdb82c7a6b50177b46c3e450a1610b8c087923f460bb1 | 11/18/2020 12:16:37  | 11/18/2020 12:16:37 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:d0e9e4fcddab8522ad88aca5c9c9ca17125b6ae6bbe5d83624d3d0f5dfd4bd0a | 11/18/2020 12:58:01  | 11/18/2020 12:58:01 |
### sitecore-xp1-cd
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fbf9f6714bdd8f2557c9302e634371eb2c690a947705502495545c7c02ea0a4b | 08/03/2020 14:08:28  | 10/22/2020 21:17:59 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:1c60c6d5a962575066c3823db104ea787c1baa6cbcd104453e8b8c71ed3c16ec | 10/22/2020 22:25:20  | 11/18/2020 12:36:01 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:4718ba7bcbd3c782942402d57a7592cae9434d9a237197991b4b2d30e8ae82fe | 11/18/2020 13:26:51  | 11/18/2020 13:26:51 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:0e2e0227626b6632299586fd2c720dc33f7780a5e36bc55e9ef808122812f40c | 08/03/2020 14:57:05  | 11/18/2020 11:55:53 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:4718ba7bcbd3c782942402d57a7592cae9434d9a237197991b4b2d30e8ae82fe | 11/18/2020 13:26:39  | 11/18/2020 13:26:39 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:c88998ce3a10d176b12d41ec5c8b7463d07e53df3668ee1b50b039558c1112b9 | 10/22/2020 22:25:09  | 10/22/2020 22:25:09 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:50e46c97065e66511151027a0241f9a05dbbbb86780e80871b1f56fd5535f810 | 08/03/2020 14:08:13  | 08/03/2020 14:08:13 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:db015c7317d1e38a4a66284dde7b5e4af7300a0002b571a3e795c0d7acf9b9cd | 08/03/2020 20:07:12  | 08/03/2020 20:07:12 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:12bf255218dfebe76fbd4fceeb42c63448867e46e5294a3a9c0c0644730ba165 | 08/03/2020 14:56:54  | 08/03/2020 14:56:54 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:61d394bd517c3e7237eb22d0befaa30860dc96458aef0d3ead7baeb1bd4161d3 | 08/03/2020 20:36:55  | 08/03/2020 20:36:55 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:50076d4c95fa9ed50456a7e4c0c5309dcdae228ec866a5273e38a1de21674149 | 08/25/2020 10:56:32  | 08/25/2020 10:56:32 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:62e77bd9671891b01fc075c8232f9ec9561b4a068bfc7a844480c0d37037e266 | 08/25/2020 11:28:14  | 08/25/2020 11:28:14 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:f67ea9245c3c6f6c61a4275d2e36d7e65d5e7f0168c711a461784175755db8e8 | 09/15/2020 09:45:51  | 09/15/2020 09:45:51 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:7e0c1ce1fb222fe7306f48f49a09f4219fdb7876a016f2dd7ea134b6368c122d | 09/15/2020 10:25:45  | 09/15/2020 10:25:45 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fbf9f6714bdd8f2557c9302e634371eb2c690a947705502495545c7c02ea0a4b | 10/22/2020 21:17:47  | 10/22/2020 21:17:47 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:7bc6bb01c84868d79bd88ecce39e6b7efc2c8dbdb12363113fd43726f0dc528b | 10/22/2020 21:54:42  | 10/22/2020 21:54:42 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:0e2e0227626b6632299586fd2c720dc33f7780a5e36bc55e9ef808122812f40c | 11/18/2020 11:55:41  | 11/18/2020 11:55:41 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:1c60c6d5a962575066c3823db104ea787c1baa6cbcd104453e8b8c71ed3c16ec | 11/18/2020 12:35:48  | 11/18/2020 12:35:48 |
### sitecore-xp1-cm
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:93037dbecb4c43bfb5bf0e1acce9ae7f72b139191918d86c5dd012cc9ee59069 | 08/03/2020 14:10:01  | 10/22/2020 21:19:18 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:ac527bca751a9546aeb4998c7bb23fe920bf326d312808feef65558af4ab9b03 | 10/22/2020 22:26:49  | 11/18/2020 12:38:23 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:377657b2b70c80267aed4f10f547a7edee1dda7bad312e3de3ba81c9b29d8d23 | 11/18/2020 13:28:08  | 11/18/2020 13:28:08 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:1ae6dba743c279fddb662579be3aa6ef3196b5dcef1ebb9c280c9c34f732da2d | 08/03/2020 14:58:38  | 11/18/2020 11:57:25 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:377657b2b70c80267aed4f10f547a7edee1dda7bad312e3de3ba81c9b29d8d23 | 11/18/2020 13:27:56  | 11/18/2020 13:27:56 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:d7aff4f0fb1cf023e6c29a00d144daebf48130f754ab0381391b4e8bec0c64ea | 10/22/2020 22:26:38  | 10/22/2020 22:26:38 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:e55ff26f1718757a105bc6e87f1cb5aabfc87f0cfb1f1cb2ec6cfbd56a57350b | 08/03/2020 14:09:44  | 08/03/2020 14:09:44 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:03e9877e7d3f940600db475e3834235596055cb67b42a70a5c40c7420b7271b6 | 08/03/2020 20:08:30  | 08/03/2020 20:08:30 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:c77749a08d3a0d9d00b92bac2d6eb499e2c0a37367f13ec0a8ce0819d09d93af | 08/03/2020 14:58:26  | 08/03/2020 14:58:26 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:f375e63a8fe7dc6fe5634c287fb0e3e4347a1b91517273f13c2fecf989aa8cc0 | 08/03/2020 20:38:15  | 08/03/2020 20:38:15 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:0019139970ac342aff168e810df94e4a6915f07971b228edf655aa509be34ae3 | 08/25/2020 10:57:57  | 08/25/2020 10:57:57 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:35840680a6a73969bdfb9206a762a4e516c135f396f7a8fd029dd1dbddcae809 | 08/25/2020 11:29:05  | 08/25/2020 11:29:05 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:754f3f4bbf6f2a3698636163c4719c11ded85b278d36f049a6fffb74df790160 | 09/15/2020 09:47:13  | 09/15/2020 09:47:13 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:628b62666f88ecf27be24694a78b743f24e932f7050626dc7d36e956655c29e7 | 09/15/2020 10:27:08  | 09/15/2020 10:27:08 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:93037dbecb4c43bfb5bf0e1acce9ae7f72b139191918d86c5dd012cc9ee59069 | 10/22/2020 21:19:07  | 10/22/2020 21:19:07 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:7680dce87ccd90e4527e426fcbdaec4ca6b538bf3ed0cae5853e82fd45cf29b9 | 10/22/2020 21:55:51  | 10/22/2020 21:55:51 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:1ae6dba743c279fddb662579be3aa6ef3196b5dcef1ebb9c280c9c34f732da2d | 11/18/2020 11:57:12  | 11/18/2020 11:57:12 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:ac527bca751a9546aeb4998c7bb23fe920bf326d312808feef65558af4ab9b03 | 11/18/2020 12:38:05  | 11/18/2020 12:38:05 |
### sitecore-xp1-cortexprocessing
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:d49731075c43914b4f3b633467fe12731fefb425209a0006233fa02c7eac8e70 | 08/03/2020 14:18:44  | 10/22/2020 21:24:58 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:50cd27f577956fdc4ffad6ad527094ebfb310b9ec065db3a16034fc7407a3dd2 | 10/22/2020 22:32:57  | 11/18/2020 12:46:39 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:0f1cf417fb77deab04781c137c4deb6f12b6026ddd4a905bc0b15d2c12114949 | 11/18/2020 13:38:15  | 11/18/2020 13:38:15 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:302a79e363cd7f240ffae5f995ff92678538233b861343ee73a4e566e02e2484 | 08/03/2020 15:05:11  | 11/18/2020 12:04:20 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:0f1cf417fb77deab04781c137c4deb6f12b6026ddd4a905bc0b15d2c12114949 | 11/18/2020 13:38:03  | 11/18/2020 13:38:03 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:41fc64eda7e828ca09bdf7de5f323dc6e131519ca7fb9c8ed0f2983c470de7c7 | 10/22/2020 22:32:45  | 10/22/2020 22:32:45 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:53b55c11070c187b7291d31c5b0b26f800ca4eb8560c58baa6d20a8c95a71c31 | 08/03/2020 14:18:27  | 08/03/2020 14:18:27 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:6a7eb4778e707fa14c2658d9473507d38010eb832e289ac69c59e7219df86aaa | 08/03/2020 20:13:58  | 08/03/2020 20:13:58 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:fcfdaba9fc1a94e5118e08f9b884a7afebea867a704dd52ed5e041fec1a34233 | 08/03/2020 15:05:00  | 08/03/2020 15:05:00 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:dc83eeafc4635d8ebb165d5252417c368972cfaec498d77a0c5d4f412346d855 | 08/03/2020 20:43:43  | 08/03/2020 20:43:43 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:50d6a8d3765ad6a5835d32ab6adb670935d2282be5b3b8ef416a7264fb567742 | 08/25/2020 11:04:17  | 08/25/2020 11:04:17 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:95ad925d274337c805c811f7e2c9c4e0a0e31d3bda1e6291e7bcdc06b0809ae6 | 08/25/2020 11:33:47  | 08/25/2020 11:33:47 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:a79ce5ca9e07457890e081e111197bdfad5cc616b7f6c2d4a9bf3ca53c0ac8f6 | 09/15/2020 09:52:59  | 09/15/2020 09:52:59 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:34b4b935653b3d382e4e53503b5b63f075058987dea402a1f3c8a09bb81f5a83 | 09/15/2020 10:32:05  | 09/15/2020 10:32:05 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:d49731075c43914b4f3b633467fe12731fefb425209a0006233fa02c7eac8e70 | 10/22/2020 21:24:45  | 10/22/2020 21:24:45 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:ad9af5b2ef47133b03e1eb65b650fbde8313caeaa7f679ae23d48a21982f8502 | 10/22/2020 22:01:26  | 10/22/2020 22:01:26 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:302a79e363cd7f240ffae5f995ff92678538233b861343ee73a4e566e02e2484 | 11/18/2020 12:04:05  | 11/18/2020 12:04:05 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:50cd27f577956fdc4ffad6ad527094ebfb310b9ec065db3a16034fc7407a3dd2 | 11/18/2020 12:46:22  | 11/18/2020 12:46:22 |
### sitecore-xp1-cortexprocessingworker
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:8663bf2b35a831fb202d4a761b900e2a05681f94d98add310b9b17cb9c5e03df | 08/03/2020 14:19:33  | 10/22/2020 21:25:35 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:e61ce0f3f3b4d6d242315d03cb6bbb782cc3eacc70e0ed3574e860aa79e0bccb | 10/22/2020 22:33:25  | 11/18/2020 12:47:35 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:66155c6e321720e33338d761dc96c7c8ae74940ed5b0606867552ea3663645ba | 11/18/2020 13:38:53  | 11/18/2020 13:38:53 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:09e4ed72f6ee884fe74bc3a664d46805dc7109b02476e4023f674c17e8ac7156 | 08/03/2020 15:05:41  | 11/18/2020 12:04:56 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:66155c6e321720e33338d761dc96c7c8ae74940ed5b0606867552ea3663645ba | 11/18/2020 13:38:41  | 11/18/2020 13:38:41 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:c7793e00ffffb4725b6fb6ac34bfab9cfebc417ef94213b7ee2ff5cc8e4a198f | 10/22/2020 22:33:16  | 10/22/2020 22:33:16 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:67650603f18842d86bec1e03914fe1cb2ce73ce8c745d9a86cb7fbba535e29cf | 08/03/2020 14:19:16  | 08/03/2020 14:19:16 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:157bfd31dddd9924982bdbb55172520486ae7af3e111e730995886c96c98ccd0 | 08/03/2020 20:14:26  | 08/03/2020 20:14:26 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:a589f6a8d1004d20fc370fb4410fabfdb48cb227dd0549d1d98d322d500e33a7 | 08/03/2020 15:05:32  | 08/03/2020 15:05:32 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:5fdf187b97c029eefb94c5bd6eea8c92f6513986dd29a655585d174c094ba47d | 08/03/2020 20:44:11  | 08/03/2020 20:44:11 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:4cc9c976b4f5425a21662fcb3c880a3d158b7d4477260263c03c7a67e2fcfc63 | 08/25/2020 11:04:46  | 08/25/2020 11:04:46 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:82646be5ec3e0358d64b4415e385162ab6a4b36375039d7a57d1b6299e0e8eb3 | 08/25/2020 11:34:14  | 08/25/2020 11:34:14 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:4ec139f138412e9244a8ff6f1ea51ff589af51559731233c0e4f6a82b708e3e0 | 09/15/2020 09:53:28  | 09/15/2020 09:53:28 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:fd7dd84363ecab6bd18f9acf760ded9fa13ab742400f7cf290795ae03776c41c | 09/15/2020 10:32:30  | 09/15/2020 10:32:30 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:8663bf2b35a831fb202d4a761b900e2a05681f94d98add310b9b17cb9c5e03df | 10/22/2020 21:25:18  | 10/22/2020 21:25:18 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:ba300bc5e20de99d6083d6661ffb6915bff75ced6cf6b965639c7b2ba26a43f4 | 10/22/2020 22:01:59  | 10/22/2020 22:01:59 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:09e4ed72f6ee884fe74bc3a664d46805dc7109b02476e4023f674c17e8ac7156 | 11/18/2020 12:04:44  | 11/18/2020 12:04:44 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:e61ce0f3f3b4d6d242315d03cb6bbb782cc3eacc70e0ed3574e860aa79e0bccb | 11/18/2020 12:47:09  | 11/18/2020 12:47:09 |
### sitecore-xp1-cortexreporting
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:9cde156de4c4f8448cf0fc948d444bff66cdd0f61b146e2d03fd27a0bc18e7ab | 08/03/2020 14:20:26  | 10/22/2020 21:26:10 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:583a59b22a730dbab7f41b6e17e4f9181bff772196dcdaf77581c315cbd545ab | 10/22/2020 22:33:53  | 11/18/2020 12:48:55 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:5eaa11ffda1e6e407f9517b6d350a50835a84b7e2df19a941565a9592094119e | 11/18/2020 13:39:30  | 11/18/2020 13:39:30 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:7af15e3371404f647dbd99a2169a5c1f8914af04671ef61dcfde6d252b847782 | 08/03/2020 15:06:15  | 11/18/2020 12:05:32 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:5eaa11ffda1e6e407f9517b6d350a50835a84b7e2df19a941565a9592094119e | 11/18/2020 13:39:19  | 11/18/2020 13:39:19 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:abd43e11c078c94a9860713415b6243d6447e888fe93bfacb954f307878611b4 | 10/22/2020 22:33:43  | 10/22/2020 22:33:43 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:fa3fe8ee562280bb02c5e13215c54ae20058ba133c0a74b61edd0e882a516440 | 08/03/2020 14:20:09  | 08/03/2020 14:20:09 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:eef126df1551bfccf0d9791207e644719dde72e1340926f147cdb512be92ed36 | 08/03/2020 20:14:56  | 08/03/2020 20:14:56 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:471c1e8de55930b70f64e1020daf89fb2ae554fc2f96ef2f6b44d3ae10541633 | 08/03/2020 15:06:04  | 08/03/2020 15:06:04 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:f53d1306bf574b6e7a2f9fbfe16c84e47fe40f20a06cb13472813d562f478f50 | 08/03/2020 20:44:43  | 08/03/2020 20:44:43 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:6a1698dce4db4fc52f6c247208316badcea5a2d47976d5549c792fd693da62ab | 08/25/2020 11:05:27  | 08/25/2020 11:05:27 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:99270751dbf46a3bfdfede8842f974071667925e4d03bff5e52f1fd6ca3bae2b | 08/25/2020 11:34:42  | 08/25/2020 11:34:42 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:8b8220d42dd6945d8cd77a338f6ce97434caa9988099f7844731c1965cfdd9ff | 09/15/2020 09:53:55  | 09/15/2020 09:53:55 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:1ed4ec32b967f2768c439f23bf34aa9ddde30d86cb00ddd07a44473264f5655c | 09/15/2020 10:32:55  | 09/15/2020 10:32:55 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:9cde156de4c4f8448cf0fc948d444bff66cdd0f61b146e2d03fd27a0bc18e7ab | 10/22/2020 21:25:58  | 10/22/2020 21:25:58 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:04e878be0dbb1d665a4c7e9fbffe5acd2aedee1e6b324cff4f2de5c0522f2117 | 10/22/2020 22:02:33  | 10/22/2020 22:02:33 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:7af15e3371404f647dbd99a2169a5c1f8914af04671ef61dcfde6d252b847782 | 11/18/2020 12:05:20  | 11/18/2020 12:05:20 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:583a59b22a730dbab7f41b6e17e4f9181bff772196dcdaf77581c315cbd545ab | 11/18/2020 12:48:43  | 11/18/2020 12:48:43 |
### sitecore-xp1-mssql
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fa13c28f11d009f895674bd7b450b8504e94304bdd925c655152173232e855bd | 08/03/2020 14:23:54  | 10/22/2020 21:28:21 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:a5108f46ebdb0495ef33bd29151c99e7235e3e21f3aa525513e9a6e05e6dcd67 | 10/22/2020 22:35:56  | 11/18/2020 12:52:05 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:25d0059c25d5494764833a6300d16c1b84e4284ec4ef23acd7794e1fdd8f2af5 | 11/18/2020 13:42:13  | 11/18/2020 13:42:13 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:1fdd6f2a224a00b16c9321daa5980072bbf48ddeb6ce46b711fe480c826a8ba7 | 08/03/2020 15:08:45  | 11/18/2020 12:09:18 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:25d0059c25d5494764833a6300d16c1b84e4284ec4ef23acd7794e1fdd8f2af5 | 11/18/2020 13:41:59  | 11/18/2020 13:41:59 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:4212b16e6dda3455860046d00ea392c7e1e20155f00796b69077e47c5aabbcc4 | 10/22/2020 22:35:45  | 10/22/2020 22:35:45 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:ebe7c47b233760bde3807ca001d5070338199707fb0c474a55660f459b3740e2 | 08/03/2020 14:23:37  | 08/03/2020 14:23:37 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:87fe9697f11dfe3e1cf90e86ea9bf416abfe393b6879ff8bf8deddfd0df419bf | 08/03/2020 20:16:50  | 08/03/2020 20:16:50 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:ee33037091f303cae9c01d66f66789501f45d8cb8df8ed5c79a50b49d2936479 | 08/03/2020 15:08:32  | 08/03/2020 15:08:32 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:93ccdc1b32e0508e884cf869591ba7834b0cb16b72684ece185b21797ff3142d | 08/03/2020 20:46:51  | 08/03/2020 20:46:51 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:5a8f487899dd16a9d17328d501e4e022609200802a4c40841cbaec44c3546188 | 08/25/2020 11:08:38  | 08/25/2020 11:08:38 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:6906c2496fefafc509be70fc814c4d6ed12da9e99b63abd3be0bb79b9302a94d | 08/25/2020 11:36:10  | 08/25/2020 11:36:10 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:b880b0e6cd9c36d8e3cf7ef768e76d30ba5e0fbfe36dab54e039d98a61e4658c | 09/15/2020 09:56:36  | 09/15/2020 09:56:36 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:849a1bf63d780307e460d4612e719fdf563a1ca3a14e57c676fcc31df25b7286 | 09/15/2020 10:35:22  | 09/15/2020 10:35:22 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:fa13c28f11d009f895674bd7b450b8504e94304bdd925c655152173232e855bd | 10/22/2020 21:28:09  | 10/22/2020 21:28:09 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:d38170bd083b83af80849aba6c9d7a7b38255e455b61fd0b579c87e15ab347e1 | 10/22/2020 22:04:58  | 10/22/2020 22:04:58 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:1fdd6f2a224a00b16c9321daa5980072bbf48ddeb6ce46b711fe480c826a8ba7 | 11/18/2020 12:09:04  | 11/18/2020 12:09:04 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:a5108f46ebdb0495ef33bd29151c99e7235e3e21f3aa525513e9a6e05e6dcd67 | 11/18/2020 12:51:49  | 11/18/2020 12:51:49 |
### sitecore-xp1-mssql-init
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:e8c2ca99ff204b43960e589a443a8127929820867177dad834c0db8053ab31fb | 08/03/2020 14:24:53  | 10/22/2020 21:28:53 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:b6373e3d6d768138e10f9a5e17e976c4b6602351b0fbef29f5b432a71b8e8ad2 | 10/22/2020 22:36:31  | 11/18/2020 12:52:49 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:d325b338a6befa1c13857ef04f508d379f0a41470adb68f0bf9a4a7805b9d90a | 11/18/2020 13:42:54  | 11/18/2020 13:42:54 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:c27d32590567ad257dae401c329e155309c5522e20c48bb38e764415e51981e1 | 08/03/2020 15:09:19  | 11/18/2020 12:09:59 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:d325b338a6befa1c13857ef04f508d379f0a41470adb68f0bf9a4a7805b9d90a | 11/18/2020 13:42:41  | 11/18/2020 13:42:41 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:ee987d9afc7f923c85957f17b14ecea07fe5ba12b8085a68fd0652ccb50c7aeb | 10/22/2020 22:36:20  | 10/22/2020 22:36:20 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:497b22d66e79ddd02c429f583bbff30e5b41b30b223da412681d5814f517c457 | 08/03/2020 14:24:36  | 08/03/2020 14:24:36 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:dcf91132b4941f8787153f0285acf65ca2641673f7e9ceef74be3f34db72f20c | 08/03/2020 20:17:22  | 08/03/2020 20:17:22 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:be12e38a2d64e22a8f47cc175b6481a03e3d95ca24d0f04d95b64fcba4a950a6 | 08/03/2020 15:09:09  | 08/03/2020 15:09:09 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:5c2eda17cbae28db111f6a107a70c8d01f547063f4ebac69239eccad77f38225 | 08/03/2020 20:48:04  | 08/03/2020 20:48:04 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:9d8823b9f2c8f6128653916d55492054657da47fa0069bf17c988591009116cc | 08/25/2020 11:09:15  | 08/25/2020 11:09:15 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:b92909e0c49d6d4eff8a0d8a2167257917ba6b3aca311716f81fca64ae961efd | 08/25/2020 11:36:38  | 08/25/2020 11:36:38 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:3c5ed2ad06c8db0ea6902a01fecaf5db5098b310636e03301aebc97634c47313 | 09/15/2020 09:57:07  | 09/15/2020 09:57:07 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:8de3a1d728901a0ddab7a84c00522b51b1857279a86794d4e3b628a64cd90f72 | 09/15/2020 10:36:00  | 09/15/2020 10:36:00 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:e8c2ca99ff204b43960e589a443a8127929820867177dad834c0db8053ab31fb | 10/22/2020 21:28:42  | 10/22/2020 21:28:42 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:b59d0f673ae65a0401bfa89e5dabc0f0e2ed086d5ffefda35cee184d14accb65 | 10/22/2020 22:05:36  | 10/22/2020 22:05:36 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:c27d32590567ad257dae401c329e155309c5522e20c48bb38e764415e51981e1 | 11/18/2020 12:09:46  | 11/18/2020 12:09:46 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:b6373e3d6d768138e10f9a5e17e976c4b6602351b0fbef29f5b432a71b8e8ad2 | 11/18/2020 12:52:37  | 11/18/2020 12:52:37 |
### sitecore-xp1-prc
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:c96f7e3cee35513fdcf37046cdc2d3f967f1dabeead9b898efb30fbd58c2c78c | 08/03/2020 14:22:33  | 10/22/2020 21:27:24 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:fe5a8fba7115d683f8ab07c20a53f7e93c8a49a2476abc213759872f3adc75a0 | 10/22/2020 22:35:00  | 11/18/2020 12:50:43 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:e6a00e064b24f8115752e7a5beae014dcabd10bd58d5a03ed8d2501788205997 | 11/18/2020 13:41:02  | 11/18/2020 13:41:02 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:22c202eee3c18b479c1a7d1d5d796f7f59a95bec5cf06d128209f4e780f3a5c8 | 08/03/2020 15:07:47  | 11/18/2020 12:08:15 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:e6a00e064b24f8115752e7a5beae014dcabd10bd58d5a03ed8d2501788205997 | 11/18/2020 13:40:46  | 11/18/2020 13:40:46 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:f0f344da18c1d513ecce49e2deb73738ddf36db88b5be49ddbc459dbf981b15b | 10/22/2020 22:34:47  | 10/22/2020 22:34:47 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:6ee7c8ffda2a040781ad8b5c7b2ae116009b927f9eeb463c0619719808ad23f7 | 08/03/2020 14:22:14  | 08/03/2020 14:22:14 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:6eae39941b21ea137e33ff1a0a3eb442f77ec0c8736273514d7b831cca768a2f | 08/03/2020 20:16:00  | 08/03/2020 20:16:00 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:9dbedca03e2e79b66f9bc708a82c820609d215f11fbd82b956338ee6e00444cc | 08/03/2020 15:07:36  | 08/03/2020 15:07:36 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:f9311e63b661fa81b92303c9ecb443d2194ada26d3cc1430aa8d8d9cc51d5cce | 08/03/2020 20:45:58  | 08/03/2020 20:45:58 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:f82ccc0772ad02b85ff5bb5052da0b650902c2edb29cfb6899f553ef80f98f71 | 08/25/2020 11:07:38  | 08/25/2020 11:07:38 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:fe807dc1111b034057a6b470744ab1ad5d1524d318a75fc57c66e30937054643 | 08/25/2020 11:35:28  | 08/25/2020 11:35:28 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:629b91641bd07032895afda2c3bd3da9fa0402ba6e6a4db0e3426aeece96fbb8 | 09/15/2020 09:55:43  | 09/15/2020 09:55:43 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:58dd0424953c69d6403c33843641c7dd15a24ee4aea95fecf5e522c614c7708b | 09/15/2020 10:34:21  | 09/15/2020 10:34:21 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:c96f7e3cee35513fdcf37046cdc2d3f967f1dabeead9b898efb30fbd58c2c78c | 10/22/2020 21:27:13  | 10/22/2020 21:27:13 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:ca4f9da65b2a1f5e5385058a70aad96979840a088a448bff9578b0d8ad6a86c5 | 10/22/2020 22:04:01  | 10/22/2020 22:04:01 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:22c202eee3c18b479c1a7d1d5d796f7f59a95bec5cf06d128209f4e780f3a5c8 | 11/18/2020 12:07:59  | 11/18/2020 12:07:59 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:fe5a8fba7115d683f8ab07c20a53f7e93c8a49a2476abc213759872f3adc75a0 | 11/18/2020 12:50:19  | 11/18/2020 12:50:19 |
### sitecore-xp1-rep
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:8b7dd345c899c63091205567ed784f093e94049a535a2821715d3c8cdb220724 | 08/03/2020 14:11:50  | 10/22/2020 21:20:33 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:6785896fda0cd9a20457b12ef3e8de42d0009b64cd33b91393ca967bfa782345 | 10/22/2020 22:28:32  | 11/18/2020 12:40:39 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b5c09f9ff3e57ce6df218a74073806821385af4c294e5a1e60d01811b128deca | 11/18/2020 13:30:33  | 11/18/2020 13:30:33 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:3e968b881dbfc412af7de51d2a3223256db735a76e6bb6f09684962c0ef3132e | 08/03/2020 15:00:23  | 11/18/2020 11:58:48 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b5c09f9ff3e57ce6df218a74073806821385af4c294e5a1e60d01811b128deca | 11/18/2020 13:30:20  | 11/18/2020 13:30:20 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:9e26fd5beba7db680656f605934b5c0b6b9cf896bebf060b32c9af3799f0c13f | 10/22/2020 22:28:22  | 10/22/2020 22:28:22 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:b0eee1477aa15ad088ff6daa6de388768910c5f993af4d31c842e7cdf12288ea | 08/03/2020 14:11:32  | 08/03/2020 14:11:32 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:33d5ab70d95c0997e096933f332585db0ca66f62bee47e9d5758a20ac0c4e4c3 | 08/03/2020 20:09:57  | 08/03/2020 20:09:57 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:4b77305574d0458735bef649fec3c9f13aaf518ec8af26809aa964e7907b648b | 08/03/2020 15:00:11  | 08/03/2020 15:00:11 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:8b3af1885d124fa53c4e2d9f0f37ab72600012596f3380e4efe5309ade17a0c1 | 08/03/2020 20:39:28  | 08/03/2020 20:39:28 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:2f53d6e954d7ec5f927bde4d6326455becc486c3e050110d40a3bf7676d655b3 | 08/25/2020 10:59:35  | 08/25/2020 10:59:35 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:b40e4a96d58cd6fc8bd102b2a21f141c98e41aec868b6f79a5b0b9802df182f0 | 08/25/2020 11:29:57  | 08/25/2020 11:29:57 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:4a5becf6784372e9829ec0b9de08675837dccedf492f9a10706b0f6b644e27fc | 09/15/2020 09:49:15  | 09/15/2020 09:49:15 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:4d38d9d5238fa563a9b359d04e129f7467981587194a49789a862ee83eaf3522 | 09/15/2020 10:28:24  | 09/15/2020 10:28:24 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:8b7dd345c899c63091205567ed784f093e94049a535a2821715d3c8cdb220724 | 10/22/2020 21:20:22  | 10/22/2020 21:20:22 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:06496a5be48baa53fa83cf9b05f27de1e8dd6298c2a804f24fe80ab57f9f3f3f | 10/22/2020 21:57:00  | 10/22/2020 21:57:00 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:3e968b881dbfc412af7de51d2a3223256db735a76e6bb6f09684962c0ef3132e | 11/18/2020 11:58:34  | 11/18/2020 11:58:34 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:6785896fda0cd9a20457b12ef3e8de42d0009b64cd33b91393ca967bfa782345 | 11/18/2020 12:40:26  | 11/18/2020 12:40:26 |
### sitecore-xp1-solr
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:f2f4c81654b2dbcbb7ecc0a12c7a67367c6734f3f955469c3fbd046477a2a667 | 08/03/2020 14:25:42  | 10/22/2020 21:29:24 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:deb39b0d1806836994fef366b9384eaf3dcb6a70cd7bff2d0042ecb06f891182 | 10/22/2020 22:37:03  | 11/18/2020 12:53:30 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:068f844ba84eab6324981f9d8cba930bf439fddc700489b815687aa9d7a65e41 | 11/18/2020 13:43:31  | 11/18/2020 13:43:31 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:c9d7f2cd3e796147c20e9d7b48e0213a2ec7ad52216338034cb7531cc18ea657 | 08/03/2020 15:09:52  | 11/18/2020 12:10:44 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:068f844ba84eab6324981f9d8cba930bf439fddc700489b815687aa9d7a65e41 | 11/18/2020 13:43:18  | 11/18/2020 13:43:18 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:09e30d22c99e22098abb26bfe24b1505408ce1fd070e82c5c53f048af3f1fae1 | 10/22/2020 22:36:52  | 10/22/2020 22:36:52 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:a820fd464559b9b78f747cd88bd4ced94fb76f01ceb214efe83b17c82881fb6a | 08/03/2020 14:25:26  | 08/03/2020 14:25:26 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:21e55797ac628bb749a060ba7ddfca2342a1b0e1ef4d8a4f3420ea6228e57f4a | 08/03/2020 20:17:53  | 08/03/2020 20:17:53 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:fa8f70e08724b9e8aaf71d67504a23835c42523c78ac08281bd0293a283fcff5 | 08/03/2020 15:09:42  | 08/03/2020 15:09:42 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:6fd1d0fe78b42ed84e2279b105404f2ec561730fca53c78347088f0a7d4a80e1 | 08/03/2020 20:48:36  | 08/03/2020 20:48:36 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:d021fecfa4a73db7485875ab8c5b96ab4234b18a78408c0e662c189cce066967 | 08/25/2020 11:09:49  | 08/25/2020 11:09:49 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:7f704e7bc389ba984fc7cc29b77b4be83e28bdf66f811226c743375735b40829 | 08/25/2020 11:37:05  | 08/25/2020 11:37:05 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:4a38ebad0ac2f793fe36b89c64c22046287ab42b12105cd13817f8b176f8141d | 09/15/2020 09:57:37  | 09/15/2020 09:57:37 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:52d9c54e01617b6c01c3a01dd16b0330c7148faa827d6c63e7fbb3407f9457f8 | 09/15/2020 10:36:26  | 09/15/2020 10:36:26 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:f2f4c81654b2dbcbb7ecc0a12c7a67367c6734f3f955469c3fbd046477a2a667 | 10/22/2020 21:29:13  | 10/22/2020 21:29:13 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:5edc9901310d9790a968d14e72ad3fcec08290c466ee05c36e7e733dbcddf665 | 10/22/2020 22:06:09  | 10/22/2020 22:06:09 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:c9d7f2cd3e796147c20e9d7b48e0213a2ec7ad52216338034cb7531cc18ea657 | 11/18/2020 12:10:32  | 11/18/2020 12:10:32 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:deb39b0d1806836994fef366b9384eaf3dcb6a70cd7bff2d0042ecb06f891182 | 11/18/2020 12:53:17  | 11/18/2020 12:53:17 |
### sitecore-xp1-solr-init
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:3f9f40e5516c5affb3917814895526c813b247487b6d0f310d091157fc993f02 | 08/03/2020 14:26:31  | 10/22/2020 21:29:57 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:db10d102304cd9ae30e28457f010e7be1890773a24eb5dc86b9f96049f2de20f | 10/22/2020 22:37:34  | 11/18/2020 12:54:13 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:de7f05dca47cde99eb73eb8c4db33589d18ec79214db44623d306f65e8a4de0b | 11/18/2020 13:44:43  | 11/18/2020 13:44:43 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:679b6c3e878309598aa1c7619410f38bd6c73bb209d156fc0ad36441c5b7478d | 08/03/2020 15:10:25  | 11/18/2020 12:11:28 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:de7f05dca47cde99eb73eb8c4db33589d18ec79214db44623d306f65e8a4de0b | 11/18/2020 13:44:31  | 11/18/2020 13:44:31 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:b83ab098ca0c7d0404d6b184257f8983af3c411a8966256e93488cad2802c0c9 | 10/22/2020 22:37:24  | 10/22/2020 22:37:24 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:50e4ed40149ce735d2697a6c40747f61e0bd3725f194e359ac31a10cd8300cad | 08/03/2020 14:26:16  | 08/03/2020 14:26:16 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:da04d6778dde0a5a987b84ebbfb80b33701579b58fa85d91d470d26f841dcef1 | 08/03/2020 20:18:24  | 08/03/2020 20:18:24 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:5582707471d2fd4c2410768c3e34729269abfe1b544c2c99e091616343f1905c | 08/03/2020 15:10:14  | 08/03/2020 15:10:14 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:9edad072abe0a2c4e9caf0f6c26f2033c01d8472bad256a704d1b4759c8175f2 | 08/03/2020 20:49:06  | 08/03/2020 20:49:06 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:979a1ce9de53e0be0fe1915039d7f749a3facc4963e0b9c2ac847192e29feb2c | 08/25/2020 11:10:22  | 08/25/2020 11:10:22 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:6c9217761ee3d71232bedf34b17a8556ff391652fce4e020a26f75e2d98224aa | 08/25/2020 11:37:40  | 08/25/2020 11:37:40 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:c35049d0a9a6c262722c493f690241f07009081eca796ddfc7db31af078e4301 | 09/15/2020 09:58:02  | 09/15/2020 09:58:02 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:b233c294c67b2ae894151fa1c44fa9f4538fe3c4abdf1eb3fb1bc50219c22ce4 | 09/15/2020 10:36:54  | 09/15/2020 10:36:54 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:3f9f40e5516c5affb3917814895526c813b247487b6d0f310d091157fc993f02 | 10/22/2020 21:29:45  | 10/22/2020 21:29:45 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:967c9128ec3a285ccf6e6ab1d8e698d4764a28c5849f95d9d3b22b31d7692c44 | 10/22/2020 22:06:43  | 10/22/2020 22:06:43 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:679b6c3e878309598aa1c7619410f38bd6c73bb209d156fc0ad36441c5b7478d | 11/18/2020 12:11:16  | 11/18/2020 12:11:16 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:db10d102304cd9ae30e28457f010e7be1890773a24eb5dc86b9f96049f2de20f | 11/18/2020 12:54:00  | 11/18/2020 12:54:00 |
### sitecore-xp1-xdbautomation
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:10b4541648e996041c6fb4e7bf75e94d9ecc2f051bbc3156591b700d7ba97246 | 08/03/2020 14:12:58  | 10/22/2020 21:21:08 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:a230645980b18a9ab6694b97d50ef1c2ba8e089c4e2f73caf9369a9f2720617f | 10/22/2020 22:29:07  | 11/18/2020 12:41:31 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:cda7193515410df583a77ff93bf4bb249b02947b159fe87183c8269b93b78344 | 11/18/2020 13:31:09  | 11/18/2020 13:31:09 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:2b316412a85188ee94e16b4616930318044ee8a69280efde692d0adaec25c686 | 08/03/2020 15:01:01  | 11/18/2020 11:59:34 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:cda7193515410df583a77ff93bf4bb249b02947b159fe87183c8269b93b78344 | 11/18/2020 13:30:56  | 11/18/2020 13:30:56 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:5c50911620b694c88a6a6ad9db2699cc426483c491fa029b02b1f7d3417fc5b1 | 10/22/2020 22:28:55  | 10/22/2020 22:28:55 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:4c4779cd6e073df8aa127c47412bbbb96bee99959aee57eec651112eb6516b7c | 08/03/2020 14:12:35  | 08/03/2020 14:12:35 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:7d5b89bce1c99aecf8b06d53931085e1a9b83e0e3af9a2ddd6773ba7b225ca0e | 08/03/2020 20:10:30  | 08/03/2020 20:10:30 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:d954b5c409a80edfb9ffe94aa3cedab3ba33dbdac2eee6c413ada71dacb9e3f8 | 08/03/2020 15:00:49  | 08/03/2020 15:00:49 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:dd8b7a24a4e0ba10612d7af5fe1e8c576e97d1bc1ea56eae98666a8bd8880fd8 | 08/03/2020 20:40:03  | 08/03/2020 20:40:03 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:8173a539ce24e5468245a254dbfa86fa502c8d5da6fa60c75cf0dd9fe45043fa | 08/25/2020 11:00:14  | 08/25/2020 11:00:14 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:80baa60b8dcaeb77738a104ec3bff82d64e36935531bc5d960606a3e4914a899 | 08/25/2020 11:30:25  | 08/25/2020 11:30:25 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:f64b9315d9427a196e42d4599996e3756a0cd3e897fc9374db581ff96f17211c | 09/15/2020 09:49:42  | 09/15/2020 09:49:42 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:1991916fe58d92f8929958d0804f248ec65737df3203b4ba07c47ed6a677f9d5 | 09/15/2020 10:28:52  | 09/15/2020 10:28:52 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:10b4541648e996041c6fb4e7bf75e94d9ecc2f051bbc3156591b700d7ba97246 | 10/22/2020 21:20:56  | 10/22/2020 21:20:56 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:b0f1ea934afc334c68602fea9a2921db38bb2aff0881bf8419b7017fee359025 | 10/22/2020 21:57:32  | 10/22/2020 21:57:32 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:2b316412a85188ee94e16b4616930318044ee8a69280efde692d0adaec25c686 | 11/18/2020 11:59:21  | 11/18/2020 11:59:21 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:a230645980b18a9ab6694b97d50ef1c2ba8e089c4e2f73caf9369a9f2720617f | 11/18/2020 12:41:18  | 11/18/2020 12:41:18 |
### sitecore-xp1-xdbautomationrpt
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:8a76061612e7636bca904bcfd22968302496176e3f4298963f04e52b3affce0a | 08/03/2020 14:13:50  | 10/22/2020 21:21:39 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:9559c68aa80c4db9a40fd9ec39098eab6700413a28671ce2d6a4bc8dcc9866dc | 10/22/2020 22:29:39  | 11/18/2020 12:42:13 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b42405f113773edc6c7e6d5bf2f522df46f62f8e965b43e56dea7c6bffa85dd0 | 11/18/2020 13:31:45  | 11/18/2020 13:31:45 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:c4cba8f5b93e86c577f420e8befe84f2926296290d7fede35b4a3da0822b4a5c | 08/03/2020 15:01:36  | 11/18/2020 12:00:14 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b42405f113773edc6c7e6d5bf2f522df46f62f8e965b43e56dea7c6bffa85dd0 | 11/18/2020 13:31:32  | 11/18/2020 13:31:32 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:5bb8aef7e04862f81a0ff75a34553fe4f9bf4c63a86148072490d39f6635cfae | 10/22/2020 22:29:28  | 10/22/2020 22:29:28 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:9f022ceb66eaa182b6746b25ec514c2e6bb3258d8896eeea1e39d3844f569fcf | 08/03/2020 14:13:34  | 08/03/2020 14:13:34 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:510df42f21813da20bc0cf10b744bd707e59927692ff9253d9c19a5d6d1c6631 | 08/03/2020 20:11:00  | 08/03/2020 20:11:00 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:1faa60fed48f693b9300436feddf50d263ba173f4d02169b60d88022f2dbe0cb | 08/03/2020 15:01:25  | 08/03/2020 15:01:25 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:f24b76aab61fb7b96e91c6a924733a6fba732e80dbc901193ad167995afaacfe | 08/03/2020 20:40:35  | 08/03/2020 20:40:35 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:4772b8c99e1e73a374ac6a0ce8df8d9c9f84f8027a7f404f2cac705f244e33e1 | 08/25/2020 11:00:48  | 08/25/2020 11:00:48 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:9b96450695cdefbfe79f9cab31f2be2594864db3f61a89ba2b3183e889262d08 | 08/25/2020 11:30:53  | 08/25/2020 11:30:53 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:3f05d5f4386e4bc0e8a6091afdd26d379d7a685e91f2f589f98ff38e45d8c68c | 09/15/2020 09:50:09  | 09/15/2020 09:50:09 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:1b73fd82a69bff6760e709b76f81e0a6451d126967dc69b0fef7be2ca5b1dd65 | 09/15/2020 10:29:20  | 09/15/2020 10:29:20 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:8a76061612e7636bca904bcfd22968302496176e3f4298963f04e52b3affce0a | 10/22/2020 21:21:28  | 10/22/2020 21:21:28 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:c050a3de0c496b57c3dc80b97962c9689956c62dec5a608f19ac3638a704cb2f | 10/22/2020 21:58:06  | 10/22/2020 21:58:06 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:c4cba8f5b93e86c577f420e8befe84f2926296290d7fede35b4a3da0822b4a5c | 11/18/2020 11:59:59  | 11/18/2020 11:59:59 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:9559c68aa80c4db9a40fd9ec39098eab6700413a28671ce2d6a4bc8dcc9866dc | 11/18/2020 12:41:59  | 11/18/2020 12:41:59 |
### sitecore-xp1-xdbautomationworker
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:91dcde534d22f20432b2d83e276f53956bd379fe4bc27496c96a37b4a6fe5ab7 | 08/03/2020 14:14:38  | 10/22/2020 21:22:13 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:33be6e83fa079f206d3d23aaed5a86af0cc48dc2de20ae471a3f9b178f65a5ac | 10/22/2020 22:30:15  | 11/18/2020 12:42:58 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:85cf02f8b99e695540b25ccb0f9e1519fcfd8fecfd8ac2a07142c9dcac09c29a | 11/18/2020 13:32:21  | 11/18/2020 13:32:21 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:dcccaeae312661df0c96671b9901e875401dae9c00bcb570bdd9b59606770e7f | 08/03/2020 15:02:14  | 11/18/2020 12:00:51 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:85cf02f8b99e695540b25ccb0f9e1519fcfd8fecfd8ac2a07142c9dcac09c29a | 11/18/2020 13:32:07  | 11/18/2020 13:32:07 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:184b1e808ad3d069aec3c99e47e3009d27115c98993d1927a6da3065f281803b | 10/22/2020 22:30:01  | 10/22/2020 22:30:01 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:b36427d93761b6ac3a62e94fac6c580700adf66ddd16e24289e0bbec5871f073 | 08/03/2020 14:14:21  | 08/03/2020 14:14:21 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:015aa22dc1ded6f25c699628c956b137f113a2e3c1e6654d054580d5fa3a082b | 08/03/2020 20:11:29  | 08/03/2020 20:11:29 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:48d723b5cc39985daa3761e1b5cbecf2cc8801d93492291e3fb7eff7a654a555 | 08/03/2020 15:02:04  | 08/03/2020 15:02:04 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:fa68a18c3398d702c3d7498ffb5293e791f25ab1f04962e256f9ef48c9b6b861 | 08/03/2020 20:41:05  | 08/03/2020 20:41:05 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:e65e9983a1bf81509efe19669797beb4ac401098a83ef8e02739f86076ca289a | 08/25/2020 11:01:38  | 08/25/2020 11:01:38 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:fd7649d42262d5c64c01a60a7adc8ef60b2a739b97564d3654b9ec1061d71f2c | 08/25/2020 11:31:19  | 08/25/2020 11:31:19 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:1d9ded1ea0efeb4d865cfbbf57759c327b6b1accc5d5e2e8b89374289f0220f5 | 09/15/2020 09:50:35  | 09/15/2020 09:50:35 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:01e538c993b1efb1249e5d720a2ba3bdbaa860e2ff56412782224a5f41850e15 | 09/15/2020 10:29:46  | 09/15/2020 10:29:46 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:91dcde534d22f20432b2d83e276f53956bd379fe4bc27496c96a37b4a6fe5ab7 | 10/22/2020 21:22:01  | 10/22/2020 21:22:01 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:918ec0ad8fb5bd1a60bb35e8a1f7659a23684c67beca4758e98f9fc953befc26 | 10/22/2020 21:58:36  | 10/22/2020 21:58:36 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:dcccaeae312661df0c96671b9901e875401dae9c00bcb570bdd9b59606770e7f | 11/18/2020 12:00:39  | 11/18/2020 12:00:39 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:33be6e83fa079f206d3d23aaed5a86af0cc48dc2de20ae471a3f9b178f65a5ac | 11/18/2020 12:42:44  | 11/18/2020 12:42:44 |
### sitecore-xp1-xdbcollection
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:be504f5142ed958768427b89a89732c227e5bab335d19e293c92231154282ca4 | 08/03/2020 14:15:28  | 10/22/2020 21:22:46 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:73179bafb8d5f4cfd263cb4a7720ab2db43ffcd06ae53a33485c19ad59d334d3 | 10/22/2020 22:30:47  | 11/18/2020 12:43:40 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:2e56c2baa646bbed47febddcd16ba47394686c18d0a0a9c5477c47a1cc424f80 | 11/18/2020 13:33:01  | 11/18/2020 13:33:01 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:a63950f62fece38a4f0da0e2226b9952c3f186e58c80c1d24964f25543f48440 | 08/03/2020 15:02:57  | 11/18/2020 12:01:33 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:2e56c2baa646bbed47febddcd16ba47394686c18d0a0a9c5477c47a1cc424f80 | 11/18/2020 13:32:48  | 11/18/2020 13:32:48 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:f4f88e634d8e2a28e832cdd68d19cbf943ba9839692c778cdf31303f49719622 | 10/22/2020 22:30:36  | 10/22/2020 22:30:36 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:c882e4f9df94e064535742b30fefd438d2df15fee365b776d631b84d5ca94650 | 08/03/2020 14:15:12  | 08/03/2020 14:15:12 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:eb888d149c7ba8f9e424800b864539683df98efd9de2ed136133127adce7e3b9 | 08/03/2020 20:12:01  | 08/03/2020 20:12:01 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:8aa8cc2f63e80ef8954801b047e99dd4d9677af805f56206c4d5778df8abbcb3 | 08/03/2020 15:02:46  | 08/03/2020 15:02:46 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:dec835a867413e8f5468f5327843daf249e29b6a2fec1bea413614715b0b058d | 08/03/2020 20:41:38  | 08/03/2020 20:41:38 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:dea2f8f6df66dbc14f84a63aef6d15a423ffa0b33bf1ca9a566b5c8924d3449b | 08/25/2020 11:02:12  | 08/25/2020 11:02:12 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:6ba16d260f7e33d8913a9af637f23f5708d101c4c59143ccb9b4a0a23ab56f93 | 08/25/2020 11:31:48  | 08/25/2020 11:31:48 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:e38d2c570631d675e6b05d5e34ed2ab02c96bf2e061c7d02577b0fce1559b58e | 09/15/2020 09:51:06  | 09/15/2020 09:51:06 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:52c49ff633be1171a7c98ed9988d3a0381eb9c622245be697a67245191d7c95b | 09/15/2020 10:30:13  | 09/15/2020 10:30:13 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:be504f5142ed958768427b89a89732c227e5bab335d19e293c92231154282ca4 | 10/22/2020 21:22:35  | 10/22/2020 21:22:35 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:88ec8b03dc15fee41ee45c000889a15ed5e16efeefb8492b03b05cfc261f2c43 | 10/22/2020 21:59:17  | 10/22/2020 21:59:17 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:a63950f62fece38a4f0da0e2226b9952c3f186e58c80c1d24964f25543f48440 | 11/18/2020 12:01:21  | 11/18/2020 12:01:21 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:73179bafb8d5f4cfd263cb4a7720ab2db43ffcd06ae53a33485c19ad59d334d3 | 11/18/2020 12:43:29  | 11/18/2020 12:43:29 |
### sitecore-xp1-xdbrefdata
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:de53d65f085cd1d7569549a9e17fa17adf8a29bcce8ffd1bedabca968fc41892 | 08/03/2020 14:16:19  | 10/22/2020 21:23:17 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:1b7a3414413f2deae3c30d7bd885786a7b4b5265d21d5bd23e92690a38b4caeb | 10/22/2020 22:31:21  | 11/18/2020 12:44:31 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:af23a1eacaa08a04f3e22ab58f1147dc4803d9dc91ba802f11b88a7efbea09cf | 11/18/2020 13:33:56  | 11/18/2020 13:33:56 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:4e352f8a8fede7affdcf7feb5d5536dbfcd0fb4a90423513b193d00213150f4b | 08/03/2020 15:03:30  | 11/18/2020 12:02:10 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:af23a1eacaa08a04f3e22ab58f1147dc4803d9dc91ba802f11b88a7efbea09cf | 11/18/2020 13:33:42  | 11/18/2020 13:33:42 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:c0c21bd3a6e864f8ec906b3c27cb25998f00ce9da108316ca5f8d43066d62a8c | 10/22/2020 22:31:10  | 10/22/2020 22:31:10 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:045432fb94fea97b7d571440757be921fadbdff73022e0a141516f241b10f582 | 08/03/2020 14:16:02  | 08/03/2020 14:16:02 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:1d3495433f69a39e40f0b3253976fc608b3a5705ae7a8df20e8d8c856c77bb11 | 08/03/2020 20:12:31  | 08/03/2020 20:12:31 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:dbb89925137567407272625b0c83fbf5ebb8023c9cfe296e162343b021871235 | 08/03/2020 15:03:20  | 08/03/2020 15:03:20 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:da024c2aa14fb7820ef232194ee7f8722d6ff239608bb5265fadccb2c218b676 | 08/03/2020 20:42:09  | 08/03/2020 20:42:09 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:0cc379d5cf6b975ef673792a8efd010f5c459f7befa96096d5607b5f82b1d79a | 08/25/2020 11:02:44  | 08/25/2020 11:02:44 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:8ccfbbd72e6259e4a123a8de78a91464404a01b58636c0e549c296765258b79b | 08/25/2020 11:32:20  | 08/25/2020 11:32:20 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:8cec5fbd2c18654769da341a68114db07422c6e47608b01e1b802395a3e219b1 | 09/15/2020 09:51:33  | 09/15/2020 09:51:33 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:53076ccdf4bf6fd244648372a499ab14515da557572bc1a9e989f8f1ad644ee2 | 09/15/2020 10:30:41  | 09/15/2020 10:30:41 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:de53d65f085cd1d7569549a9e17fa17adf8a29bcce8ffd1bedabca968fc41892 | 10/22/2020 21:23:05  | 10/22/2020 21:23:05 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:532f2f43a3437a1c9aa6b14613d2995f6f1bf4dd6198e960a1c66c7a9bac6fd6 | 10/22/2020 21:59:50  | 10/22/2020 21:59:50 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:4e352f8a8fede7affdcf7feb5d5536dbfcd0fb4a90423513b193d00213150f4b | 11/18/2020 12:01:58  | 11/18/2020 12:01:58 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:1b7a3414413f2deae3c30d7bd885786a7b4b5265d21d5bd23e92690a38b4caeb | 11/18/2020 12:44:16  | 11/18/2020 12:44:16 |
### sitecore-xp1-xdbsearch
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:5f2cece8e977d2b90c1deaad7389fd188369134334ab6b3137a4c0d1d660e06d | 08/03/2020 14:17:07  | 10/22/2020 21:23:55 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:e20cd61e3607eeda0b8ab61e7d3eabe0a36c538c0bf01dad4b7df2ab8960f68f | 10/22/2020 22:31:53  | 11/18/2020 12:45:10 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:2c5f6de3c219cd216b2cda52d146234aa4380e408658294842a7cc7e4545effb | 11/18/2020 13:34:42  | 11/18/2020 13:34:42 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:31b9defe8a40dde8de7ed614a40308f43e6d475db2c33dc79b15bea5ebe2d7de | 08/03/2020 15:04:04  | 11/18/2020 12:03:01 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:2c5f6de3c219cd216b2cda52d146234aa4380e408658294842a7cc7e4545effb | 11/18/2020 13:34:30  | 11/18/2020 13:34:30 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:f1fe7488a60d93234b35fab1a3ba0376fbef71f22b26e4f6f6f2ba40ea0bb443 | 10/22/2020 22:31:41  | 10/22/2020 22:31:41 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:3d91c5cd05da067ae32829e97c7183096fa6cb7cf786f1a32cb92e9c1f7c647d | 08/03/2020 14:16:52  | 08/03/2020 14:16:52 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:c75d1e1ce6c50010a790032f764e6359a0ab51f11cee7e478a867567f3480992 | 08/03/2020 20:13:00  | 08/03/2020 20:13:00 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:3a12437638897c6129ed81dc2a08f1d5ea2a3a375bc13113d5dfb0814efd3324 | 08/03/2020 15:03:54  | 08/03/2020 15:03:54 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:b9648f004773138d2835cd4bfbdf23086515ec55d7cf93091b83bb30eb3e2f83 | 08/03/2020 20:42:41  | 08/03/2020 20:42:41 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:13d3974948d1161c594f83318a0677a59ca00e4563b7457afdd4c2139d57fab9 | 08/25/2020 11:03:15  | 08/25/2020 11:03:15 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:7246dee32711020136d552e3b3b3f25e3dba7ed8a86f227cf77f71285cabf5c4 | 08/25/2020 11:32:49  | 08/25/2020 11:32:49 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:0051d46085401d9377cb5e15f18e91cc128d7f09956141910e9a5c30f9dcb98a | 09/15/2020 09:51:58  | 09/15/2020 09:51:58 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:34a2573932b6f1b94171387b74b042ac97bca9f4dd1d775dd2c75f44ddd75e0b | 09/15/2020 10:31:14  | 09/15/2020 10:31:14 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:5f2cece8e977d2b90c1deaad7389fd188369134334ab6b3137a4c0d1d660e06d | 10/22/2020 21:23:38  | 10/22/2020 21:23:38 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:89856ac94c6dbd4374bb8e77ed616ba636951def58c2153bb4d0413a22f90ac4 | 10/22/2020 22:00:21  | 10/22/2020 22:00:21 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:31b9defe8a40dde8de7ed614a40308f43e6d475db2c33dc79b15bea5ebe2d7de | 11/18/2020 12:02:47  | 11/18/2020 12:02:47 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:e20cd61e3607eeda0b8ab61e7d3eabe0a36c538c0bf01dad4b7df2ab8960f68f | 11/18/2020 12:44:57  | 11/18/2020 12:44:57 |
### sitecore-xp1-xdbsearchworker
Tag                                        | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------------ | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1909                                | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:869bd9ec7da8f4a614b73e37d4ac1e0299b637a04509da6a0ac1cd05890ecdf3 | 08/03/2020 14:17:52  | 10/22/2020 21:24:25 |
10.0.0-2004                                | 10.0.19041.630  | 2004        | amd64           | windows | sha256:d0e9e4fcddab8522ad88aca5c9c9ca17125b6ae6bbe5d83624d3d0f5dfd4bd0a | 10/22/2020 22:32:26  | 11/18/2020 12:45:53 |
10.0.0-2009                                | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b2edd6f97932a4845ab925c49791598c957f03f861731c10b1603881d61ea839 | 11/18/2020 13:37:39  | 11/18/2020 13:37:39 |
10.0.0-ltsc2019                            | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:ecd91cabe9aa1179b92bdb82c7a6b50177b46c3e450a1610b8c087923f460bb1 | 08/03/2020 15:04:37  | 11/18/2020 12:03:39 |
10.0.0.004346.16-10.0.19042.630-2009       | 10.0.19042.630  | 2009        | amd64           | windows | sha256:b2edd6f97932a4845ab925c49791598c957f03f861731c10b1603881d61ea839 | 11/18/2020 13:37:23  | 11/18/2020 13:37:23 |
10.0.0.004346.26-10.0.19041.572-2004       | 10.0.19041.572  | 2004        | amd64           | windows | sha256:1e47a2e82c222bef18dde782c71cca75ad7b2662f5ea8e3c7454be79e135a902 | 10/22/2020 22:32:11  | 10/22/2020 22:32:11 |
10.0.0.004346.301-10.0.18363.900-1909      | 10.0.18363.900  | 1909        | amd64           | windows | sha256:4dda2d8d08a7b68a4f59228491715977ae783c7da376866408da91605a3a4e82 | 08/03/2020 14:17:37  | 08/03/2020 14:17:37 |
10.0.0.004346.316-10.0.18363.959-1909      | 10.0.18363.959  | 1909        | amd64           | windows | sha256:a98f4bf0772d97efaa5b33b7dad179f8a39f59cb2db923cfcd51af87f6c3824a | 08/03/2020 20:13:28  | 08/03/2020 20:13:28 |
10.0.0.004346.318-10.0.17763.1282-ltsc2019 | 10.0.17763.1282 | ltsc2019    | amd64           | windows | sha256:97f0a93c15d1ee1795c0c42d109f4900584910642f41faece9ecc0bb848b2514 | 08/03/2020 15:04:25  | 08/03/2020 15:04:25 |
10.0.0.004346.337-10.0.17763.1339-ltsc2019 | 10.0.17763.1339 | ltsc2019    | amd64           | windows | sha256:732a303b29f5edc44880b091e0801c2761e86fd3c4bdf40451a88866adee17e0 | 08/03/2020 20:43:11  | 08/03/2020 20:43:11 |
10.0.0.004346.356-10.0.18363.1016-1909     | 10.0.18363.1016 | 1909        | amd64           | windows | sha256:b893fbc8f6c536695a274504937a947afdc5387208577b0331af727ad0b9011c | 08/25/2020 11:03:45  | 08/25/2020 11:03:45 |
10.0.0.004346.371-10.0.17763.1397-ltsc2019 | 10.0.17763.1397 | ltsc2019    | amd64           | windows | sha256:4914ed1edb738a66189ba15f5fedc75044a4a25007b1667f5c219fa7c5cc1c1a | 08/25/2020 11:33:21  | 08/25/2020 11:33:21 |
10.0.0.004346.401-10.0.18363.1082-1909     | 10.0.18363.1082 | 1909        | amd64           | windows | sha256:b29fc5fd239d3d69063af7da15471a417cce1711d1708d622d1567943d64ad8b | 09/15/2020 09:52:23  | 09/15/2020 09:52:23 |
10.0.0.004346.412-10.0.17763.1457-ltsc2019 | 10.0.17763.1457 | ltsc2019    | amd64           | windows | sha256:c3bea621a7ea317910bda32256f5d4741482a040bafc053433b4d80a2802a8b6 | 09/15/2020 10:31:40  | 09/15/2020 10:31:40 |
10.0.0.004346.433-10.0.18363.1139-1909     | 10.0.18363.1139 | 1909        | amd64           | windows | sha256:869bd9ec7da8f4a614b73e37d4ac1e0299b637a04509da6a0ac1cd05890ecdf3 | 10/22/2020 21:24:14  | 10/22/2020 21:24:14 |
10.0.0.004346.444-10.0.17763.1518-ltsc2019 | 10.0.17763.1518 | ltsc2019    | amd64           | windows | sha256:c1911b71a6aa3676cb74d3c69a87efc31f37a40448b3ac99cc360e3275de2bb0 | 10/22/2020 22:00:54  | 10/22/2020 22:00:54 |
10.0.0.004346.477-10.0.17763.1577-ltsc2019 | 10.0.17763.1577 | ltsc2019    | amd64           | windows | sha256:ecd91cabe9aa1179b92bdb82c7a6b50177b46c3e450a1610b8c087923f460bb1 | 11/18/2020 12:03:25  | 11/18/2020 12:03:25 |
10.0.0.004346.60-10.0.19041.630-2004       | 10.0.19041.630  | 2004        | amd64           | windows | sha256:d0e9e4fcddab8522ad88aca5c9c9ca17125b6ae6bbe5d83624d3d0f5dfd4bd0a | 11/18/2020 12:45:37  | 11/18/2020 12:45:37 |
## tools 
This namespace includes images with tools supporting the Sitecore products. 
### sitecore-docker-tools-assets
Tag                                 | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
----------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
10.0.0-1809                         | 10.0.17763.1282 | 1809        | amd64           | windows | sha256:03461598af81ade28fc83a652b6e70cbef6f2fbcfb2c8e6ec58a6046b411797e | 08/03/2020 15:20:12  | 08/03/2020 15:20:12 |
10.0.0.104.259-10.0.17763.1282-1809 | 10.0.17763.1282 | 1809        | amd64           | windows | sha256:03461598af81ade28fc83a652b6e70cbef6f2fbcfb2c8e6ec58a6046b411797e | 08/03/2020 15:19:57  | 08/03/2020 15:19:57 |
### sitecore-razl-assets
Tag                                   | OSVersion       | TargetOS    | Architecture    | OS      | Digest                                                                  | CreatedTime          | LastUpdateTime      |
------------------------------------- | --------------- | ----------- | --------------- | ------- | ----------------------------------------------------------------------- | -------------------- | --------------------|
5.0.1-1809                            | 10.0.17763.1397 | 1809        | amd64           | windows | sha256:7d340279d4d9d9dba642819f55ec2ca53395cec8f8e1616237f585f1c38cfde8 | 08/26/2020 15:41:57  | 08/26/2020 15:41:57 |
5.0.1.501.155774-10.0.17763.1397-1809 | 10.0.17763.1397 | 1809        | amd64           | windows | sha256:7d340279d4d9d9dba642819f55ec2ca53395cec8f8e1616237f585f1c38cfde8 | 08/26/2020 15:41:19  | 08/26/2020 15:41:19 |
 
*This listing was automatically generated on December 03, 2020.*
