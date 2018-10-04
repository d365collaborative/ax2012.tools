<#
.SYNOPSIS
Get service list from HashTable

.DESCRIPTION
Extract the services from the list of entries in the HashTable

.PARAMETER All
Switch to instruct the cmdlet to return all services

.PARAMETER Aos
Switch to instruct the cmdlet to return AOS

.PARAMETER ManagementReporter
Switch to instruct the cmdlet to return ManagementReporter

.PARAMETER DIXF
Switch to instruct the cmdlet to return DIXF

.EXAMPLE
Get-ServiceList -All

This will return all services that the cmdlet knows about.

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
Function Get-ServiceList {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'Default', Position = 1 )]
        [switch] $All = [switch]::Present,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 2 )]
        [switch] $Aos,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 3 )]
        [switch] $ManagementReporter,

        [Parameter(Mandatory = $false, ParameterSetName = 'Specific', Position = 4 )]
        [switch] $DIXF
    )

    if ($PSCmdlet.ParameterSetName -eq "Specific") {
        $All = $false
    }

    Write-PSFMessage -Level Verbose -Message "The PSBoundParameters was" -Target $PSBoundParameters

    $aosname = "w3svc"    
    $ManagementReporter = "MR2012ProcessService"
    $dixfname = "Microsoft.Dynamics.AX.Framework.Tools.DMF.SSISHelperService.exe"

    [System.Collections.ArrayList]$Services = New-Object -TypeName "System.Collections.ArrayList"

    if ($All) {
        $null = $Services.AddRange(@($aosname, $ManagementReporter))
    }    
    else {
        if ($Aos) {
            $null = $Services.Add($aosname)
        }
        if ($ManagementReporter) {
            $null = $Services.Add($ManagementReporter)
        }
        if ($DIXF) {
            $null = $Services.Add($dixfname)
        }
    }

    $Services.ToArray()
}