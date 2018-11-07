
<#
    .SYNOPSIS
        Get AOS server details from the SQL Server database
        
    .DESCRIPTION
        Traverse the SysServerConfig table from the AX 2012 database and get all registered AOS Servers
        
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
        PS C:\> Get-AxAosServerFromDB
        
        This will query the "MicrosoftDynamicsAx" hosted on the localhost server.
        It will extract all AOS Servers from the SysServerConfig table.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxAosServerFromDB {
    [CmdletBinding()]
    #[OutputType()]
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

    Invoke-TimeSignal -Start

    $baseParams = Get-DeepClone $PSBoundParameters
    $baseParams.Add("TrustedConnection", $true)

    $UseTrustedConnection = Test-TrustedConnection $baseParams

    $SqlParams = @{ DatabaseServer = $DatabaseServer; DatabaseName = $DatabaseName;
        SqlUser = $SqlUser; SqlPwd = $SqlPwd
    }

    $sqlCommand = Get-SqlCommand @SqlParams -TrustedConnection $UseTrustedConnection

    $sqlCommand.CommandText = (Get-Content "$script:ModuleRoot\internal\sql\get-aosserversfromdatabase.sql") -join [Environment]::NewLine

    try {
        Write-PSFMessage -Level InternalComment -Message "Executing a script against the database." -Target (Get-SqlString $sqlCommand)

        $sqlCommand.Connection.Open()

        $reader = $sqlCommand.ExecuteReader()

        while ($reader.Read() -eq $true) {
            $rawServer = "$($reader.GetString($($reader.GetOrdinal("SERVERID"))))"
            
            [PSCustomObject]@{
                RawServerName  = $rawServer
                InstanceNumber = $rawServer.ToString().Split("@")[0]
                ServerName     = $rawServer.ToString().Split("@")[1]
                IsBatchEnabled = [bool][int]"$($reader.GetInt32($($reader.GetOrdinal("IsBatch"))))"
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

    Invoke-TimeSignal -End
}