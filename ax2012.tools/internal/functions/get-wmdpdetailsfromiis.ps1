<#
.SYNOPSIS
Get WMDP details from the IIS

.DESCRIPTION
Get all the necessary details from the IIS about the WMDP installation

.EXAMPLE
Get-WMDPDetailsFromIIS

This will get details from all the WMDP installations on the server.

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
function Get-WMDPDetailsFromIIS {
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    param ( )

    if ((Get-Module Webadministration).Count -lt 1) {
        Write-PSFMessage -Level Host -Message "It seems that you didn't have the <c='em'>IIS powershell</c> administration tools installed."
        Stop-PSFFunction -Message "Stopping because of missing parameters" -StepsUpward 1
        return
    }

    Get-WebSite | Where-Object physicalpath -like "*wmdp*" | Select-Object
}