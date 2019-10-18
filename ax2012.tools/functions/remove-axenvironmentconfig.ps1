
<#
    .SYNOPSIS
        Remove environment configuration
        
    .DESCRIPTION
        Remove a environment configuration from the configuration store
        
    .PARAMETER Name
        Name of the environment configuration you want to remove from the configuration store
        
    .PARAMETER Temporary
        Instruct the cmdlet to only temporarily remove the environment configuration from the configuration store
        
    .EXAMPLE
        PS C:\> Remove-AxEnvironmentConfig -Name "UAT"
        
        This will remove the environment configuration name "UAT" from the machine.
        
    .NOTES
        Tags: Servicing, Environment, Config, Configuration, Servers
        
        Author: Mötz Jensen (@Splaxi)
        
    .LINK
        Add-AxEnvironmentConfig
        
    .LINK
        Clear-AxActiveEnvironmentConfig
        
    .LINK
        Get-AxActiveEnvironmentConfig
        
    .LINK
        Get-AxEnvironmentConfig
        
    .LINK
        Set-AxActiveEnvironmentConfig
        
#>

function Remove-AxEnvironmentConfig {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [CmdletBinding()]
    [OutputType()]
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string] $Name,

        [switch] $Temporary
    )

    $Name = $Name.ToLower()

    if ($Name -match '\*') {
        Write-PSFMessage -Level Host -Message "The name cannot contain <c='em'>wildcard character</c>."
        Stop-PSFFunction -Message "Stopping because the name contains wildcard character."
        return
    }

    if (-not ((Get-PSFConfig -FullName "ax2012.tools.environment.*.name").Value -contains $Name)) {
        Write-PSFMessage -Level Host -Message "A environment configuration with that name <c='em'>doesn't exists</c>."
        Stop-PSFFunction -Message "Stopping because a environment message configuration with that name doesn't exists."
        return
    }

    $res = (Get-PSFConfig -FullName "ax2012.tools.environment.config.name").Value

    if ($res -eq $Name) {
        Write-PSFMessage -Level Host -Message "The active environment configuration is the <c='em'>same as the one you're trying to remove</c>. Please set another configuration as active, before removing this one. You could also call Clear-AxActiveEnvironmentConfig."
        Stop-PSFFunction -Message "Stopping because the active environment configuration is the same as the one trying to be removed."
        return
    }

    foreach ($config in Get-PSFConfig -FullName "ax2012.tools.environment.$Name.*") {
        Set-PSFConfig -FullName $config.FullName -Value ""

        if (-not $Temporary) { Unregister-PSFConfig -FullName $config.FullName -Scope UserDefault }
    }
}