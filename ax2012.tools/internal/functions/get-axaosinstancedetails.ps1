
<#
    .SYNOPSIS
        Get details about an AX 2012 AOS instance
        
    .DESCRIPTION
        Get all the technical details about an AX 2012 AOS instance
        
    .PARAMETER RegistryPath
        Path to the registry for the specific AX 2012 AOS instance
        
    .EXAMPLE
        PS C:\> Get-AxAosInstanceDetails -RegistryPath "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Dynamics Server\6.0\01"
        
        This will traverse all the details about the first installed AX 2012 AOS instance in the registry.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxAosInstanceDetails {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    param(
        [string] $RegistryPath
    )

    Write-PSFMessage -Level Verbose -Message "Working against $RegistryPath" -Target $RegistryPath

    $RegKey = Get-Item -Path $RegistryPath.Replace("HKEY_LOCAL_MACHINE", "HKLM:")
    $RegOuter = Get-ItemProperty -Path ($RegKey.Name).Replace("HKEY_LOCAL_MACHINE", "HKLM:")
    $RegInner = Get-ItemProperty -Path (Join-Path $RegKey.Name $RegOuter.Current).Replace("HKEY_LOCAL_MACHINE", "HKLM:")
    $BuildNumbers = Get-FileVersion -Path $(Join-Path $RegInner.bindir "Ax32Serv.exe")

    $InstanceDetail = [Ordered]@{}
    
    $InstanceDetail.InstanceName = $RegOuter.InstanceName
    $InstanceDetail.ConfigurationName = $RegOuter.Current
    $InstanceDetail.BinDirectory = $RegInner.bindir
    $InstanceDetail.ExecutablePath = Join-Path $RegInner.bindir "Ax32Serv.exe"

    $InstanceDetail.FileVersion = $BuildNumbers.FileVersion
    $InstanceDetail.ProductVersion = $BuildNumbers.ProductVersion
    $InstanceDetail.FileVersionUpdated = $BuildNumbers.FileVersionUpdated
    $InstanceDetail.ProductVersionUpdated = $BuildNumbers.ProductVersionUpdated

    $InstanceDetail.DatabaseServer = $RegInner.dbserver
    $InstanceDetail.DatabaseName = $RegInner.database
    $InstanceDetail.ModelstoreDatabase = "$($RegInner.database)_model"

    $InstanceDetail.AosPort = $RegInner.port
    $InstanceDetail.WSDLPort = $RegInner.WSDLPort
    $InstanceDetail.NetTCPPort = $RegInner.NetTCPPort
    
    $InstanceDetail.RegistryKeyPath = $RegKey.Name
    $InstanceDetail.InstanceNumber = Split-Path -Path $RegKey.Name -Leaf
       
    [PSCustomObject] $InstanceDetail
}