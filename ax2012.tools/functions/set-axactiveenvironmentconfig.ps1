
<#
        
    .SYNOPSIS
        Set the active environment configuration
        
    .DESCRIPTION
        Updates the current active environment configuration with a new one
        
        Use this to update the default parameters across the module, to make it easier to call your different commands

    .PARAMETER Name
        Name of the environment configuration you want to load into the active environment configuration
        
    .PARAMETER Temporary
        Instruct the cmdlet to only temporarily override the persisted settings in the configuration store
        
    .EXAMPLE
        PS C:\> Set-AxActiveEnvironmentConfig -Name "UAT"
        
        This will set the environment configuration named "UAT" as the active configuration.
        
    .NOTES
        Tags: Servicing, Environment, Config, Configuration, Servers
        
        Author: Mötz Jensen (@Splaxi)
        
    .LINK
        Add-AxEnvironmentConfig

    .LINK
        Get-AxActiveEnvironmentConfig

    .LINK
        Get-AxEnvironmentConfig
        
#>

function Set-AxActiveEnvironmentConfig {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [CmdletBinding()]
    [OutputType()]
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string] $Name,

        [switch] $Temporary
    )

    if($Name -match '\*') {
        $messageString = "The name cannot contain <c='em'>wildcard character</c>."
        Write-PSFMessage -Level Host -Message $messageString
        Stop-PSFFunction -Message "Stopping because the name contains wildcard character." -Exception $([System.Exception]::new($($messageString -replace '<[^>]+>','')))
        return
    }
    
    if (-not ((Get-PSFConfig -FullName "ax2012.tools.environment.*.name").Value -contains $Name)) {
        $messageString = "An environment configuration with that name <c='em'>doesn't exists</c>."
        Write-PSFMessage -Level Host -Message $messageString
        Stop-PSFFunction -Message "Stopping because an OData message configuration with that name doesn't exists." -Exception $([System.Exception]::new($($messageString -replace '<[^>]+>','')))
        return
    }
    
    Set-PSFConfig -FullName "ax2012.tools.active.environment.config.name" -Value $Name
    if (-not $Temporary) { Register-PSFConfig -FullName "ax2012.tools.active.environment.config.name"  -Scope UserDefault }

    Update-EnvironmentVariables
}