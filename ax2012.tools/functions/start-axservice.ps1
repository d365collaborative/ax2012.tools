
<#
    .SYNOPSIS
        Start an AX 2012 environment
        
    .DESCRIPTION
        Start AX 2012 services in your environment
        
    .PARAMETER Server
        Name of the computer(s) that you want to work against
        
        Default value is the name from the ComputerName from AxActiveAosConfiguration
        
    .PARAMETER DisplayName
        DisplayName of windows service that you want to work against
        
        Accepts wildcards for searching. E.g. -DisplayName "*ax*obj*"
        
    .PARAMETER Name
        Name of the Windows Service that you want to work against
        
        This parameter is used when piping in the details
        
        Designed to work together with the Get-AxEnvironment cmdlet
        
    .PARAMETER ShowOriginalProgress
        Instruct the cmdlet to output the status for the service
        
    .EXAMPLE
        PS C:\> Start-AxService -Server TEST-AOS-01 -DisplayName *ax*obj*
        
        This will start the service(s) that match the search pattern "*ax*obj*" on the server named "TEST-AOS-01".
        
    .EXAMPLE
        PS C:\> Start-AxService -Server TEST-AOS-01 -DisplayName *ax*obj* -ShowOriginalProgress
        
        This will start the service(s) that match the search pattern "*ax*obj*" on the server named "TEST-AOS-01".
        It will show the progress of starting the service(s) in the console.
        It will show the status for the service(s) on the server afterwards.
        
    .EXAMPLE
        PS C:\> Get-AxService -ComputerName TEST-AOS-01 -Aos | Start-AxService -ShowOriginalProgress
        
        This will scan the "TEST-AOS-01" server for all AOS instances (services) and start them.
        It will show the progress of starting the service(s) in the console.
        It will show the status for the service(s) on the server afterwards.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Start-AxService {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param (

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = "Pipeline")]
        [Parameter(ParameterSetName = "Default", Position = 1)]
        [Alias('ComputerName')]
        [string[]] $Server = $Script:ActiveAosComputername,

        [Parameter(Mandatory = $true, ParameterSetName = "Default", Position = 2)]
        [string] $DisplayName,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = "Pipeline")]
        [string[]] $Name,

        [switch] $ShowOriginalProgress
    )

    begin {
        $output = New-Object System.Collections.ArrayList

        $warningActionValue = "SilentlyContinue"
        if ($ShowOriginalProgress) { $warningActionValue = "Continue" }
    }

    process {
        $baseParams = @{ComputerName = $Server; ErrorAction = "SilentlyContinue" }

        if ($PSBoundParameters.ContainsKey("Name")) {
            foreach ($item in $Name) {
                if (($item.Trim().Length -eq 0) -or ($Name -eq "*")) {
                    Write-PSFMessage -Level Host -Message "It seems that you didn't provide any Name. That would result in starting all services." -Exception $PSItem.Exception
                    Stop-PSFFunction -Message "Stopping because of missing filters."
                    return
                }
            }

            if (Test-PSFFunctionInterrupt) { return }

            $baseParams.Name = $Name
        }
        else {
            if (($DisplayName.Length -gt 0) -and (-not($DisplayName -eq "*"))) {
                if ($DisplayName -notmatch "\*" ) {
                    $DisplayName = "*$DisplayName*"
                }

                $baseParams.DisplayName = $DisplayName
            }
            else {
                Write-PSFMessage -Level Host -Message "It seems that you didn't provide any Display Name. That would result in starting all services." -Exception $PSItem.Exception
                Stop-PSFFunction -Message "Stopping because of missing filters."
                return
            }
        }

        Get-Service @baseParams | Start-Service -ErrorAction SilentlyContinue -WarningAction $warningActionValue

        $service = Get-Service @baseParams | Select-Object @{Name = "Server"; Expression = { $Server } }, Name, Status, DisplayName
        $null = $output.Add($service)
    }

    end {
        $output.ToArray() | Select-Object Server, DisplayName, Status, Name
    }
}