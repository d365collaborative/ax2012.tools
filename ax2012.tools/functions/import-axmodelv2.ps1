
<#
    .SYNOPSIS
        Import AX 2012 model
        
    .DESCRIPTION
        Import AX 2012 model into the AX 2012 Model store
        
    .PARAMETER DatabaseServer
        Server name of the database server
        
        Default value is: "localhost"
        
    .PARAMETER ModelstoreDatabase
        Name of the modelstore database
        
        Default value is: "MicrosoftDynamicsAx_model"
        
        Note: From AX 2012 R2 and upwards you need to provide the full name for the modelstore database. E.g. "AX2012R3_PROD_model"
        
    .PARAMETER Path
        Path to the folder containing the AX model file(s) that you want to import
        
        The cmdlet will traverse all sub folders for files and import them based on their names
        
    .PARAMETER ConflictMode
        Instructs the cmdlet to handle conflicts
        
        The list of options is:
        "Reject"
        "Push"
        "Overwrite"
        
    .PARAMETER CreateParents
        Switch to instruct the cmdlet to create missing parents on import
        
    .PARAMETER NoOptimize
        Switch to instruct the cmdlet to skip the optimization on import
        
        This makes sense if you are import more than 1-2 AX 2012 models at the same time
        
    .PARAMETER NoPrompt
        Switch to instruct the cmdlet not to prompt you with anything
        
    .PARAMETER OutputCommandOnly
        Switch to instruct the cmdlet to output a script that you can execute manually later
        
        Using this will not import any AX 2012 models into the model store
        
    .EXAMPLE
        PS C:\> Import-AxModelV2 -Path "c:\temp\ax2012.tools\dev-models"
        
        The cmdlet will look for all the AX 2012 models located in "c:\temp\ax2012.tools\dev-models" or any of its sub folders.
        The ConflictMode is set to the default value of "OverWrite".
        The Database Server is set to the default value of "localhost".
        The Modelstore Database is set to the default value of "MicrosoftDynamicsAx_model".
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
Function Import-AxModelV2 {
    [CmdletBinding()]
    [OutputType([System.String], ParameterSetName="Generate")]
    Param(
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false, ValueFromPipeline = $true)]
        [string] $DatabaseServer = $Script:ActiveAosDatabaseserver,

        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false, ValueFromPipeline = $true)]
        [string] $ModelstoreDatabase = $Script:ActiveAosModelstoredatabase,
        
        [Parameter(Mandatory = $false)]
        [string] $Path = $Script:DefaultTempPath,

        [Parameter(Mandatory = $false)]
        [ValidateSet("Reject", "Push", "Overwrite")]
        [string] $ConflictMode = "Overwrite",
        
        [switch] $CreateParents,
        
        [switch] $NoOptimize,

        [switch] $NoPrompt,

        [Parameter(ParameterSetName = "Generate")]
        [switch] $OutputCommandOnly
    )

    BEGIN {
        $null = Import-Module $Script:AxPowerShellModule

        if (-not (Test-PathExists -Path $Path -Type Container)) { return }
    }

    PROCESS {
        if (Test-PSFFunctionInterrupt) { return }

        Invoke-TimeSignal -Start

        $AxModelsPath = (Get-ChildItem -Path $Path | Where-Object {$_.PSIsContainer} | Sort-Object CreationTime -Descending | Select-Object -First 1 | Select-Object Fullname).FullName
        Write-PSFMessage -Level Verbose -Message "The newest / latest folder is: $AxModelsPath" -Target $AxModelsPath

        $AxModelFiles = Get-ChildItem -Path $AxModelsPath -Recurse -File
        
        $params = @{ Server = $DatabaseServer; Conflict = $ConflictMode;
            Database = $ModelstoreDatabase
        }
        
        $paramsSwitch = Get-HashtableKey -InputObject $PSBoundParameters -Keys @("CreateParents", "NoOptimize", "NoPrompt")

        foreach ($item in $AxModelFiles) {
            Write-PSFMessage -Level Verbose -Message "Working on file: $($item.FullName)" -Target $item.FullName
            $clonedParams = Get-DeepClone $params
            $clonedParams += @{ File = $item.FullName }

            if ($OutputCommandOnly) {
                $arguments = Convert-HashToArgString -InputObject $clonedParams
                $argumentsSwitch = Convert-HashToArgStringSwitch -InputObject $paramsSwitch
                "Install-AxModel $($arguments -join ' ') $($argumentsSwitch -join ' ')"
            }
            else {
                Install-AXModel @clonedParams @paramsSwitch
            }
        }
        
        Invoke-TimeSignal -End
    }

    END {

        Clear-Ax2012StandardPowershellModule
    }
}