<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER DatabaseServer
Parameter description

.PARAMETER ModelstoreDatabase
Parameter description

.PARAMETER Path
Parameter description

.PARAMETER ConflictMode
Parameter description

.PARAMETER CreateParents
Parameter description

.PARAMETER NoOptimize
Parameter description

.PARAMETER NoPrompt
Parameter description

.PARAMETER GenerateScript
Parameter description

.EXAMPLE
An example

.NOTES
General notes
#>
Function Import-AxModelV2 {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false, ValueFromPipeline = $true, Position = 1)]
        [string] $DatabaseServer = "localhost",

        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false, ValueFromPipeline = $true, Position = 2)]
        [string] $ModelstoreDatabase = "MicrosoftDynamicsAx_model",
        
        [Parameter(Mandatory = $false, Position = 3)]
        [string] $Path = "c:\temp\ax2012.tools",

        [Parameter(Mandatory = $false, Position = 4)]
        [ValidateSet("Reject", "Push", "Overwrite")]
        [string] $ConflictMode = "Overwrite",
        
        [switch] $CreateParents,
        
        [switch] $NoOptimize,

        [switch] $NoPrompt,

        [switch] $GenerateScript
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
        
        $res = New-Object System.Collections.ArrayList

        $params = @{ Server = $DatabaseServer; Conflict = $ConflictMode;
            Database = $ModelstoreDatabase
        }
        
        $paramsSwitch = Get-HashtableKey -InputObject $PSBoundParameters -Keys @("CreateParents", "NoOptimize", "NoPrompt")

        foreach ($item in $AxModelFiles) {
            Write-PSFMessage -Level Verbose -Message "Working on file: $($item.FullName)" -Target $item.FullName
            $clonedParams = Get-DeepClone $params
            $clonedParams += @{ File = $item.FullName }

            if ($GenerateScript) {
                $arguments = Convert-HashToArgString -InputObject $clonedParams
                $argumentsSwitch = Convert-HashToArgStringSwitch -InputObject $paramsSwitch
                "Install-AxModel $($arguments -join ' ') $($argumentsSwitch -join ' ')"
            }
            else {
                #Install-AXModel @clonedParams @paramsSwitch
            }
        }
        
        Invoke-TimeSignal -End
    }

    END { }
}
