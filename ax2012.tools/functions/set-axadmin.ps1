function Set-AxAdmin {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding()]
    [OutputType([System.String], ParameterSetName = "Generate")]
    param (
        
        [Parameter(Mandatory = $true)]
        [string] $Username,

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

    $userInfo = Get-DomainUserDetails -Username $Username

    $baseParams = Get-DeepClone $PSBoundParameters
    $baseParams.Add("TrustedConnection", $true)

    $UseTrustedConnection = Test-TrustedConnection $baseParams

    $SqlParams = @{ DatabaseServer = $DatabaseServer; DatabaseName = $DatabaseName;
        SqlUser = $SqlUser; SqlPwd = $SqlPwd
    }

    $sqlCommand = Get-SqlCommand @SqlParams -TrustedConnection $UseTrustedConnection

    $sqlCommand.CommandText = (Get-Content "$script:ModuleRoot\internal\sql\set-axadmin.sql") -join [Environment]::NewLine
    $null = $sqlCommand.Parameters.AddWithValue('@NetworkDomain', $userInfo.Domain)
    $null = $sqlCommand.Parameters.AddWithValue('@NetworkAlias', $userInfo.UserId)
    $null = $sqlCommand.Parameters.AddWithValue('@SID', $userInfo.Sid)

    # UPDATE [dbo].[USERINFO] SET [NETWORKDOMAIN] = @NetworkDomain, [NETWORKALIAS] = @NetworkAlias, [SID] = @SID WHERE [ID] = 'Admin'

    if ($OutputCommandOnly) {
        (Get-SqlString $sqlCommand)
    }
    else {
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