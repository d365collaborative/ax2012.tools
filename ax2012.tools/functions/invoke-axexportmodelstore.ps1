
<#
    .SYNOPSIS
        Export an AX 2012 modelstore file
        
    .DESCRIPTION
        Export an AX 2012 modelstore file from the modelstore database
        
    .PARAMETER DatabaseServer
        Server name of the database server
        
        Default value is: "localhost"
        
    .PARAMETER ModelstoreDatabase
        Name of the modelstore database
        
        Default value is: "MicrosoftDynamicsAx_model"
        
        Note: From AX 2012 R2 and upwards you need to provide the full name for the modelstore database. E.g. "AX2012R3_PROD_model"
        
    .PARAMETER InstanceName
        Name of the instance that you are working against
        
        If not supplied the cmdlet will take the name of the database and use that
        
    .PARAMETER Suffix
        A suffix text value that you want to add to the name of the file while it is exported
        
        The default value is: (Get-Date).ToString("yyyyMMdd")
        
        This will always name you file with the current date
        
    .PARAMETER Path
        Path to the location where you want the file to be exported
        
        Default value is: "c:\temp\ax2012.tools"
        
    .PARAMETER GenerateScript
        Switch to instruct the cmdlet to only generate the needed command and not execute it
        
    .EXAMPLE
        PS C:\> Invoke-AxExportModelstore
        
        This will execute the cmdlet with all the default values.
        This will work against the SQL server that is on localhost.
        The database is expected to be "MicrosoftDynamicsAx_model".
        The path where the exported modelstore file will be saved is: "c:\temp\ax2012.tools".
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
Function Invoke-AxExportModelstore {
    [CmdletBinding()]
    [OutputType('System.String')]
    Param(
        [string] $DatabaseServer = $Script:ActiveAosDatabaseserver,

        [string] $ModelstoreDatabase = $Script:ActiveAosModelstoredatabase,

        [string] $InstanceName,

        [string] $Suffix = $((Get-Date).ToString("yyyyMMdd")),
        
        [string] $Path = $Script:DefaultTempPath,

        [switch] $GenerateScript
    )

    Invoke-TimeSignal -Start

    if (-not (Test-PathExists -Path $Path -Type Container -Create)) { return }

    if (-not (Test-PathExists -Path $Script:AxPowerShellModule -Type Leaf)) { return }

    $null = Import-Module $Script:AxPowerShellModule
        
    if ([System.String]::IsNullOrEmpty($InstanceName)) {
        $InstanceName = "{0}" -f $ModelstoreDatabase.Replace("_model", "")
    }

    if (-not ([system.string]::IsNullOrEmpty($Suffix))) {
        $ExportPath = Join-Path $Path "$($InstanceName)_$($Suffix).axmodelstore"
    }
    else {
        $ExportPath = Join-Path $Path "$InstanceName.axmodelstore"
    }

    $params = @{
        Server   = $DatabaseServer
        Database = $ModelstoreDatabase
        File     = $ExportPath
    }

    if ($GenerateScript) {
        $arguments = Convert-HashToArgString -InputObject $params

        "Export-AxModelStore $($arguments -join ' ')"
    }
    else {
        Write-PSFMessage -Level Verbose -Message "Starting the export of the model store"
        
        Export-AxModelStore @params
    }

    Invoke-TimeSignal -End
}