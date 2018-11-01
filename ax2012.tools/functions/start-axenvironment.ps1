
<#
    .SYNOPSIS
        Start an AX 2012 environment
        
    .DESCRIPTION
        Start an AX 2012 services in your environment
        
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
        PS C:\> Start-AxEnvironment
        
        This will start all the known AX 2012 services on the machine that you are executing it on.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Start-AxEnvironment {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [string[]] $ComputerName = $Script:ActiveAosComputername,

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
    if ($Params.ContainsKey("ComputerName")) { $Params.Remove("ComputerName") }

    $Services = Get-ServiceList @Params
    
    $Results = foreach ($server in $ComputerName) {
        Write-PSFMessage -Level Verbose -Message "Working against: $server - starting services" -Target $server
        Get-Service -ComputerName $server -Name $Services -ErrorAction SilentlyContinue | Start-Service -ErrorAction SilentlyContinue
    }

    $Results = foreach ($server in $ComputerName) {
        Write-PSFMessage -Level Verbose -Message "Working against: $server - listing services" -Target $server
        Get-Service -ComputerName $server -Name $Services -ErrorAction SilentlyContinue | Select-Object @{Name = "Server"; Expression = {$Server}}, Name, Status, DisplayName
    }
    

    $Results | Select-Object Server, DisplayName, Status, Name
}