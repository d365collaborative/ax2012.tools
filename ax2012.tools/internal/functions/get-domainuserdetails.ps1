function Get-DomainUserDetails {
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