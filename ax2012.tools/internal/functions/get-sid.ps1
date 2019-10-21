function Get-Sid {
    [CmdletBinding()]
    param (
        [string] $Username
    )

    (New-Object System.Security.Principal.NTAccount($Username)).Translate([System.Security.Principal.SecurityIdentifier]).value

}

