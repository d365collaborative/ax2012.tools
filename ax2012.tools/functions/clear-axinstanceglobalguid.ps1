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