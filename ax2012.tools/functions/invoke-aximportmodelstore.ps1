<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER DatabaseServer
Parameter description

.PARAMETER ModelstoreDatabase
Parameter description

.PARAMETER SchemaName
Parameter description

.PARAMETER Path
Parameter description

.PARAMETER IdConflictMode
Parameter description

.PARAMETER Apply
Parameter description

.PARAMETER GenerateScript
Parameter description

.EXAMPLE
An example

.NOTES
General notes
#>
function Invoke-AxImportModelstore {
    [CmdletBinding(DefaultParameterSetName = "ImportModelstore")]
    [OutputType([System.String], ParameterSetName = "Generate")]
    Param(
        [string] $DatabaseServer = "localhost",

        [string] $ModelstoreDatabase = "MicrosoftDynamicsAx_model",

        [Parameter(ParameterSetName = "ImportModelstore")]
        [Parameter(ParameterSetName = "ApplyModelstore")]
        [string] $SchemaName = "TempSchema",

        [Parameter(ParameterSetName = "ImportModelstore")]
        [string] $Path = "c:\temp\ax2012.tools\MicrosoftDynamicsAx.axmodelstore",

        [ValidateSet("Reject", "Push", "Overwrite")]
        [Parameter(ParameterSetName = "ImportModelstore")]
        [string] $IdConflictMode,
        
        [Parameter(ParameterSetName = "ApplyModelstore")]
        [switch] $Apply,

        [switch] $GenerateScript
    )

    Invoke-TimeSignal -Start

    if (-not (Test-PathExists -Path $Path -Type Container -Create)) { return }

    if (-not (Test-PathExists -Path $Script:AxPowerShellModule -Type Leaf)) { return }

    $null = Import-Module $Script:AxPowerShellModule

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

    if ($GenerateScript) {
        $arguments = Convert-HashToArgString -InputObject $params

        "Import-AxModelStore $($arguments -join ' ')"
    }
    else {
        Write-PSFMessage -Level Verbose -Message "Starting the export of the model store"
        
        Import-AXModelStore @params
    }

    Invoke-TimeSignal -End
}