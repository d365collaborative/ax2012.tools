
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
        
    .PARAMETER OutputPath
        Path to the log file you want AxBuild.exe to output to
        
        Default location is: "c:\temp\ax2012.tools\AxBuild\"

    .PARAMETER ShowOriginalProgress
        Instruct the cmdlet to show the standard output in the console
        
        Default is $false which will silence the standard output
        
    .PARAMETER OutputCommandOnly
        Instruct the cmdlet to output a script that you can execute manually later
        
        Using this will not import any AX 2012 models into the model store

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
    [OutputType([System.String], ParameterSetName = "Generate")]
    param (

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('Path')]
        [string] $BinDirectory = $Script:ActiveAosBindirectory,

        [Alias('AltBin')]
        [string] $AlternativeBinPath = $Script:ClientBin,
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('Aos')]
        [string] $InstanceNumber = $Script:ActiveAosInstanceNumber,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('DBServer')]
        [string] $DatabaseServer = $Script:ActiveAosDatabaseserver,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('Modelstore')]
        [string] $ModelstoreDatabase = $Script:ActiveAosModelstoredatabase,

        [int] $Workers,

        [string] $OutputPath = $(Join-Path $Script:DefaultTempPath "AxBuildLog"),

        [switch] $ShowOriginalProgress,

        [Parameter(ParameterSetName = "Generate")]
        [switch] $OutputCommandOnly
    )

    begin {
        $executable = Join-Path $BinDirectory "AXBuild.exe"
        $compiler = Join-Path $BinDirectory "ax32serv.exe"

        if (-not (Test-PathExists -Path $OutputPath -Type Container -Create)) { return }
        if (-not (Test-PathExists -Path $executable, $compiler -Type Leaf)) { return }
    }
    process {
        if (Test-PSFFunctionInterrupt) { return }

        Invoke-TimeSignal -Start

        $params = New-Object System.Collections.Generic.List[string]

        $params.Add("xppcompileall")
        $params.Add("/altbin=`"$AlternativeBinPath`"")
        $params.Add("/aos=$InstanceNumber")
        $params.Add("/dbserver=`"$DatabaseServer`"")
        $params.Add("/modelstore=`"$ModelstoreDatabase`"")
        $params.Add("/log=`"$OutputPath`"")
        $params.Add("/compiler=`"$compiler`"")

        if ((-not ($null -eq $Workers)) -and ($Workers -gt 0)) {
            $params.Add("/workers=$Workers")
        }

        Write-PSFMessage -Level Verbose -Message "Starting $executable with $($params -join " ")" -Target ($params -join " ")

        Invoke-Process -Executable $executable -Params $($params.ToArray()) -ShowOriginalProgress:$ShowOriginalProgress -OutputCommandOnly:$OutputCommandOnly

        Invoke-TimeSignal -End

    }
}