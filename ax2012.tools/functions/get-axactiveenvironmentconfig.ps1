
<#
    .SYNOPSIS
        Get the active environment configuration
        
    .DESCRIPTION
        Get the active environment configuration from the configuration store
        
    .PARAMETER OutputAsHashtable
        Instruct the cmdlet to return a hashtable object
        
    .PARAMETER EnableException
        This parameters disables user-friendly warnings and enables the throwing of exceptions
        This is less user friendly, but allows catching exceptions in calling scripts
        
    .EXAMPLE
        PS C:\> Get-AxActiveEnvironmentConfig
        
        This will get the active environment configuration.
        
    .NOTES
        Tags: Environment, Config, Configuration, Servers
        
        Author: Mötz Jensen (@Splaxi)
        
    .LINK
        Add-AxEnvironmentConfig
        
    .LINK
        Get-AxEnvironmentConfig
        
    .LINK
        Set-AxActiveEnvironmentConfig
#>

function Get-AxActiveEnvironmentConfig {
    [CmdletBinding()]
    [OutputType()]
    param (
        [switch] $OutputAsHashtable,

        [switch] $EnableException
    )

    $configName = (Get-PSFConfig -FullName "ax2012.tools.active.environment.config.name").Value

    if ($configName -eq "") {
        $messageString = "It looks like there <c='em'>isn't configured</c> an active environment configuration."
        Write-PSFMessage -Level Host -Message $messageString
        Stop-PSFFunction -Message "Stopping because an active environment configuration wasn't found." -Exception $([System.Exception]::new($($messageString -replace '<[^>]+>', '')))
        return
    }

    Get-AxEnvironmentConfig -Name $configName -OutputAsHashtable:$OutputAsHashtable
}