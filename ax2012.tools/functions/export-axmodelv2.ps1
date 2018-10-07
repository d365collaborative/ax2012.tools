<#
.SYNOPSIS
Export AX 2012 model

.DESCRIPTION
Export AX 2012 model from the AX 2012 model store

.PARAMETER DatabaseServer
Server name of the database server

Default value is: "localhost"

.PARAMETER ModelstoreDatabase
Name of the modelstore database

Default value is: "MicrosoftDynamicsAx_model"

Note: From AX 2012 R2 and upwards you need to provide the full name for the modelstore database. E.g. "AX2012R3_PROD_model"

.PARAMETER Path
Path to the location where you want the file to be exported

Default value is: "c:\temp\ax2012.tools"

.PARAMETER Name
Name of the AX 2012 model that you are looking for

Accepts wildcards for searching. E.g. -Name "ISV*MODULE*"

Default value is "*" which will search for all models

.PARAMETER Id
Id of the AX 2012 model that you are looking for

Accepts wildcards for searching. E.g. -Id "2*"

Default value is "*" which will search for all models

.PARAMETER Layer
Layer where the AX 2012 model that you are looking for should reside

Accepts wildcards for searching. E.g. -Layer "IS*"

Default value is "*" which will search for models in all layers

.PARAMETER GenerateScript
Switch to instruct the cmdlet to output the script to execute the command in hand

.EXAMPLE
PS C:\> Get-AxAosInstance | Export-AxModelV2

This will fetch all the AX 2012 AOS instances that are configured on the machine.
Foreach of the instances it will export all AX 2012 Models into a sub folder to "c:\temp\ax2012.tools".

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
Function Export-AxModelV2 {
    [CmdletBinding()]
    [OutputType([System.String], ParameterSetName="Generate")]
    Param(
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false, ValueFromPipeline = $true, Position = 1)]
        [string] $DatabaseServer = "localhost",

        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false, ValueFromPipeline = $true, Position = 2)]
        [string] $ModelstoreDatabase = "MicrosoftDynamicsAx_model",
        
        [Parameter(Mandatory = $false, Position = 3)]
        [string] $Path = "c:\temp\ax2012.tools",

        [Parameter(Mandatory = $false, Position = 4)]
        [string] $Name = "*",

        [Parameter(Mandatory = $false, Position = 5)]
        [string] $Id = "*",

        [Parameter(Mandatory = $false, Position = 6)]
        [string] $Layer = "*",

        [Parameter(ParameterSetName = "Generate")]
        [switch] $GenerateScript
    )

    BEGIN {
        if (-not ($GenerateScript)) {
            if (-not (Test-PathExists -Path $Path -Type Container -Create)) { return }
            $backupFilePath = New-FolderWithDateTime -Path $Path
        }
        else {
            $backupFilePath = New-FolderWithDateTime -Path $Path -NoCreate
        }


        $null = Import-Module $Script:AxPowerShellModule
    }

    PROCESS {
        Invoke-TimeSignal -Start

        $xml = (Get-AXModel -Server $DatabaseServer -Database $ModelstoreDatabase | ConvertTo-Xml )
        $nodes = $xml.SelectNodes("Objects/Object")

        foreach ($obj in $nodes) {
            $filenameAxModel = ""
            $modelId = ""
            $modelLayer = ""
            $modelName = ""

            # Loop all properties
            foreach ($property in $obj.SelectNodes("Property")) {
                if ($property.GetAttribute("Name").Equals( "Name" )) {
                    $modelName = $property.InnerText
                }
        
                if ($property.GetAttribute("Name").Equals( "Layer" )) {
                    $modelLayer = $property.InnerText
                }
        
                if ($property.GetAttribute("Name").Equals( "ModelId" )) {
                    $modelId = $property.InnerText
                }
            }
    
            $filenameAxModel = $modelId + "_" + $modelName + ".axmodel"

            Write-PSFMessage -Level Verbose -Message "Testing that ModelName, ModelId and Layer matches the search criteria"
            if ($modelName -NotLike $Name) { continue }
            if ($modelId -NotLike $Id) { continue }
            if ($modelLayer -NotLike $Layer) { continue }

            if ($Script:LayerDictionary.ContainsKey($modelLayer.ToUpper()) -and $filenameAxModel -ne "") {
                $localLayer = $Script:LayerDictionary.Get_Item($modelLayer.ToUpper()) + $modelLayer.ToUpper()
                $tempPath = Join-Path $backupFilePath $localLayer
        
                $filenameAxModel = Join-Path $tempPath $filenameAxModel

                $params = @{Model = $modelName; File = $filenameAxModel;
                    Server = $DatabaseServer; Database = $ModelstoreDatabase
                }

                if ($GenerateScript) {
                    $arguments = Convert-HashToArgString -InputObject $params

                    "Export-AXModel $($arguments -join ' ')"
                }
                else {
                    if (-not (Test-PathExists -Path $tempPath -Type Container -Create)) { return }

                    Write-PSFMessage -Level Verbose -Message "Starting the export of the ax model file"
                    $null = Export-AXModel @params
                }
            }
            else {
                Write-PSFMessage -Level Verbose -Message "Skipping $filenameAxModel in layer $modelLayer"
            }
        }

        Invoke-TimeSignal -End
    }

    END {
        if (-not ($GenerateScript)) {
            [PSCustomObject]@{
                Path = $backupFilePath
            }
        }
    }
}
