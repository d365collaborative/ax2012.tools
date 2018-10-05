<#
.SYNOPSIS
Get AX 2012 AOS Instance

.DESCRIPTION
Get AX 2012 AOS Instance details from the local machine

.PARAMETER Name
The search string to filter the AOS instance that you're looking for

The parameter supports wildcards. E.g. -Name "*DEV*"

Default value is "*" and will give you all the instances

.PARAMETER InstanceNo
The search string to filter the AOS instance that you're looking for

The parameter supports wildcards. E.g. -InstanceNo "*1*"

Default value is "*" and will give you all the instances

.EXAMPLE
Get-AxAosInstance

This will get you all the installed AX 2012 AOS instances on the machine

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
function Get-AxAosInstance {
    [CmdletBinding()]
    Param(
        [Parameter()]
        [string] $Name = "*",
        
        [Parameter()]
        [string] $InstanceNo = "*"
    )
    $Instances = Get-ChildItem -Path $Script:RegistryAos
        
    $res = New-Object System.Collections.ArrayList
    
    $Instances | ForEach-Object {
        $null = $res.Add((Get-AxAosInstanceDetails $_.Name))
    }

    foreach ($obj in $res) {
        if ($obj.InstanceName -NotLike $Name) { continue }
        if ($obj.InstanceNumber -NotLike $InstanceNo) { continue }

        $obj
    }
}