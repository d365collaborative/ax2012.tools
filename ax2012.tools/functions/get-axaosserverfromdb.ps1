<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER DatabaseServer
Parameter description

.PARAMETER DatabaseName
Parameter description

.PARAMETER SqlUser
Parameter description

.PARAMETER SqlPwd
Parameter description

.PARAMETER TrustedConnection
Parameter description

.EXAMPLE
PS C:\> Get-AxAosServerFromDB

this

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
        [string] $SqlPwd,

        [switch] $TrustedConnection = [switch]::Present
    )

    $UseTrustedConnection = Test-TrustedConnection $PSBoundParameters

    $SqlParams = @{ DatabaseServer = $DatabaseServer; DatabaseName = $DatabaseName;
        SqlUser = $SqlUser; SqlPwd = $SqlPwd
    }

    $SqlCommand = Get-SqlCommand @SqlParams -TrustedConnection $UseTrustedConnection

    $sqlCommand.CommandText = (Get-Content "$script:ModuleRoot\internal\sql\get-aosserversfromdatabase.sql") -join [Environment]::NewLine

    try {
        $sqlCommand.Connection.Open()

        $reader = $sqlCommand.ExecuteReader()

        while ($reader.Read() -eq $true) {
            [PSCustomObject]@{
                ServerName     = "$($reader.GetString($($reader.GetOrdinal("SERVERID"))))"
                IsBatchEnabled = [bool][int]"$($reader.GetInt32($($reader.GetOrdinal("ENABLEBATCH"))))"
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
