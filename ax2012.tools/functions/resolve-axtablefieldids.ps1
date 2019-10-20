
<#
    .SYNOPSIS
        Fix table and field ID conflicts
        
    .DESCRIPTION
        Fixes both table and field IDs in the AX SqlDictionary (data db) to match the AX code (Model db)
        
        Useful for after a database has been restored and the table or field IDs do not match
        Run this command instead of letting the database synchronization process drop and recreate the table
        
        Before running:
        Stop the AOS
        Always take the appropriate SQL backups before running this script
        
        After running:
        Start the AOS
        Sync the database within AX
        
        Note:
        Objects that are new in AOT will get created in SQL dictionary when synchronization happens
        
    .PARAMETER DatabaseServer
        Server name of the database server
        
        Default value is: "localhost"
        
    .PARAMETER DatabaseName
        Name of the database
        
        Default value is: "MicrosoftDynamicsAx"
        
    .PARAMETER ModelstoreDatabase
        Name of the modelstore database
        
        Default value is: "MicrosoftDynamicsAx_model"
        
    .PARAMETER SqlUser
        User name of the SQL Server credential that you want to use when working against the database
        
    .PARAMETER SqlPwd
        Password of the SQL Server credential that you want to use when working against the database
        
    .PARAMETER Force
        Instruct the cmdlet to overwrite any existing bak (backup) tables from previous executions
        
    .PARAMETER OutputCommandOnly
        When provided the SQL is returned and not executed
        
        Note: This is useful for troubleshooting or providing the script to a DBA with access to the server
        
    .EXAMPLE
        PS C:\> Resolve-AxTableFieldIDs
        
        This will execute the cmdlet with all the default values.
        This will work against the SQL server that is on localhost.
        The database is expected to be "MicrosoftDynamicsAx_model".
        
    .NOTES
        Author: Dag Calafell, III (@dodiggitydag)
        Reference: http://calafell.me/the-ultimate-ax-2012-table-and-field-id-fix-for-synchronization-errors/
#>
Function Resolve-AxTableFieldIDs {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    [CmdletBinding()]
    [OutputType('System.String')]
    Param(
        [string] $DatabaseServer = $Script:ActiveAosDatabaseserver,

        [string] $DatabaseName = $Script:ActiveAosDatabase,

        [string] $ModelstoreDatabase = $Script:ActiveAosModelstoredatabase,

        [string] $SqlUser,

        [string] $SqlPwd,

        [Switch] $Force,

        [Switch] $OutputCommandOnly
    )

    Invoke-TimeSignal -Start

    $baseParams = Get-DeepClone $PSBoundParameters
    $baseParams.Add("TrustedConnection", $true)

    $UseTrustedConnection = Test-TrustedConnection $baseParams

    $SqlParams = @{ DatabaseServer = $DatabaseServer; DatabaseName = $DatabaseName;
        SqlUser = $SqlUser; SqlPwd = $SqlPwd
    }

    $forceParameterValue = "0"

    if ($Force) { $forceParameterValue = "1" }

    $sqlCommand = Get-SqlCommand @SqlParams -TrustedConnection $UseTrustedConnection

    $commandText = (Get-Content "$script:ModuleRoot\internal\sql\resolve-sqldictionaryids.sql") -join [Environment]::NewLine
    
    $sqlCommand.CommandText = $commandText.Replace('@DatabaseName', $DatabaseName).Replace('@ModelDatabaseName', $ModelstoreDatabase).Replace("@ForceValue", $forceParameterValue)

    if ($OutputCommandOnly) {
        (Get-SqlString $sqlCommand)
    }
    else {
        $handler = [System.Data.SqlClient.SqlInfoMessageEventHandler] { param($sender, $event) Write-PSFMessage -Level Host -Message $($event.Message) -Target $($event.Message) }
        $sqlCommand.Connection.add_InfoMessage($handler)
        $sqlCommand.Connection.FireInfoMessageEventOnUserErrors = $true;

        try {
            Write-PSFMessage -Level InternalComment -Message "Executing a script against the database." -Target (Get-SqlString $sqlCommand)
            
            $sqlCommand.Connection.Open()
            $sqlCommand.ExecuteNonQuery()

            Write-PSFMessage -Level Verbose -Message "SQL query executed."
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

    Invoke-TimeSignal -End
}