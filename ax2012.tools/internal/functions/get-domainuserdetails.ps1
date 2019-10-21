
<#
    .SYNOPSIS
        Get details about the user
        
    .DESCRIPTION
        Extract the FQDM and Sid from the user account
        
    .PARAMETER Username
        User name with the domain name included, in either PRE-2000 or UPN style
        
    .EXAMPLE
        PS C:\> Get-DomainUserDetails -Username "Test@ACME.LOCAL"
        
        This will return the details from the user account "Test@ACME.LOCAL".
        
    .EXAMPLE
        PS C:\> Get-DomainUserDetails -Username "ACME.LOCAL\Test"
        
        This will return the details from the user account "ACME.LOCAL\Test".
        
    .EXAMPLE
        PS C:\> Get-DomainUserDetails -Username "ACME\Test"
        
        This will return the details from the user account "ACME\Test".
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
#>

function Get-DomainUserDetails {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    param (
        [string] $Username
    )

    $res = [Ordered]@{}

    $domain = ""

    if ($Username -like "*@*") {
        $domain = $Username.Split("@")[1]
        $res.UserId = $Username.Split("@")[0]
    }
    else {
        $domain = $Username.Split("\")[0]
        $res.UserId = $Username.Split("\")[1]
    }

    $domains = Get-CimInstance Win32_NTDomain

    foreach ($item in $domains) {

        if ($item.DnsForestName -like "$($item.DomainName)*") {
            if (($item.DnsForestName -like "$domain" -or $item.DomainName -like "$domain")) {
                $res.Domain = $item.DnsForestName
                break
            }
        }
        elseIf ("$($item.DomainName).$($item.DnsForestName)".ToLower() -eq $domain.ToLower() -or $item.DomainName -like "$domain") {
            $res.Domain = "$($item.DomainName).$($item.DnsForestName)".ToLower()
            break
        }
    }

    $res.Sid = Get-Sid -Username $Username

    [PSCustomObject]$res
}