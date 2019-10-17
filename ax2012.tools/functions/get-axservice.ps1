
<#
    .SYNOPSIS
        Get the status of an AX 2012 environment
        
    .DESCRIPTION
        Get the status of AX 2012 services in your environment
        
    .PARAMETER ComputerName
        Name of the computer(s) that you want to work against
        
    .PARAMETER All
        Instruct the cmdlet to include all known AX 2012 services
        
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
        
    .EXAMPLE
        PS C:\> Get-AxService
        
        This will get the status for all the default services from the local computer.
        If AxActiveAosConfiguration has been configured, it will work against the ComputerName and AosInstanceName registered.
        
    .EXAMPLE
        PS C:\> Get-AxService -ScanAllAosServices
        
        This will scan for all available AOS Services.
        If AxActiveAosConfiguration has been configured, it will work against the ComputerName registered otherwise localhost is used.
        
    .EXAMPLE
        PS C:\> Get-AxService -ComputerName TEST-AOS-01 -Aos
        
        This will get all AOS instances (services) from the server named "TEST-AOS-01".
        If AxActiveAosConfiguration has been configured, it will work against the AosInstanceName registered otherwise it will find all.
        
    .EXAMPLE
        PS C:\> Get-AxService -ComputerName TEST-AOS-01 -Aos -AosInstanceName *DEV*
        
        This will get all AOS instances (services) that match the search pattern "*DEV*" from the server named "TEST-AOS-01".
        
    .EXAMPLE
        PS C:\> Get-AxService -ComputerName TEST-AOS-01 -Aos | Start-AxService -ShowOriginalProgress
        
        This will scan the "TEST-AOS-01" server for all AOS instances (services) and start them.
        It will show the status for the service(s) on the server afterwards.
        
        If AxActiveAosConfiguration has been configured, it will work against the AosInstanceName registered otherwise it will find all.
        
    .EXAMPLE
        PS C:\> Get-AxService -ComputerName TEST-AOS-01 -Aos | Stop-AxService -ShowOriginalProgress
        
        This will scan the "TEST-AOS-01" server for all AOS instances (services) and stop them.
        It will show the status for the service(s) on the server afterwards.
        
        If AxActiveAosConfiguration has been configured, it will work against the AosInstanceName registered otherwise it will find all.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxService {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidDefaultValueSwitchParameter", "")]
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias('ServerName')]
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]] $ComputerName = $Script:ActiveAosComputername,

        [Parameter(ParameterSetName = 'Default')]
        [switch] $All = $true,
        
        [Alias('InstanceName')]
        [string] $AosInstanceName = $(if (-not ([System.String]::IsNullOrEmpty($Script:ActiveAosInstancename))) { "*$Script:ActiveAosInstancename" } else { "*" }),

        [Parameter(ParameterSetName = 'Specific')]
        [switch] $Aos,

        [Parameter(ParameterSetName = 'Specific')]
        [switch] $ManagementReporter,

        [Parameter(ParameterSetName = 'Specific')]
        [switch] $DIXF,

        [switch] $ScanAllAosServices
    )

    begin {
        if ($PSCmdlet.ParameterSetName -eq "Specific") {
            $All = $false
        }
    
        if (!$All -and !$Aos -and !$ManagementReporter -and !$DIXF) {
            Write-PSFMessage -Level Host -Message "You have to use at least one switch when running this cmdlet. Please run the cmdlet again."
            Stop-PSFFunction -Message "Stopping because of missing parameters"
            return
        }

        $baseParams = Get-DeepClone $PSBoundParameters

        $params = @{ }
        $includeParamNames = @("ManagementReporter", "DIXF")

        foreach ($key in $baseParams.Keys) {
            if ($includeParamNames -notcontains $key ) { continue }

            Write-PSFMessage -Level Verbose -Message "Working on key: $key" -Target $key
        
            $null = $params.Add($key, $true)
        }

        if ($params.Count -eq 0) {
            if ($All) {
                $params.AllAxServices = $true

                $Services = @(Get-ServiceList @params)
            }
        }
        else {
            $Services = @(Get-ServiceList @params)
        }

        if ($PSBoundParameters.ContainsKey("Aos")) {
            Write-PSFMessage -Level Verbose -Message "Aos seems to be bound" -Target $key
        
            $searchServicesAos = @(Get-ServiceList -Aos)
        }

    }
    
    process {
        if (Test-PSFFunctionInterrupt) { return }
        
        $res = New-Object System.Collections.ArrayList
    
        foreach ($server in $ComputerName) {
            Write-PSFMessage -Level Verbose -Message "Working against: $server - listing services" -Target ($Services -Join ",")
            Write-PSFMessage -Level Verbose -Message "Working against: $server - listing Aos services" -Target ($searchServicesAos -Join ",")
        
            if ($null -ne $searchServicesAos -and $searchServicesAos.count -gt 0) {

                Write-PSFMessage -Level Verbose -Message "`$searchServicesAos used for searching"

                $colAosServices = Get-Service -ComputerName $server -Name $searchServicesAos -ErrorAction SilentlyContinue | Select-Object @{Name = "Server"; Expression = { $Server } }, Name, Status, DisplayName

                foreach ($service in $colAosServices) {
                    if ((-not $ScanAllAosServices) -and ($service.DisplayName -NotLike $AosInstanceName)) { continue }

                    $null = $res.Add($service)
                }
            }

            if ($null -ne $Services -and $Services.count -gt 0) {
            
                Write-PSFMessage -Level Verbose -Message "`$Services used for searching"

                $axServices = Get-Service -ComputerName $server -Name $Services -ErrorAction SilentlyContinue | Select-Object @{Name = "Server"; Expression = { $Server } }, Name, Status, DisplayName
    
                foreach ($service in $axServices) {
                    if ($service.DisplayName -like "*AX Object Server*" ) {
                        if ((-not $ScanAllAosServices) -and ($service.DisplayName -NotLike $AosInstanceName)) { continue }
                    }

                    $null = $res.Add($service)
                }
            }
        }
        
        $res.ToArray() | Select-Object Server, DisplayName, Status, Name
    }
}