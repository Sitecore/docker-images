# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

WORKDIR C:/Sitecore/website/App_Config/Include

RUN Rename-Item -Path '.\001.Sitecore.Speak.Important.config' -NewName '001.Sitecore.Speak.Important.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Processing.Aggregation.config' -NewName 'Sitecore.Analytics.Processing.Aggregation.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Processing.Aggregation.Services.config' -NewName 'Sitecore.Analytics.Processing.Aggregation.Services.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Processing.config' -NewName 'Sitecore.Analytics.Processing.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Processing.Services.config' -NewName 'Sitecore.Analytics.Processing.Services.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Analytics.Reporting.config' -NewName 'Sitecore.Analytics.Reporting.config.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Index.Analytics.config' -NewName 'Sitecore.ContentSearch.Lucene.Index.Analytics.config.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Index.Core.config' -NewName 'Sitecore.ContentSearch.Lucene.Index.Core.config.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Index.Master.config' -NewName 'Sitecore.ContentSearch.Lucene.Index.Master.config.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Core.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Core.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Master.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Master.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.ContentSearch.Lucene.Indexes.Sharded.Web.config.example' -NewName 'Sitecore.ContentSearch.Lucene.Indexes.Sharded.Web.config.example.disabled'; `
    Rename-Item -Path '.\Sitecore.EngagementAutomation.Processing.Aggregation.config' -NewName 'Sitecore.EngagementAutomation.Processing.Aggregation.config.disabled'; `
    Rename-Item -Path '.\Sitecore.EngagementAutomation.Processing.Aggregation.Services.config' -NewName 'Sitecore.EngagementAutomation.Processing.Aggregation.Services.config.disabled'; `
    Rename-Item -Path '.\Sitecore.EngagementAutomation.Processing.config' -NewName 'Sitecore.EngagementAutomation.Processing.config.disabled'; `
    Rename-Item -Path '.\Sitecore.EngagementAutomation.TimeoutProcessing.config' -NewName 'Sitecore.EngagementAutomation.TimeoutProcessing.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Client.config' -NewName 'Sitecore.Marketing.Client.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Definitions.MarketingAssets.Repositories.Lucene.Index.Master.config' -NewName 'Sitecore.Marketing.Definitions.MarketingAssets.Repositories.Lucene.Index.Master.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.Definitions.MarketingAssets.RepositoriesCD.config.disabled' -NewName 'Sitecore.Marketing.Definitions.MarketingAssets.RepositoriesCD.config'; `
    Rename-Item -Path '.\Sitecore.Marketing.Lucene.Index.Master.config' -NewName 'Sitecore.Marketing.Lucene.Index.Master.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Marketing.TaxonomyCD.config.disabled' -NewName 'Sitecore.Marketing.TaxonomyCD.config'; `
    Rename-Item -Path '.\Sitecore.MarketingCD.config.disabled' -NewName 'Sitecore.MarketingCD.config'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.Client.config' -NewName 'Sitecore.PathAnalyzer.Client.config.disabled'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.config' -NewName 'Sitecore.PathAnalyzer.config.disabled'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.Processing.config' -NewName 'Sitecore.PathAnalyzer.Processing.config.disabled'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.Services.config' -NewName 'Sitecore.PathAnalyzer.Services.config.disabled'; `
    Rename-Item -Path '.\Sitecore.PathAnalyzer.StorageProviders.config' -NewName 'Sitecore.PathAnalyzer.StorageProviders.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Processing.config' -NewName 'Sitecore.Processing.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Shell.MarketingAutomation.config' -NewName 'Sitecore.Shell.MarketingAutomation.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.AntiCsrf.SheerUI.config' -NewName 'Sitecore.Speak.AntiCsrf.SheerUI.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.Applications.config' -NewName 'Sitecore.Speak.Applications.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.Components.AntiCsrf.config' -NewName 'Sitecore.Speak.Components.AntiCsrf.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.Components.Mvc.config' -NewName 'Sitecore.Speak.Components.Mvc.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.Components.config' -NewName 'Sitecore.Speak.Components.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.config' -NewName 'Sitecore.Speak.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.ContentSearch.Lucene.config' -NewName 'Sitecore.Speak.ContentSearch.Lucene.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.ItemWebApi.config' -NewName 'Sitecore.Speak.ItemWebApi.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Speak.LaunchPad.config' -NewName 'Sitecore.Speak.LaunchPad.config.disabled'; `
    Rename-Item -Path '.\Sitecore.WebDAV.config' -NewName 'Sitecore.WebDAV.config.disabled'; `
    Rename-Item -Path '.\ContentTesting\Sitecore.ContentTesting.ApplicationDependencies.config' -NewName 'Sitecore.ContentTesting.ApplicationDependencies.config.disabled'; `
    Rename-Item -Path '.\ContentTesting\Sitecore.ContentTesting.Client.RulePerformance.config' -NewName 'Sitecore.ContentTesting.Client.RulePerformance.config.disabled'; `
    Rename-Item -Path '.\ContentTesting\Sitecore.ContentTesting.Lucene.IndexConfiguration.config' -NewName 'Sitecore.ContentTesting.Lucene.IndexConfiguration.config.disabled'; `
    Rename-Item -Path '.\ContentTesting\Sitecore.ContentTesting.Processing.Aggregation.config' -NewName 'Sitecore.ContentTesting.Processing.Aggregation.config.disabled'; `
    Rename-Item -Path '.\\Sitecore.ExperienceAnalytics.config' -NewName 'Sitecore.ExperienceAnalytics.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.Aggregation.config' -NewName 'Sitecore.ExperienceAnalytics.Aggregation.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.Client.config' -NewName 'Sitecore.ExperienceAnalytics.Client.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.Reduce.config' -NewName 'Sitecore.ExperienceAnalytics.Reduce.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.StorageProviders.config' -NewName 'Sitecore.ExperienceAnalytics.StorageProviders.config.disabled'; `
    Rename-Item -Path '.\ExperienceAnalytics\Sitecore.ExperienceAnalytics.WebAPI.config' -NewName 'Sitecore.ExperienceAnalytics.WebAPI.config.disabled'; `
    Rename-Item -Path '.\ExperienceProfile\Sitecore.ExperienceProfile.Client.config' -NewName 'Sitecore.ExperienceProfile.Client.config.disabled'; `
    Rename-Item -Path '.\ExperienceProfile\Sitecore.ExperienceProfile.config' -NewName 'Sitecore.ExperienceProfile.config.disabled'; `
    Rename-Item -Path '.\ExperienceProfile\Sitecore.ExperienceProfile.Reporting.config' -NewName 'Sitecore.ExperienceProfile.Reporting.config.disabled'; `
    Rename-Item -Path '.\FXM\Sitecore.FXM.Lucene.DomainsSearch.Index.Master.config' -NewName 'Sitecore.FXM.Lucene.DomainsSearch.Index.Master.config.disabled'; `
    Rename-Item -Path '.\FXM\Sitecore.FXM.Speak.config' -NewName 'Sitecore.FXM.Speak.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.Client.config' -NewName 'Sitecore.ListManagement.Client.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.config' -NewName 'Sitecore.ListManagement.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.Lucene.Index.List.config' -NewName 'Sitecore.ListManagement.Lucene.Index.List.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.Lucene.IndexConfiguration.config' -NewName 'Sitecore.ListManagement.Lucene.IndexConfiguration.config.disabled'; `
    Rename-Item -Path '.\ListManagement\Sitecore.ListManagement.Services.config' -NewName 'Sitecore.ListManagement.Services.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.ExperienceProfile.config' -NewName 'Sitecore.Social.ExperienceProfile.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.Lucene.Index.Master.config' -NewName 'Sitecore.Social.Lucene.Index.Master.config.disabled'; `
    Rename-Item -Path '.\Social\Sitecore.Social.ScalabilitySettings.config.disabled' -NewName 'Sitecore.Social.ScalabilitySettings.config'; `
    Rename-Item -Path '.\Z.SwitchMasterToWeb\SwitchMasterToWeb.config.example' -NewName 'SwitchMasterToWeb.config'; `
    Rename-Item -Path '.\Sitecore.Update.config' -NewName 'Sitecore.Update.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\CampaignCategoryDefaultSettings.config' -NewName 'CampaignCategoryDefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\Configuration.config' -NewName 'Configuration.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\DefaultSettings.config' -NewName 'DefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\SingleCampaignDefaultSettings.config' -NewName 'SingleCampaignDefaultSettings.config.disabled'; `
    Rename-Item -Path '.\..\..\sitecore\shell\Applications\Reports\Dashboard\SingleTrafficTypeDefaultSettings.config' -NewName 'SingleTrafficTypeDefaultSettings.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Commerce.ExperienceAnalytics.config' -NewName 'Sitecore.Commerce. ExperienceAnalytics.config.disabled'; `
    Rename-Item -Path '.\Sitecore.Commerce.ExperienceProfile.ReportingServer.config' -NewName 'Sitecore.Commerce. ExperienceProfile.ReportingServer.config.disabled'; `
    Rename-Item -Path '.\ExperienceContentManagement.Administration\Sitecore.ExperienceContentManagement.Administration.config' -NewName 'Sitecore.ExperienceContentManagement.Administration.config.disabled'

WORKDIR C:/Sitecore/website

