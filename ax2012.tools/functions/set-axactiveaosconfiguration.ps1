
<#
    .SYNOPSIS
        Set the active AX 2012 AOS configuration
        
    .DESCRIPTION
        Set the active AX 2012 AOS details and store it into the configuration storage
        
    .PARAMETER ComputerName
        The name of the computer / server that AOS resides on
        
    .PARAMETER BinDirectory
        The full path to the bin directory where the AOS instance is physical installed
        
    .PARAMETER InstanceNumber
        The 2 digit ([0-9][0-9]) number that the AOS instance has on the server
        
    .PARAMETER InstanceName
        The instance name the AOS server is registered with
        
    .PARAMETER DatabaseServer
        The name of the server running SQL Server
        
    .PARAMETER DatabaseName
        The name of the AX 2012 business data database
        
    .PARAMETER ModelstoreDatabase
        The name of the AX 2012 modelstore database
        
    .PARAMETER AosPort
        The TCP port that the AX 2012 AOS server is communicating with the AX clients on
        
    .PARAMETER WsdlPort
        The TCP port that the AX 2012 AOS server is communicating with all WSDL consuming applications on
        
    .PARAMETER NetTcpPort
        The TCP port that the AX 2012 AOS server is communicating with all NetTcp consuming applications on
        
    .PARAMETER Temporary
        Switch to instruct the cmdlet to only temporarily override the persisted settings in the configuration storage
        
    .EXAMPLE
        PS C:\> Get-AxAosInstance | Select-Object -First 1 | Set-AxActiveAosConfiguration
        
        This will get all the AX 2012 AOS instances from the local machine and only select the first output.
        The output from the first AOS instance is saved into the configuration store.
    
    .EXAMPLE
        PS C:\> Set-AxActiveAosConfiguration -ComputerName AX2012PROD -DatabaseServer SQLSERVER -DatabaseName AX2012R3_PROD -ModelstoreDatabase AX2012R3_PROD_model -AosPort 2712

        This will update the active AOS configuration store settings.
        The computer name will be registered to: AX2012PROD
        The database server will be registered to: SQLSERVER
        The database name will be registered to: AX2012R3_PROD
        The model store database will be registered to: AX2012R3_PROD_model
        The AOS port will be registered to: 2712
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Set-AxActiveAosConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding()]
    param (

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 1)]
        [string] $ComputerName = "$env:computername",

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 2)]
        [string] $BinDirectory,

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 3)]
        [string] $InstanceNumber,
        
        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 4)]
        [string] $InstanceName,
        
        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 5)]
        [string] $DatabaseServer,
                
        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 6)]
        [string] $DatabaseName,
        
        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 7)]
        [string] $ModelstoreDatabase,

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 8)]
        [string] $AosPort,

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 9)]
        [string] $WsdlPort,

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 10)]
        [string] $NetTcpPort,
        
        [switch] $Temporary
    )
    
    foreach ($key in $PSBoundParameters.Keys) {
        $value = $PSBoundParameters.Item($key).ToString()

        Write-PSFMessage -Level Verbose -Message "Working on $key with $value" -Target $value

        switch ($key) {
            "ComputerName" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.computername' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.computername' }
            }

            "BinDirectory" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.bindirectory' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.bindirectory' }
            }

            "InstanceNumber" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.instance.number' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.instance.number' }
            }

            "InstanceName" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.instancename' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.instancename' }
            }

            "DatabaseServer" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.databaseserver' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.databaseserver' }
            }
		
            "DatabaseName" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.database' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.database' }
            }

            "ModelstoreDatabase" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.modelstoredatabase' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.modelstoredatabase' }
            }

            "AosPort" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.aos.port' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.aos.port' }
            }
            

            "WsdlPort" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.wsdl.port' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.wsdl.port' }
            }

            "NetTcpPort" {
                Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.nettcp.port' -Value $value
                if(-not $Temporary) { Register-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.nettcp.port' }
            }

            Default {}
        }
       
    }
}