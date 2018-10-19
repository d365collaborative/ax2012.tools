
<#
    .SYNOPSIS
        Get WMDP details from the IIS
        
    .DESCRIPTION
        Get all the necessary details from the IIS about the WMDP installation
        
    .EXAMPLE
        PS C:\> Get-WMDPDetailsFromIIS
        
        This will get details from all the WMDP installations on the server.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-WMDPDetailsFromIIS {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    param ( )

    if ((Get-Module -ListAvailable -Name "IISAdministration").Count -lt 1) {
        Write-PSFMessage -Level Host -Message "It seems that you didn't have the <c='em'>extended</c> powershell administration tools for IIS installed. For Windows Server 2012 and 2012 R2 it is required that you install this module directly."
        Write-PSFMessage -Level Host -Message "Install-Module IISAdministration -Force -Confirm:`$false"
        Stop-PSFFunction -Message "Stopping because of missing parameters" -StepsUpward 1
        return
    } else {
        $null = Import-ModuleImport-Module -name "IISAdministration" -Force
    }

    $sites = Get-IISSite | Where-Object {$_.Applications.VirtualDirectories.PhysicalPath -like "*AX*warehouse*portal*"}

    foreach ($site in $sites) {
        $res = [Ordered]@{SiteId = $site.Id; SiteName = $site.Name;
                SiteStatus = $site.State; SiteBindings = $site.Bindings;
                Path = $site.Applications.VirtualDirectories.PhysicalPath
                MvcViewPath = Join-Path $site.Applications.VirtualDirectories.PhysicalPath "Views\Execute"
                CssPath = Join-Path $site.Applications.VirtualDirectories.PhysicalPath "Content\CSS\RFCSS"
            }
        
        $appPool = Get-IISAppPool | Where-Object Name -eq $site.Applications.ApplicationPoolName
        $res.AppPoolName = $appPool.Name
        $res.AppPoolStatus = $appPool.Status
        $res.AppPoolIdentity = $appPool.ProcessModel.Username

        [PSCustomObject]$res
    }
}