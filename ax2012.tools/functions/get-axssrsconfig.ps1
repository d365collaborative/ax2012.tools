
<#
    .SYNOPSIS
        Get the SSRS configuration
        
    .DESCRIPTION
        Get all the SSRS configuration from the AX 2012 database
        
    .PARAMETER DatabaseServer
        Server name of the database server
        
        Default value is: "localhost"
        
    .PARAMETER DatabaseName
        Name of the database
        
        Default value is: "MicrosoftDynamicsAx"
        
    .PARAMETER SqlUser
        User name of the SQL Server credential that you want to use when working against the database
        
    .PARAMETER SqlPwd
        Password of the SQL Server credential that you want to use when working against the database
        
    .EXAMPLE
        PS C:\> Get-AxSsrsConfig
        
        This will get all the stored SSRS configuration entries from the default DatabaseServer and the default Database.
        
    .EXAMPLE
        PS C:\> Get-AxAosInstance | Get-AxSsrsConfig
        
        This will get all AOS Instance from the local machine and pipe them to the Get-AxSsrsConfig cmdlet.
        The Get-AxSsrsConfig will the traverse every AOS Instance and their corresponding database for all SSRS configuration.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
#>
function Get-AxSsrsConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, Position = 1)]
        [string] $DatabaseServer = $Script:ActiveAosDatabaseserver,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, Position = 2)]
        [string] $DatabaseName = $Script:ActiveAosDatabase,

        [Parameter(Mandatory = $false, Position = 3)]
        [string] $SqlUser,

        [Parameter(Mandatory = $false, Position = 4)]
        [string] $SqlPwd
    )

    begin {
        Invoke-TimeSignal -Start
    }

    process {

        $baseParams = Get-DeepClone $PSBoundParameters
        $baseParams.Add("TrustedConnection", $true)

        $UseTrustedConnection = Test-TrustedConnection $baseParams

        $SqlParams = @{ DatabaseServer = $DatabaseServer; DatabaseName = $DatabaseName;
            SqlUser = $SqlUser; SqlPwd = $SqlPwd
        }

        $sqlCommand = Get-SqlCommand @SqlParams -TrustedConnection $UseTrustedConnection

        $sqlCommand.CommandText = (Get-Content "$script:ModuleRoot\internal\sql\get-ssrsconfig.sql") -join [Environment]::NewLine

        try {
            Write-PSFMessage -Level InternalComment -Message "Executing a script against the database." -Target (Get-SqlString $sqlCommand)

            $sqlCommand.Connection.Open()

            $reader = $sqlCommand.ExecuteReader()

            while ($reader.Read() -eq $true) {
                [PSCustomObject][ordered]@{
                    SsrsServerName             = "$($reader.GetString($($reader.GetOrdinal("SERVERID"))))"
                    IsDefaultReportmodelServer = [bool][int]"$($reader.GetInt32($($reader.GetOrdinal("ISDEFAULTREPORTMODELSERVER"))))"
                    ServerUrl                  = "$($reader.GetString($($reader.GetOrdinal("SERVERURL"))))"
                    IsDefaultReportServer      = [bool][int]"$($reader.GetInt32($($reader.GetOrdinal("ISDEFAULTREPORTLIBRARYSERVER"))))"
                    AxaptaReportFolder         = "$($reader.GetString($($reader.GetOrdinal("AXAPTAREPORTFOLDER"))))"
                    Description                = "$($reader.GetString($($reader.GetOrdinal("DESCRIPTION"))))"
                    DataSourceName             = "$($reader.GetString($($reader.GetOrdinal("DATASOURCENAME"))))"
                    ReportManagerUrl           = "$($reader.GetString($($reader.GetOrdinal("REPORTMANAGERURL"))))"
                    ServerInstance             = "$($reader.GetString($($reader.GetOrdinal("SERVERINSTANCE"))))"
                    AosId                      = "$($reader.GetString($($reader.GetOrdinal("AOSID"))))"
                    ConfigurationId            = "$($reader.GetString($($reader.GetOrdinal("CONFIGURATIONID"))))"
                    IsSharepointIntegrated     = [bool][int]"$($reader.GetInt32($($reader.GetOrdinal("ISSHAREPOINTINTEGRATED"))))"
                }
            }
        }
        catch {
            Write-PSFMessage -Level Host -Message "Something went wrong while working against the database" -Exception $PSItem.Exception
            Stop-PSFFunction -Message "Stopping because of errors"
            return
        }
        finally {
            if ($sqlCommand.Connection.State -ne [System.Data.ConnectionState]::Closed) {
                $sqlCommand.Connection.Close()
            }
    
            $sqlCommand.Dispose()
        }
    }
    end {
        Invoke-TimeSignal -End

    }
}


<#

InstanceName          : MicrosoftDynamicsAX
ConfigurationName     : DEBUG
BinDirectory          : C:\Program Files\Microsoft Dynamics AX\60\Server\MicrosoftDynamicsAX\Bin\
ExecutablePath        : C:\Program Files\Microsoft Dynamics AX\60\Server\MicrosoftDynamicsAX\Bin\Ax32Serv.exe
FileVersion           : 6.3.6000.7046
ProductVersion        : 6.3.6000.7046
FileVersionUpdated    : 6.3.6000.7046
ProductVersionUpdated : 6.3.6000.7046
DatabaseServer        : GJ-AX2012CU13
DatabaseName          : MicrosoftDynamicsAX
ModelstoreDatabase    : MicrosoftDynamicsAX_model
AosPort               : 2712
WsdlPort              : 8101
NetTcpPort            : 8201
RegistryKeyPath       : HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Dynamics Server\6.0\01
InstanceNumber        : 01
ComputerName          : GJ-AX2012CU13


SERVERID	ISDEFAULTREPORTMODELSERVER	SERVERURL	ISDEFAULTREPORTLIBRARYSERVER	AXAPTAREPORTFOLDER	DESCRIPTION	DATASOURCENAME	REPORTMANAGERURL	SERVERINSTANCE	AOSID	CONFIGURATIONID	ISSHAREPOINTINTEGRATED	RECVERSION	RECID
ESADM01	0	http://esadm01:81/ReportServer	1	DynamicsAX			http://esadm01:81/Reports	MSSQLSERVER	01@ESADM01	SSRS_LIVE	0	546259976	5637145176

#>