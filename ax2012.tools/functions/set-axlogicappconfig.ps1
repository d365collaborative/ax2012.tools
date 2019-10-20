
<#
    .SYNOPSIS
        Set the details for the logic app invoke cmdlet
        
    .DESCRIPTION
        Store the needed details for the module to execute an Azure Logic App using a HTTP request
        
    .PARAMETER Url
        The URL for the http request endpoint of the desired logic app
        
    .PARAMETER Email
        The receiving email address that should be notified
        
    .PARAMETER Subject
        The subject of the email that you want to send
        
    .PARAMETER ConfigStorageLocation
        Parameter used to instruct where to store the configuration objects
        
        The default value is "User" and this will store all configuration for the active user
        
        Valid options are:
        "User"
        "System"
        
        "System" will store the configuration so all users can access the configuration objects
        
    .PARAMETER Temporary
        Instruct the cmdlet to only temporarily override the persisted settings in the configuration storage
        
    .EXAMPLE
        PS C:\> Set-AxLogicAppConfig -Email administrator@contoso.com -Subject "Work is done" -Url https://prod-35.westeurope.logic.azure.com:443/
        
        This will set all the details about invoking the Logic App.
        
    .EXAMPLE
        PS C:\> Set-AxLogicAppConfig -Email administrator@contoso.com -Subject "Work is done" -Url https://prod-35.westeurope.logic.azure.com:443/ -ConfigStorageLocation "System"
        
        This will set all the details about invoking the Logic App.
        The data will be stored in the system wide configuration storage, which makes it accessible from all users.
        
    .EXAMPLE
        PS C:\> Set-AxLogicAppConfig -Email administrator@contoso.com -Subject "Work is done" -Url https://prod-35.westeurope.logic.azure.com:443/ -Temporary
        
        This will set all the details about invoking the Logic App.
        The update will only last for the rest of this PowerShell console session.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Set-AxLogicAppConfig {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true )]
        [string] $Url,

        [Parameter(Mandatory = $true )]
        [string] $Email,

        [Parameter(Mandatory = $true )]
        [string] $Subject,

        [ValidateSet('User', 'System')]
        [string] $ConfigStorageLocation = "User",

        [switch] $Temporary
    )

    $configScope = Test-ConfigStorageLocation -ConfigStorageLocation $ConfigStorageLocation

    if (Test-PSFFunctionInterrupt) { return }
    
    foreach ($key in $PSBoundParameters.Keys) {
        $value = $PSBoundParameters.Item($key)
        $name = $null

        Write-PSFMessage -Level Verbose -Message "Working on $key with $value" -Target $value

        
        switch ($key) {
            "Email" {
                $name = 'active.logicapp.email'
                $Script:LogicAppEmail = $value
            }

            "Url" {
                $name = 'active.logicapp.url'
                $Script:LogicAppUrl = $value
            }

            "Subject" {
                $name = 'active.logicapp.subject'
                $Script:LogicAppSubject = $value
            }

            Default {}
        }

        Set-PSFConfig -Module 'ax2012.tools' -Name $name -Value $value
        if (-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name $name -Scope $configScope }
    }
}