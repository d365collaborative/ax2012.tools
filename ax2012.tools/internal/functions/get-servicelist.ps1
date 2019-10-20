
<#
    .SYNOPSIS
        Get service list from HashTable
        
    .DESCRIPTION
        Extract the services from the list of entries in the HashTable
        
    .PARAMETER AllAxServices
        Instruct the cmdlet to return all services
        
    .PARAMETER Aos
        Instruct the cmdlet to return AOS
        
    .PARAMETER ManagementReporter
        Instruct the cmdlet to return ManagementReporter
        
    .PARAMETER DIXF
        Instruct the cmdlet to return DIXF
        
    .EXAMPLE
        PS C:\> Get-ServiceList -All
        
        This will return all services that the cmdlet knows about.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
Function Get-ServiceList {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'Default', Position = 1 )]
        [switch] $AllAxServices,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 2 )]
        [switch] $Aos,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 3 )]
        [switch] $ManagementReporter,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 4 )]
        [switch] $DIXF
    )

    if ($PSCmdlet.ParameterSetName -eq "Specific") {
        $AllAxServices = $false
    }

    Write-PSFMessage -Level Verbose -Message "The PSBoundParameters was" -Target ($PSBoundParameters.Keys -Join "," )
    
    $mrProcessName = "MR2012ProcessService"
    $mrApplicationName = "MR2012ApplicationService"

    $dixfName = "Microsoft.Dynamics.AX.Framework.Tools.DMF.SSISHelperService.exe"

    [System.Collections.ArrayList]$Services = New-Object -TypeName "System.Collections.ArrayList"

    if ($AllAxServices) {
        for ($i = 1; $i -lt 100; $i++) {
            $null = $Services.Add("AOS60`$$($i.ToString("00"))")
        }

        $null = $Services.AddRange(@($mrProcessName, $mrApplicationName, $dixfName))
    }
    else {
        if ($Aos) {
            for ($i = 1; $i -lt 100; $i++) {
                $null = $Services.Add("AOS60`$$($i.ToString("00"))")
            }
        }

        if ($ManagementReporter) {
            $null = $Services.Add($mrProcessName)
            $null = $Services.Add($mrApplicationName)
        }

        if ($DIXF) {
            $null = $Services.Add($dixfName)
        }
    }

    $Services.ToArray()
}