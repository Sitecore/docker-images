# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

WORKDIR C:/Sitecore/website/App_Config/Include

RUN Rename-Item -Path 'C:\Sitecore\website\\Web.config.Oracle' -NewName 'Web.config.Oracle.disabled'; `
    Rename-Item -Path 'C:\Sitecore\website\App_Config\\Sitecore.config.Oracle' -NewName 'Sitecore.config.Oracle.disabled'; `
    Rename-Item -Path '.\001.Sitecore.Speak.Important.config' -NewName '001.Sitecore.Speak.Important.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.ExcludeRobots.config' -NewName 'Sitecore.Analytics.ExcludeRobots.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Reporting.config' -NewName 'Sitecore.Analytics.Reporting.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Tracking.Aggregation.config' -NewName 'Sitecore.Analytics.Tracking.Aggregation.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Tracking.config' -NewName 'Sitecore.Analytics.Tracking.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Tracking.Database.config' -NewName 'Sitecore.Analytics.Tracking.Database.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Tracking.RobotDetection.config' -NewName 'Sitecore.Analytics.Tracking.RobotDetection.config.disabled'; `
    Rename-Item -Path '.\Sitecore.AntiCsrf.config' -NewName 'Sitecore.AntiCsrf.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Buckets.config' -NewName 'Sitecore.Buckets.config.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Index.Web.config' -NewName 'Sitecore.ContentSearch.Lucene.Index.Web.config.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Core.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Core.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Master.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Master.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Web.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Web.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.EngagementAutomation.Tracking.config' -NewName 'Sitecore.EngagementAutomation.Tracking.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Definitions.MarketingAssets.Repositories.Lucene.Index.Master.config' -NewName 'Sitecore.Marketing.Definitions.MarketingAssets.Repositories.Lucene.Index.Master.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Definitions.MarketingAssets.Repositories.Lucene.Index.Web.config' -NewName 'Sitecore.Marketing.Definitions.MarketingAssets.Repositories.Lucene.Index.Web.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Definitions.MarketingAssets.Repositories.Lucene.IndexConfiguration.config' -NewName 'Sitecore.Marketing.Definitions.MarketingAssets.Repositories.Lucene.IndexConfiguration.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Lucene.Index.Master.config' -NewName 'Sitecore.Marketing.Lucene.Index.Master.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Lucene.Index.Web.config' -NewName 'Sitecore.Marketing.Lucene.Index.Web.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Lucene.IndexConfiguration.config' -NewName 'Sitecore.Marketing.Lucene.IndexConfiguration.config.disabled'; `
    Rename-Item -Path '.\Sitecore.MarketingProcessingRole.config.disabled' -NewName 'Sitecore.MarketingProcessingRole.config'; `
    Rename-Item -Path '.\Sitecore.Media.RequestProtection.config' -NewName 'Sitecore.Media.RequestProtection.config.disabled'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.Client.config' -NewName 'Sitecore.PathAnalyzer.Client.config.disabled'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.Services.config' -NewName 'Sitecore.PathAnalyzer.Services.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Shell.MarketingAutomation.config' -NewName 'Sitecore.Shell.MarketingAutomation.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.AntiCsrf.SheerUI.config' -NewName 'Sitecore.Speak.AntiCsrf.SheerUI.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.Components.AntiCsrf.config' -NewName 'Sitecore.Speak.Components.AntiCsrf.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.Components.Mvc.config' -NewName 'Sitecore.Speak.Components.Mvc.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.Components.config' -NewName 'Sitecore.Speak.Components.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.config' -NewName 'Sitecore.Speak.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.ContentSearch.Lucene.config' -NewName 'Sitecore.Speak.ContentSearch.Lucene.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.ItemWebApi.config' -NewName 'Sitecore.Speak.ItemWebApi.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.LaunchPad.config' -NewName 'Sitecore.Speak.LaunchPad.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.Mvc.config' -NewName 'Sitecore.Speak.Mvc.config.disabled'; `
    Rename-Item -Path '.\Sitecore.WebDAV.config' -NewName 'Sitecore.WebDAV.config.disabled'; `
    Rename-Item -Path '.\CES\Sitecore.CES.DeviceDetection.CheckInitialization.config.disabled' -NewName 'Sitecore.CES.DeviceDetection.CheckInitialization.config'; `
    Rename-Item -Path '.\ContentTesting\Sitecore.ContentTesting.ApplicationDependencies.config' -NewName 'Sitecore.ContentTesting.ApplicationDependencies.config.disabled'; `
    Rename-Item -Path '.\ContentTesting\Sitecore.ContentTesting.Client.RulePerformance.config' -NewName 'Sitecore.ContentTesting.Client.RulePerformance.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.Client.config' -NewName 'Sitecore.ExperienceAnalytics.Client.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.Reduce.config' -NewName 'Sitecore.ExperienceAnalytics.Reduce.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.WebAPI.config' -NewName 'Sitecore.ExperienceAnalytics.WebAPI.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.ReAggregation.config.disabled' -NewName 'Sitecore.ExperienceAnalytics.ReAggregation.config'; `
    Rename-Item -Path '.\ExperienceProfile\Sitecore.ExperienceProfile.Client.config' -NewName 'Sitecore.ExperienceProfile.Client.config.disabled'; `
    Rename-Item -Path '.\ExperienceProfile\Sitecore.ExperienceProfile.config' -NewName 'Sitecore.ExperienceProfile.config.disabled'; `
    Rename-Item -Path '.\ExperienceProfile\Sitecore.ExperienceProfile.Reporting.config' -NewName 'Sitecore.ExperienceProfile.Reporting.config.disabled'; `
    Rename-Item -Path '.\FXM\Sitecore.FXM.Lucene.DomainsSearch.DefaultIndexConfiguration.config' -NewName 'Sitecore.FXM.Lucene.DomainsSearch.DefaultIndexConfiguration.config.disabled'; `
    Rename-Item -Path '.\FXM\Sitecore.FXM.Lucene.DomainsSearch.Index.Master.config' -NewName 'Sitecore.FXM.Lucene.DomainsSearch.Index.Master.config.disabled'; `
    Rename-Item -Path '.\FXM\Sitecore.FXM.Lucene.DomainsSearch.Index.Web.config' -NewName 'Sitecore.FXM.Lucene.DomainsSearch.Index.Web.config.disabled'; `
    Rename-Item -Path '.\FXM\Sitecore.FXM.Speak.config' -NewName 'Sitecore.FXM.Speak.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.Client.config' -NewName 'Sitecore.ListManagement.Client.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.config' -NewName 'Sitecore.ListManagement.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.Lucene.Index.List.config' -NewName 'Sitecore.ListManagement.Lucene.Index.List.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.Lucene.IndexConfiguration.config' -NewName 'Sitecore.ListManagement.Lucene.IndexConfiguration.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.Services.config' -NewName 'Sitecore.ListManagement.Services.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.config' -NewName 'Sitecore.Social.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.ExperienceProfile.config' -NewName 'Sitecore.Social.ExperienceProfile.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.Facebook.config' -NewName 'Sitecore.Social.Facebook.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.GooglePlus.config' -NewName 'Sitecore.Social.GooglePlus.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.LinkedIn.config' -NewName 'Sitecore.Social.LinkedIn.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.Lucene.Index.Analytics.Facebook.config' -NewName 'Sitecore.Social.Lucene.Index.Analytics.Facebook.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.Lucene.Index.Master.config' -NewName 'Sitecore.Social.Lucene.Index.Master.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.Lucene.Index.Web.config' -NewName 'Sitecore.Social.Lucene.Index.Web.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.Lucene.IndexConfiguration.config' -NewName 'Sitecore.Social.Lucene.IndexConfiguration.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.ProfileMapping.Facebook.config' -NewName 'Sitecore.Social.ProfileMapping.Facebook.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.ProfileMapping.GooglePlus.config' -NewName 'Sitecore.Social.ProfileMapping.GooglePlus.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.ProfileMapping.LinkedIn.config' -NewName 'Sitecore.Social.ProfileMapping.LinkedIn.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.ProfileMapping.Twitter.config' -NewName 'Sitecore.Social.ProfileMapping.Twitter.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.SocialMarketer.config' -NewName 'Sitecore.Social.SocialMarketer.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.Twitter.config' -NewName 'Sitecore.Social.Twitter.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\CampaignCategoryDefaultSettings.config' -NewName 'CampaignCategoryDefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\Configuration.config' -NewName 'Configuration.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\DefaultSettings.config' -NewName 'DefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\SingleCampaignDefaultSettings.config' -NewName 'SingleCampaignDefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\SingleTrafficTypeDefaultSettings.config' -NewName 'SingleTrafficTypeDefaultSettings.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Commerce.ExperienceProfile.ReportingServer.config' -NewName 'Sitecore.Commerce.ExperienceProfile.ReportingServer.config.disabled'; `
    Rename-Item -Path '.\ExperienceContentManagement.Administration\Sitecore.ExperienceContentManagement.Administration.config' -NewName 'Sitecore.ExperienceContentManagement.Administration.config.disabled'
    
WORKDIR C:/Sitecore/website
