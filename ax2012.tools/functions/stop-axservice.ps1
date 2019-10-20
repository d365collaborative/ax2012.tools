
<#
    .SYNOPSIS
        Stop AX 2012 service(s)
        
    .DESCRIPTION
        Stop AX 2012 service(s) on the computer
        
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
        
    .PARAMETER Force
        Instruct the cmdlet to force the stopping of the service
        
    .EXAMPLE
        PS C:\> Stop-AxService -Server TEST-AOS-01 -DisplayName *ax*obj*
        
        This will stop the service(s) that match the search pattern "*ax*obj*" on the server named "TEST-AOS-01".
        
    .EXAMPLE
        PS C:\> Stop-AxService -Server TEST-AOS-01 -DisplayName *ax*obj* -ShowOriginalProgress
        
        This will stop the service(s) that match the search pattern "*ax*obj*" on the server named "TEST-AOS-01".
        It will show the progress of stopping the service(s) in the console.
        It will show the status for the service(s) on the server afterwards.
        
    .EXAMPLE
        PS C:\> Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos | Stop-AxEnvironment -ShowOriginalProgress
        
        This will scan the "TEST-AOS-01" server for all AOS instances (services) and stop them.
        It will show the progress of stopping the service(s) in the console.
        It will show the status for the service(s) on the server afterwards.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Stop-AxService {
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

        [switch] $ShowOriginalProgress,

        [switch] $Force

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
                    Write-PSFMessage -Level Host -Message "It seems that you didn't provide any Name. That would result in shutting down all services." -Exception $PSItem.Exception
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
                Write-PSFMessage -Level Host -Message "It seems that you didn't provide any Display Name. That would result in shutting down all services." -Exception $PSItem.Exception
                Stop-PSFFunction -Message "Stopping because of missing filters."
                return
            }
        }

        Write-PSFMessage -Level Verbose -Message "Stopping the specified services." -Target ((Convert-HashToArgString $baseParams) -join ",")
        Get-Service @baseParams | Stop-Service -Force:$Force -ErrorAction SilentlyContinue -WarningAction $warningActionValue

        $service = Get-Service @baseParams | Select-Object @{Name = "Server"; Expression = { $Server } }, Name, Status, DisplayName
        $null = $output.Add($service)
    }

    end {
        $output.ToArray() | Select-Object Server, DisplayName, Status, Name
    }
}