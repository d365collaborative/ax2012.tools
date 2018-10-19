@{
    # Script module or binary module file associated with this manifest
    RootModule        = 'ax2012.tools.psm1'
	
    # Version number of this module.
    ModuleVersion     = '0.1.3'
	
    # ID used to uniquely identify this module
    GUID              = 'c0052746-6bea-41a0-9aeb-68badbe62024'
	
    # Author of this module
    Author            = 'Mötz Jensen'
	
    # Company or vendor of this module
    CompanyName       = 'Essence Solutions'
	
    # Copyright statement for this module
    Copyright         = 'Copyright (c) 2018 Mötz Jensen. All rights reserved.'
	
    # Description of the functionality provided by this module
    Description       = 'A set of tools that will assist you when working with the Microsoft Dynamics AX 2012 platform.'
	
    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.0'
	
    # Modules that must be imported into the global environment prior to importing
    # this module
    RequiredModules   = @(
        @{ ModuleName = 'PSFramework'; ModuleVersion = '0.10.27.128' },
        @{ ModuleName = 'PSNotification'; ModuleVersion = '0.5.3' }
    )
	
    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @('bin\ax2012.tools.dll')
	
    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @('xml\ax2012.tools.Types.ps1xml')
	
    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @('xml\ax2012.tools.Format.ps1xml')
	
    # Functions to export from this module
    FunctionsToExport = @(
                            'Export-AxModelV2',

                            'Get-AxActiveAosConfiguration',
                            'Get-AxAosInstance',

                            'Get-AxClientBuild',
                            'Get-AxClientConfig',
                            
                            'Get-AxEnvironment',
                            'Get-AxWMDPDetails',
                            
                            'Invoke-AxBuild',
                            'Invoke-AxExportModelstore',
                            'Import-AxModelV2',

                            'Set-AxActiveAosConfiguration',
                            'Start-AxEnvironment',
                            'Stop-AxEnvironment'
    )
	
    # Cmdlets to export from this module
    CmdletsToExport   = ''
	
    # Variables to export from this module
    VariablesToExport = ''
	
    # Aliases to export from this module
    AliasesToExport   = ''
	
    # List of all modules packaged with this module
    ModuleList        = @()
	
    # List of all files packaged with this module
    FileList          = @()
	
    # Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{
		
        #Support for PowerShellGet galleries.
        PSData = @{
			
            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()
			
            # A URL to the license for this module.
            LicenseUri   = "https://opensource.org/licenses/MIT"

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/d365collaborative/ax2012.tools'
			
            # A URL to an icon representing this module.
            # IconUri = ''
			
            # ReleaseNotes of this module
            # ReleaseNotes = ''

            # Indicates this is a pre-release/testing version of the module.
            IsPrerelease = 'True'

        } # End of PSData hashtable
		
    } # End of PrivateData hashtable
}