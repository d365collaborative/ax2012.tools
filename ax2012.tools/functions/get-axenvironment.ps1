<#
.SYNOPSIS
Get the status of an AX 2012 environment

.DESCRIPTION
Get the status of AX 2012 services in your environment

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
Get-AxEnvironment

This will get the status for all the default services from your environment.

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
function Get-AxEnvironment {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [string[]] $ComputerName = @($env:computername),

        [Parameter(Mandatory = $false, ParameterSetName = 'Default', Position = 2 )]
        [switch] $All = [switch]::Present,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 2 )]
        [switch] $Aos,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 3 )]
        [switch] $ManagementReporter,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 4 )]
        [switch] $DIXF
    )

    if ($PSCmdlet.ParameterSetName -eq "Specific") {
        $All = ![switch]::Present
    }

    if (!$All -and !$Aos -and !$ManagementReporter -and !$DIXF) {
        Write-PSFMessage -Level Host -Message "You have to use at least one switch when running this cmdlet. Please run the cmdlet again."
        Stop-PSFFunction -Message "Stopping because of missing parameters"
        return
    }

    $Params = Get-DeepClone $PSBoundParameters
    if($Params.ContainsKey("ComputerName")){ $Params.Remove("ComputerName") }

    $Services = Get-ServiceList @Params

    Write-PSFMessage -Level Verbose -Message "Scanning the environment for services."
    
    $Results = foreach ($server in $ComputerName) {
        Get-Service -ComputerName $server -Name $Services -ErrorAction SilentlyContinue | Select-Object @{Name = "Server"; Expression = {$Server}}, Name, Status, DisplayName
    }
    
    $Results | Select-Object Server, DisplayName, Status, Name
}
