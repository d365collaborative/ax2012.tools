
<#
    .SYNOPSIS
        Clear the imported AX 2012 PowerShell modules
        
    .DESCRIPTION
        Removes the different AX 2012 PowerShell modules that has been loaded into the session.
        
    .EXAMPLE
        PS C:\> Clear-Ax2012StandardPowershellModule
        
        This will remove all the known AX 2012 PowerShell modules that have been loaded.
        It is connected to the use of Import-Module $Script:AxPowerShellModule
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Clear-Ax2012StandardPowershellModule {
    [CmdletBinding()]
    param ( )

    Remove-Module @("AxUtilLib", "AxUtilLib.PowerShell", "Microsoft.Dynamics.Administration", "Microsoft.Dynamics.AX.Framework.Management", "Microsoft.Dynamics.ManagementUtilities")
}