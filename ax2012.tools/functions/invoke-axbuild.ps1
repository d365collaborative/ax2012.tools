<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER BinDirectory
Parameter description

.PARAMETER AlternativeBinPath
Parameter description

.PARAMETER InstanceNumber
Parameter description

.PARAMETER DatabaseServer
Parameter description

.PARAMETER ModelstoreDatabase
Parameter description

.PARAMETER Workers
Parameter description

.PARAMETER Log
Parameter description

.EXAMPLE
PS C:\> Get-AxAosInstance | Invoke-AxBuild

.NOTES
Author: Mötz Jensen (@Splaxi)
#>
function Invoke-AxBuild {
    [CmdletBinding()]
    param (

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 1)]
        [Alias('Path')]
        [string] $BinDirectory = $Script:ActiveAosBindirectory,

        [Alias('AltBin')]
        [string] $AlternativeBinPath = $Script:ClientBin,
        
        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 3)]
        [Alias('Aos')]
        [string] $InstanceNumber = $Script:ActiveAosInstanceNumber,

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 4)]
        [Alias('DBServer')]
        [string] $DatabaseServer = $Script:ActiveAosDatabaseserver,

        [Parameter(ValueFromPipelineByPropertyName = $true, Position = 5)]
        [Alias('Modelstore')]
        [string] $ModelstoreDatabase = $Script:ActiveAosModelstoredatabase,

        [int] $Workers,

        [string] $Log = $(Join-Path $Script:DefaultTempPath "AxBuildLog.txt")
    )

    begin {
        $executable = Join-Path $BinDirectory "AXBuild.exe"
        $compiler = Join-Path $BinDirectory "ax32serv.exe"

        if (-not (Test-PathExists -Path (Split-Path -Path $Log -Parent) -Type Container -Create)) { return }
        if (-not (Test-PathExists -Path $executable, $compiler -Type Leaf)) { return }
    }
    process {
        if (Test-PSFFunctionInterrupt) { return }

        $params = New-Object System.Collections.ArrayList

        [void]$params.Add("xppcompileall")
        [void]$params.Add("/altbin=`"$AlternativeBinPath`"")
        [void]$params.Add("/aos=$InstanceNumber")
        [void]$params.Add("/dbserver=`"$DatabaseServer`"")
        [void]$params.Add("/modelstore=`"$ModelstoreDatabase`"")
        [void]$params.Add("/log=`"$Log`"")
        [void]$params.Add("/compiler=`"$compiler`"")

        if ((-not ($null -eq $Workers)) -and ($Workers -gt 0)) {
            [void]$params.Add("/workers=$Workers")
        }

        Write-PSFMessage -Level Verbose -Message "Starting $executable with $($params -join " ")" -Target ($params -join " ")

        Start-Process -FilePath $executable -ArgumentList ($params -join " ") -NoNewWindow -Wait
    }
}