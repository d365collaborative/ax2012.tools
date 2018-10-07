function Get-WMDPDetailsFromIIS {
    [CmdletBinding()]
    param (
        
    )

    if ((Get-Module Webadministration).Count -lt 1) {
        Write-PSFMessage -Level Host -Message "It seems that you didn't have the <c='em'>IIS powershell</c> administration tools installed."
        Stop-PSFFunction -Message "Stopping because of missing parameters" -StepsUpward 1
        return
    }

    Get-WebSite | Where-Object physicalpath -like "*wmdp*" | Select-Object 
}