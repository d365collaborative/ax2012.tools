
<#
    .SYNOPSIS
        Get the registered details for Azure Logic App
        
    .DESCRIPTION
        Get the details that are stored for the module when
        it has to invoke the Azure Logic App
        
    .EXAMPLE
        PS C:\> Get-AxLogicAppConfig
        
        This will fetch the current registered Azure Logic App details on the machine.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxLogicAppConfig {
    [CmdletBinding()]
    param ()

    [PSCustomObject][ordered]@{
        Email = (Get-PSFConfigValue -Fullname 'ax2012.tools.active.logicapp.email')
        URL = (Get-PSFConfigValue -Fullname 'ax2012.tools.active.logicapp.url')
        Subject = (Get-PSFConfigValue -Fullname 'ax2012.tools.active.logicapp.subject')
    }
}