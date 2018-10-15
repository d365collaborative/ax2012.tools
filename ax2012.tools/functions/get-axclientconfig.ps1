<#
.SYNOPSIS
Get the AX 2012 client configuration

.DESCRIPTION
Get the AX 2012 client configuration from the registry

.PARAMETER Name
Name of the configuration that you are looking for

The parameter supports wildcards. E.g. -Name "*DEV*"

.EXAMPLE
PS C:\> Get-AxClientConfig

This will get all available client configurations from the registry and display them.

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
function Get-AxClientConfig {
    [CmdletBinding()]
    Param(
        [Parameter()]
        [SupportsWildcards()]
        [string] $Name = "*"
    )
    
    $configs = Get-ChildItem -Path $Script:RegistryClient

    foreach ($item in $configs) {
        $RegistryPath = Get-Item -Path $($item.Name.Replace("HKEY_CURRENT_USER", "HKCU:"))
        $configName = Split-Path -Path $RegistryPath.Name -Leaf
        
        if ($configName -NotLike $Name) { continue }

        $RegInner = Get-ItemProperty -Path $($RegistryPath.Name.Replace("HKEY_CURRENT_USER", "HKCU:"))
        $res = [Ordered]@{ConfigName = $configName}
        
        $res.AosServer = ($RegInner.Aos2).Split(":")[0]
        $res.AosPort = ($RegInner.Aos2).Split(":")[1]
        
        if ($RegInner.Aos2 -like "*@*") {
            $res.InstanceName = ($RegInner.Aos2).Split("@")[0]
        }

        $res.AosTrafficEncrypted = $RegInner.AosEncryption

        $res.BinDir = $RegInner.BinDir
        $res.ClientDirectory = $RegInner.Directory
        $res.Aol = $RegInner.Aol
        $res.AolCode = $RegInner.AolCode
        
        [PSCustomObject]$res
    }
}