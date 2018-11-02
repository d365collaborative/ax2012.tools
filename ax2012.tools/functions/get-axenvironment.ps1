
<#
    .SYNOPSIS
        Get the status of an AX 2012 environment
        
    .DESCRIPTION
        Get the status of AX 2012 services in your environment
        
    .PARAMETER ComputerName
        Name of the computer(s) that you want to work against
        
    .PARAMETER AllAxServices
        Switch to instruct the cmdlet to include all known AX 2012 services
        
    .PARAMETER AosInstanceName
        Name of the AOS instance that you are looking for
        
        Accepts wildcards for searching. E.g. -AosInstanceName "*DEV*"
        
        If AxActiveAosConfiguration has been configured, the default value is the name of the instance registered
        
        Default value is otherwise "*" which will search for all AOS instances
        
    .PARAMETER Aos
        Switch to instruct the cmdlet to include the AOS service
        
    .PARAMETER ManagementReporter
        Switch to instruct the cmdlet to include the ManagementReporter service
        
    .PARAMETER DIXF
        Switch to instruct the cmdlet to include the DIXF service
        
    .PARAMETER ScanAllAosServices
        Parameter description
        
    .PARAMETER PipelineOutput
        asdfsadfsdf
        
    .EXAMPLE
        PS C:\> Get-AxEnvironment
        
        This will get the status for all the default services from your environment.
        If AxActiveAosConfiguration has been configured, it will work against the ComputerName and AosInstanceName registered.

    .EXAMPLE
        PS C:\> Get-AxEnvironment -ScanAllAosServices
        
        This will scan for all available AOS Services.
        If AxActiveAosConfiguration has been configured, it will work against the ComputerName registered otherwise localhost is used.

    .EXAMPLE
        PS C:\> Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos -PipelineOutput

        This will get all AOS instances from the server named "TEST-AOS-01".
        If AxActiveAosConfiguration has been configured, it will work against the AosInstanceName registered otherwise it will find all.

    .EXAMPLE
        PS C:\> Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos -AosInstanceName *DEV*

        This will get all AOS instances that match the search pattern "*DEV*" from the server named "TEST-AOS-01".

    .EXAMPLE
        PS C:\> Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos -PipelineOutput | Start-AxEnvironment -ShowOutput
        
        This will scan the "TEST-AOS-01" server for all AOS instances and start them.
        It will show the status for the service(s) on the server afterwards.
        
    .EXAMPLE
        PS C:\> Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos -PipelineOutput | Stop-AxEnvironment -ShowOutput
        
        This will scan the "TEST-AOS-01" server for all AOS instances and stop them.
        It will show the status for the service(s) on the server afterwards.
                
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxEnvironment {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias('Server')]
        [string[]] $ComputerName = $Script:ActiveAosComputername,

        [Parameter(Mandatory = $false, ParameterSetName = 'Default', Position = 2 )]
        [switch] $AllAxServices = [switch]::Present,
        
        [Alias('InstanceName')]
        [string] $AosInstanceName = $(if (-not ([System.String]::IsNullOrEmpty($Script:ActiveAosInstancename))) { "*$Script:ActiveAosInstancename" } else { "*" }),

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 2 )]
        [switch] $Aos,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 3 )]
        [switch] $ManagementReporter,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 4 )]
        [switch] $DIXF,

        [switch] $ScanAllAosServices,

        [switch] $PipelineOutput
    )

    if ($PSCmdlet.ParameterSetName -eq "Specific") {
        $AllAxServices = ![switch]::Present
    }

    if (!$AllAxServices -and !$Aos -and !$ManagementReporter -and !$DIXF) {
        Write-PSFMessage -Level Host -Message "You have to use at least one switch when running this cmdlet. Please run the cmdlet again."
        Stop-PSFFunction -Message "Stopping because of missing parameters"
        return
    }

    $baseParams = Get-DeepClone $PSBoundParameters

    $params = @{}
    $includeParamNames = @("ManagementReporter", "DIXF")

    foreach ($key in $baseParams.Keys) {
        Write-PSFMessage -Level Verbose -Message "Working on key: $key" -Target $key
        if ($includeParamNames -notlike $key ) {continue}
        
        $null = $params.Add($key, $baseParams.Item($key).ToString())
    }
    
    if ($params.Count -eq 0) {
        if ($AllAxServices) {
            $params.AllAxServices = $true

            $Services = Get-ServiceList @params
        }
    }
    else {
        $Services = Get-ServiceList @params
    }

    if ($PSBoundParameters.ContainsKey("Aos")) {
        Write-PSFMessage -Level Verbose -Message "Aos seems to be bound" -Target $key
        
        $searchServicesAos = Get-ServiceList -Aos
    }

    $res = New-Object System.Collections.ArrayList
    
    foreach ($server in $ComputerName) {
        Write-PSFMessage -Level Verbose -Message "Working against: $server - listing services" -Target ($Services -Join ",")
        Write-PSFMessage -Level Verbose -Message "Working against: $server - listing Aos services" -Target ($searchServicesAos -Join ",")
        
        if (-not ($null -eq $searchServicesAos)) {

            $colAosServices = Get-Service -ComputerName $server -Name $searchServicesAos -ErrorAction SilentlyContinue | Select-Object @{Name = "Server"; Expression = {$Server}}, Name, Status, DisplayName

            foreach ($service in $colAosServices) {
                if ((-not $ScanAllAosServices) -and ($service.DisplayName -NotLike $AosInstanceName)) { continue }

                $null = $res.Add($service)
            }
        }

        if (-not ($null -eq $Services)) {
            $axServices = Get-Service -ComputerName $server -Name $Services -ErrorAction SilentlyContinue | Select-Object @{Name = "Server"; Expression = {$Server}}, Name, Status, DisplayName
    
            foreach ($service in $axServices) {
                if ($service.DisplayName -like "*AX Object Server*" ) {
                    if ((-not $ScanAllAosServices) -and ($service.DisplayName -NotLike $AosInstanceName)) { continue }
                }

                $null = $res.Add($service)
            }
        }
    }
 
    if ($PipelineOutput) {
        $res.ToArray() | Select-Object Server, Name
    }
    else {
        $res.ToArray() | Select-Object Server, DisplayName, Status, Name
    }

    
}