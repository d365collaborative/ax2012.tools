
<#
    .SYNOPSIS
        Clear the Global Guid id from the AX 2012 database
        
    .DESCRIPTION
        Reset the Global Guid located in the SysSqmSettings table
        
        This guid (id) is used by the client to identify cache objects, so resetting this can be useful when troubleshooting
        
    .PARAMETER DatabaseServer
        Server name of the database server
        
        Default value is: "localhost"
        
    .PARAMETER ModelstoreDatabase
        Name of the modelstore database
        
        Default value is: "MicrosoftDynamicsAx_model"
        
        Note: From AX 2012 R2 and upwards you need to provide the full name for the modelstore database. E.g. "AX2012R3_PROD_model"
        
    .PARAMETER SqlUser
        User name of the SQL Server credential that you want to use when working against the database
        
    .PARAMETER SqlPwd
        Password of the SQL Server credential that you want to use when working against the database
        
    .PARAMETER OutputCommandOnly
        Instruct the cmdlet to only generate the needed command and not execute it
        
    .EXAMPLE
        PS C:\> Clear-AxInstanceGlobalGuid
        
        This will clear the current global guid in the AX 2012 database.
        
    .NOTES
        Tags:
        
        Author: Mötz Jensen (@Splaxi)
        
#>

function Clear-AxInstanceGlobalGuid {
    [CmdletBinding()]
    [OutputType([System.String], ParameterSetName = "Generate")]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string] $DatabaseServer = $Script:ActiveAosDatabaseserver,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string] $DatabaseName = $Script:ActiveAosDatabase,

        [string] $SqlUser,

        [string] $SqlPwd,

        [Parameter(ParameterSetName = "Generate")]
        [Switch] $OutputCommandOnly
    )

    Invoke-TimeSignal -Start

    $baseParams = Get-DeepClone $PSBoundParameters
    $baseParams.Add("TrustedConnection", $true)

    $UseTrustedConnection = Test-TrustedConnection $baseParams

    $SqlParams = @{ DatabaseServer = $DatabaseServer; DatabaseName = $DatabaseName;
        SqlUser = $SqlUser; SqlPwd = $SqlPwd
    }

    $sqlCommand = Get-SqlCommand @SqlParams -TrustedConnection $UseTrustedConnection

    $sqlCommand.CommandText = (Get-Content "$script:ModuleRoot\internal\sql\clear-axinstanceglobalguid.sql") -join [Environment]::NewLine

    if ($OutputCommandOnly) {
        (Get-SqlString $sqlCommand)
    }
    else {
        try {
            Write-PSFMessage -Level InternalComment -Message "Executing a script against the database." -Target (Get-SqlString $sqlCommand)

            $sqlCommand.Connection.Open()
            $res = $sqlCommand.ExecuteNonQuery()

            Write-PSFMessage -Level Verbose -Message "SQL query executed." -Target $res
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