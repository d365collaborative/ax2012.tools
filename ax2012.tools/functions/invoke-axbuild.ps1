
<#
    .SYNOPSIS
        Start the AxBuild.exe
        
    .DESCRIPTION
        Invoke the AxBuild.exe with the necessary parameters to make it compile your application
        
    .PARAMETER BinDirectory
        The full path to the bin directory where the AOS instance is physical installed
        
    .PARAMETER AlternativeBinPath
        The full path to the client bin directory where AX 2012 Client is physical installed
        
    .PARAMETER InstanceNumber
        The 2 digit ([0-9][0-9]) number that the AOS instance has on the server
        
    .PARAMETER DatabaseServer
        The name of the server running SQL Server
        
    .PARAMETER ModelstoreDatabase
        The name of the AX 2012 modelstore database
        
    .PARAMETER Workers
        Number of workers that you want to utilize while compiling
        
        The built-in logic from AxBuild.exe will choose a number equal to your visible cores
        Leaving it blank or with 0 (Zero) will use the built-in logic from AxBuild.exe
        
    .PARAMETER Log
        Path to the log file you want AxBuild.exe to output to
        
    .EXAMPLE
        PS C:\> Get-AxAosInstance | Invoke-AxBuild
        
        This will find all AOS instances using the Get-AxAosInstance on the machine and pipe them to Invoke-AxBuild.
        For each AOS instance found it will start the AxBuild.exe against their individual details.
        It will store the log file under the default ax2012.tools folder.
        
    .EXAMPLE
        PS C:\> Invoke-AxBuild
        
        This will start the AxBuild.exe against the ActiveAos configuration.
        It will store the log file under the default ax2012.tools folder.
        
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