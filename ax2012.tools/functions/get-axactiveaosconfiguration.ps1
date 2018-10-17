<#
.SYNOPSIS
Get the active stored AX 2012 AOS configuration

.DESCRIPTION
Get the active AX 2012 AOS configuration from the configuration storage

.EXAMPLE
PS C:\> Get-AxActiveAosConfiguration

This will export all the stored details saved into the configuration storage.

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
function Get-AxActiveAosConfiguration {
    [CmdletBinding()]
    param (
        
    )

    $res = [Ordered]@{}

    $res.InstanceName = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.instancename'
    $res.BinDirectory = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.bindirectory'

    $res.DatabaseServer = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.databaseserver'
    $res.DatabaseName = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.database'
    $res.ModelstoreDatabase = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.modelstoredatabase'

    $res.AosPort = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.aos.port'
    $res.WsdlPort = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.wsdl.port'
    $res.NetTcpPort = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.nettcp.port'
    
    $res.InstanceNumber = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.instance.number'
    $res.ComputerName = Get-PSFConfigValue -FullName 'ax2012.tools.active.aos.computername'

    [PSCustomObject] $res
}