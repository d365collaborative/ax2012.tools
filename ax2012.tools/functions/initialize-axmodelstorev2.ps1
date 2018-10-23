
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
        
    .PARAMETER DropSchema
        Parameter description
        
    .PARAMETER CreateSchema
        Parameter description
        
    .PARAMETER CreateDb
        Parameter description
        
    .PARAMETER GenerateScript
        Parameter description
        
    .EXAMPLE
        An example
        
    .NOTES
        General notes
#>
function Initialize-AXModelStoreV2 {
    [CmdletBinding(DefaultParameterSetName = "CreateSchema")]
    param (
        [string] $DatabaseServer = "localhost",

        [string] $ModelstoreDatabase = "MicrosoftDynamicsAx_model",

        [Parameter(ParameterSetName = "Drop")]
        [Parameter(ParameterSetName = "CreateSchema")]
        [string] $SchemaName = "TempSchema",

        [Parameter(ParameterSetName = "Drop")]
        [switch] $DropSchema,

        [Parameter(ParameterSetName = "CreateSchema")]
        [switch] $CreateSchema,

        [Parameter(ParameterSetName = "CreateDB")]
        [switch] $CreateDb,
        
        [switch] $GenerateScript
    )

    Invoke-TimeSignal -Start
    
    if (-not (Test-PathExists -Path $Script:AxPowerShellModule -Type Leaf)) { return }

    $null = Import-Module $Script:AxPowerShellModule

    $params = @{
        Server   = $DatabaseServer
        Database = $ModelstoreDatabase        
    }

    if ($PSCmdlet.ParameterSetName -eq "CreateSchema") {
        $params.SchemaName = $SchemaName
    }
    elseif ($PSCmdlet.ParameterSetName -eq "Drop") {
        $params.Drop = $SchemaName
    }
    elseif ($PSCmdlet.ParameterSetName -eq "CreateDB") {
        $params.CreateDB = $true
    }

    if ($GenerateScript) {
        $arguments = Convert-HashToArgString -InputObject $params

        "Initialize-AXModelStore $($arguments -join ' ')"
    }
    else {
        Write-PSFMessage -Level Verbose -Message "Starting the initialization of the model store"
        
        Initialize-AXModelStore @params
    }

    Invoke-TimeSignal -End
}