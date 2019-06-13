# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

WORKDIR C:/Sitecore/website/App_Config/Include

RUN Rename-Item -Path '.\Sitecore.Analytics.Processing.Aggregation.Services.config' -NewName 'Sitecore.Analytics.Processing.Aggregation.Services.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Processing.Services.config' -NewName 'Sitecore.Analytics.Processing.Services.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Tracking.Aggregation.config' -NewName 'Sitecore.Analytics.Tracking.Aggregation.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Tracking.Database.config' -NewName 'Sitecore.Analytics.Tracking.Database.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Tracking.RobotDetection.config' -NewName 'Sitecore.Analytics.Tracking.RobotDetection.config.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Core.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Core.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Master.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Master.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Web.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Web.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.EngagementAutomation.Processing.Aggregation.Services.config' -NewName 'Sitecore.EngagementAutomation.Processing.Aggregation.Services.config.disabled'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.Processing.config' -NewName 'Sitecore.PathAnalyzer.Processing.config.disabled'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.RemoteClient.config.disabled' -NewName 'Sitecore.PathAnalyzer.RemoteClient.config'; `
    Rename-Item -Path '.\Sitecore.Xdb.Remote.Client.config.disabled' -NewName 'Sitecore.Xdb.Remote.Client.config'; `
    Rename-Item -Path '.\Sitecore.Xdb.Remote.Client.MarketingAssets.config.disabled' -NewName 'Sitecore.Xdb.Remote.Client.MarketingAssets.config'; `
    Rename-Item -Path '.\ContentTesting\Sitecore.ContentTesting.PreemptiveScreenshot.config.disabled' -NewName 'Sitecore.ContentTesting.PreemptiveScreenshot.config'; `
    Rename-Item -Path '.\ContentTesting\Sitecore.ContentTesting.Processing.Aggregation.config' -NewName 'Sitecore.ContentTesting.Processing.Aggregation.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.Aggregation.config' -NewName 'Sitecore.ExperienceAnalytics.Aggregation.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.Reduce.config' -NewName 'Sitecore.ExperienceAnalytics.Reduce.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.DisableListLocking.config.disabled' -NewName 'Sitecore.ListManagement.DisableListLocking.config'; `
    Rename-Item -Path '.\Social\Sitecore.Social.ScalabilitySettings.config.disabled' -NewName 'Sitecore.Social.ScalabilitySettings.config'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\CampaignCategoryDefaultSettings.config' -NewName 'CampaignCategoryDefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\Configuration.config' -NewName 'Configuration.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\DefaultSettings.config' -NewName 'DefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\SingleCampaignDefaultSettings.config' -NewName 'SingleCampaignDefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\SingleTrafficTypeDefaultSettings.config' -NewName 'SingleTrafficTypeDefaultSettings.config.disabled'
    
WORKDIR C:/Sitecore/website
