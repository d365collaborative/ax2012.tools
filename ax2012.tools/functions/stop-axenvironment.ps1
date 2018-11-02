
<#
    .SYNOPSIS
        Stop an AX 2012 environment
        
    .DESCRIPTION
        Stop an AX 2012 services in your environment
        
    .PARAMETER ComputerName
        Name of the computer(s) that you want to work against
        
    .PARAMETER All
        Switch to instruct the cmdlet to include all known AX 2012 services
        
    .PARAMETER Aos
        Switch to instruct the cmdlet to include the AOS service
        
    .PARAMETER ManagementReporter
        Switch to instruct the cmdlet to include the ManagementReporter service
        
    .PARAMETER DIXF
        Switch to instruct the cmdlet to include the DIXF service
        
    .EXAMPLE
        PS C:\> Stop-AxEnvironment
        
        This will stop all the known AX 2012 services on the machine that you are executing it on.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Stop-AxEnvironmentV2 {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [CmdletBinding()]
    param (

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('Server')]
        [string[]] $ComputerName = $Script:ActiveAosComputername,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string] $DisplayName,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string] $Status = "*",

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string] $Name,

        [switch] $ShowOutput
    )

    begin {
        $includeStatuses = @("Running", "StartPending")

        $output = New-Object System.Collections.ArrayList
    }

    process {

        if ($includeStatuses -like $Status) {
            Get-Service -ComputerName $ComputerName -Name $Name -ErrorAction SilentlyContinue | Stop-Service -Force -ErrorAction SilentlyContinue
        }

        if ($ShowOutput) {
            $service = Get-Service -ComputerName $server -Name $Services -ErrorAction SilentlyContinue | Select-Object @{Name = "Server"; Expression = {$Server}}, Name, Status, DisplayName
            $null = $output.Add($service)
        }
    }

    end {
        if ($ShowOutput) {
            $res.ToArray() | Select-Object Server, DisplayName, Status, Name
        }
    }
}