
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
        
    .PARAMETER ShowOutput
        Switch to instruct the cmdlet to output the status for the service
        
    .EXAMPLE
        PS C:\> Start-AxEnvironment -Server TEST-AOS-01 -DisplayName *ax*obj*
        
        This will start the service(s) that match the search pattern "*ax*obj*" on the server named "TEST-AOS-01".
        
    .EXAMPLE
        PS C:\> Start-AxEnvironment -Server TEST-AOS-01 -DisplayName *ax*obj* -ShowOutput
        
        This will start the service(s) that match the search pattern "*ax*obj*" on the server named "TEST-AOS-01".
        It will show the status for the service(s) on the server afterwards.
        
    .EXAMPLE
        PS C:\> Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos | Start-AxEnvironment -ShowOutput
        
        This will scan the "TEST-AOS-01" server for all AOS instances and start them.
        It will show the status for the service(s) on the server afterwards.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Start-AxEnvironment {
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

        [switch] $ShowOutput
    )

    begin {
        $output = New-Object System.Collections.ArrayList
    }

    process {
        $baseParams = @{ComputerName = $Server; ErrorAction = "SilentlyContinue"}

        if ($PSCmdlet.ParameterSetName -eq "Pipeline") {
            $baseParams.Name = $Name
        }
        else {
            if ($DisplayName -notmatch "\*" ) {
                $DisplayName = "*$DisplayName*"
            }

            $baseParams.DisplayName = $DisplayName
        }

        Get-Service @baseParams | Start-Service -ErrorAction SilentlyContinue

        if ($ShowOutput) {
            $service = Get-Service @baseParams | Select-Object @{Name = "Server"; Expression = {$Server}}, Name, Status, DisplayName
            $null = $output.Add($service)
        }
    }

    end {
        if ($ShowOutput) {
            $output.ToArray() | Select-Object Server, DisplayName, Status, Name
        }
    }
}