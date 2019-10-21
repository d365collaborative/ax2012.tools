
<#
    .SYNOPSIS
        Get the Sid from the user
        
    .DESCRIPTION
        Translate the username into the unique sid of the user
        
    .PARAMETER Username
        User name with the domain name included, in either PRE-2000 or UPN style
        
    .EXAMPLE
        PS C:\> Get-Sid -Username "Test@ACME.LOCAL"
        
        This will return the Sid from the user account "Test@ACME.LOCAL".
        
    .NOTES
        Tags:
        
        Author: Mötz Jensen (@Splaxi)
        
#>

function Get-Sid {
    [CmdletBinding()]
    param (
        [string] $Username
    )

    (New-Object System.Security.Principal.NTAccount($Username)).Translate([System.Security.Principal.SecurityIdentifier]).value
}