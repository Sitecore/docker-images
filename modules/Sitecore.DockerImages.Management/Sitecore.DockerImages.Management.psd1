@{

    # Script module or binary module file associated with this manifest.
    RootModule             = 'Sitecore.DockerImages.Management.psm1'

    # Version number of this module.
    ModuleVersion          = '1.0'

    # ID used to uniquely identify this module
    GUID                   = '9304670b-b5c6-4a02-b47e-cfb5c84b448e'

    # Author of this module
    Author                 = 'Benjamin Moles'

    # Company or vendor of this module
    CompanyName            = ''

    # Copyright statement for this module
    Copyright              = ''

    # Description of the functionality provided by this module
    Description            = 'Management tools for Sitecore Docker images.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion      = '5.0'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module
    DotNetFrameworkVersion = "4.5"

    # Minimum version of the common language runtime (CLR) required by this module
    CLRVersion             = "4.0"

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules = @(
        @{
            ModuleName = "Bendev.Assets.Management"; 
            ModuleVersion = "1.0.0.1"; 
            Guid = "03742115-6c2a-4f0a-8ef7-a9e31bcbad20"
        }    
    )

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies  =  @(
               'System.IO.Compression', 
               'System.IO.Compression.FileSystem'
    )

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    ScriptsToProcess = @('Private\Load.ps1')

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules          = @(
			'Functions\Get-ImageBuildFolders.ps1',
			'Functions\Invoke-SitecoreDockerImageBuild.ps1',
			'Functions\Invoke-SitecoreDockerImageCheckSources.ps1',
            'Functions\Invoke-SitecoreDockerImageProcessAssets.ps1'
	)

    # Functions to export from this module
    FunctionsToExport      = @(
			'Get-ImageBuildFolders',
			'Invoke-SitecoreDockerImageBuild',
			'Invoke-SitecoreDockerImageCheckSources',
            'Invoke-SitecoreDockerImageProcessAssets'
	)

    # Cmdlets to export from this module
    CmdletsToExport        = '*'

    # Variables to export from this module
    VariablesToExport      = '*'

    # Aliases to export from this module
    AliasesToExport        = '*'

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData            = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @('Sitecore', 'Docker')

            # A URL to the license for this module.
            # LicenseUri = ''

            # A URL to the main website for this project.
            # ProjectUri = ''

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}