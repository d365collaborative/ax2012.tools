
<#
    .SYNOPSIS
        Get WMDP details
        
    .DESCRIPTION
        Get the most relevant WMDP details from your AX 2012 environment
        
    .EXAMPLE
        PS C:\> Get-AxWMDPDetails
        
        This will get all the relevant WMDP details from the AX 2012 environment
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxWMDPDetails {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    param ( )

    Get-WMDPDetailsFromIIS
}