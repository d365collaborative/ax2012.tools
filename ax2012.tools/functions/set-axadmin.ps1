<#
.SYNOPSIS
Set the admin account inside the AX 2012 database

.DESCRIPTION
Set the user account details (credentails) that will be the considered as the admin account in the AX 2012 database

.PARAMETER Username
Username of the user that you want to be the new admin in the database

Must include domain details, either in PRE-2000 or UPN style

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

    .PARAMETER OutputCommandOnly
        Instruct the cmdlet to only generate the needed command and not execute it

.EXAMPLE
PS C:\> Set-AxAdmin -Username "ACME.local\test"

This will update the admin record in the AX 2012 database to "ACME.local\test".

.NOTES
Tags:

Author: Mötz Jensen (@Splaxi)
#>

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