
<#
    .SYNOPSIS
        Import an AX 2012 modelstore file
        
    .DESCRIPTION
        Import an AX 2012 modelstore file into the modelstore database
        
    .PARAMETER DatabaseServer
        Server name of the database server
        
        Default value is: "localhost"
        
    .PARAMETER ModelstoreDatabase
        Name of the modelstore database
        
        Default value is: "MicrosoftDynamicsAx_model"
        
        Note: From AX 2012 R2 and upwards you need to provide the full name for the modelstore database. E.g. "AX2012R3_PROD_model"
        
    .PARAMETER SchemaName
        Name of the schema to import the modelstore into
        
        Default value is: "TempSchema"
        
    .PARAMETER Path
        Path to the location where you want the file to be exported
        
        Default value is: "c:\temp\ax2012.tools"
        
    .PARAMETER IdConflictMode
        Parameter to instruct how the import should handle ID conflicts if it hits any during the import
        
        Valid options:
        "Reject"
        "Push"
        "Overwrite"
        
    .PARAMETER Apply
        Instruct the cmdlet to switch modelstore with the SchemaName in as the current code
        
    .PARAMETER ShowOriginalProgress
        Instruct the cmdlet to show the standard output in the console
        
        Default is $false which will silence the standard output
        
    .PARAMETER OutputCommandOnly
        Instruct the cmdlet to only generate the needed command and not execute it
        
    .EXAMPLE
        PS C:\> Import-AXModelStoreV2 -SchemaName TempSchema -Path C:\Temp\ax2012.tools\MicrosoftDynamicsAx.axmodelstore
        
        This will execute the cmdlet with some of the default values.
        This will work against the SQL server that is on localhost.
        The database is expected to be "MicrosoftDynamicsAx_model".
        The import will import the modelstore into the "TempSchema".
        The path where the modelstore file you want to import must exists is: "c:\temp\ax2012.tools\MicrosoftDynamicsAx.axmodelstore".
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Import-AXModelStoreV2 {
    [CmdletBinding(DefaultParameterSetName = "ImportModelstore")]
    [OutputType([System.String], ParameterSetName = "Generate")]
    Param(
        [string] $DatabaseServer = $Script:ActiveAosDatabaseserver,

        [string] $ModelstoreDatabase = $Script:ActiveAosModelstoredatabase,

        [Parameter(ParameterSetName = "ImportModelstore")]
        [Parameter(ParameterSetName = "ApplyModelstore")]
        [string] $SchemaName = "TempSchema",

        [Parameter(ParameterSetName = "ImportModelstore")]
        [string] $Path = (Join-Path $Script:DefaultTempPath "MicrosoftDynamicsAx.axmodelstore"),

        [ValidateSet("Reject", "Push", "Overwrite")]
        [Parameter(ParameterSetName = "ImportModelstore")]
        [string] $IdConflictMode,
        
        [Parameter(ParameterSetName = "ApplyModelstore")]
        [switch] $Apply,

        [switch] $ShowOriginalProgress,

        [Parameter(ParameterSetName = "Generate")]
        [switch] $OutputCommandOnly
    )

    Invoke-TimeSignal -Start

    if (-not (Test-PathExists -Path $Path -Type Container -Create)) { return }

    if (-not (Test-PathExists -Path $Script:AxPowerShellModule -Type Leaf)) { return }

    $params = @{
        Server   = $DatabaseServer
        Database = $ModelstoreDatabase
    }

    if ($PSCmdlet.ParameterSetName -eq "ImportModelstore") {
        $params.File = $Path
        $params.SchemaName = $SchemaName

        if ($PSBoundParameters.ContainsKey("IdConflictMode")) {
            $params.IdConflict = $IdConflictMode
        }
    }
    elseif ($PSCmdlet.ParameterSetName -eq "ApplyModelstore") {
        $params.Apply = $SchemaName
    }

    if ($OutputCommandOnly) {
        $arguments = Convert-HashToArgString -InputObject $params

        "Import-AxModelStore $($arguments -join ' ')"
    }
    else {
        Write-PSFMessage -Level Verbose -Message "Starting the export of the model store"
      
        $null = Import-Module $Script:AxPowerShellModule

        $outputRes = Import-AXModelStore @params

        if ($ShowOriginalProgress) {
            $outputRes
        }

        Clear-Ax2012StandardPowershellModule
    }

    Invoke-TimeSignal -End
}