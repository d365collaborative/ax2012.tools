
<#
    .SYNOPSIS
        Clear the active environment config
        
    .DESCRIPTION
        Clear the active environment config from the configuration store
        
    .PARAMETER Temporary
        Instruct the cmdlet to only temporarily clear the active environment configuration in the configuration store
        
    .EXAMPLE
        PS C:\> Clear-AxActiveEnvironmentConfig
        
        This will clear the active environment configuration from the configuration store.
        
    .NOTES
        Tags: Environment, Config, Configuration, Servers
        
        Author: Mötz Jensen (@Splaxi)
    .LINK
        Add-AxEnvironmentConfig
        
    .LINK
        Get-AxActiveEnvironmentConfig
        
    .LINK
        Get-AxEnvironmentConfig
        
    .LINK
        Remove-AxEnvironmentConfig
        
    .LINK
        Set-AxActiveEnvironmentConfig
#>

function Clear-AxActiveEnvironmentConfig {
    [CmdletBinding()]
    [OutputType()]
    param (
        [switch] $Temporary
    )

    $configurationName = "ax2012.tools.active.environment.config.name"
    
    Reset-PSFConfig -FullName $configurationName

    if (-not $Temporary) { Register-PSFConfig -FullName $configurationName -Scope UserDefault }
}