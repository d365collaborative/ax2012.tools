
<#
    .SYNOPSIS
        Get the build numbers
        
    .DESCRIPTION
        Get the build numbers for the AX 2012 client
        
    .EXAMPLE
        PS C:\> Get-AxClientBuild
        
        This will get the executable path and the build numbers for the client.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxClientBuild {
    [CmdletBinding()]
    Param(
    )
    
    $RegKey = Get-Item -Path $Script:RegistryClient
    
    $RegOuter = Get-ItemProperty -Path $($RegKey.Name.Replace("HKEY_CURRENT_USER", "HKCU:"))

    $RegInner = Get-ItemProperty -Path (Join-Path $RegKey.Name $RegOuter.Current).Replace("HKEY_CURRENT_USER", "HKCU:")

    $BuildNumbers = Get-FileVersion -Path $(Join-Path $RegInner.bindir "Ax32.exe")

    $clientDetails = [Ordered]@{}

    $clientDetails.ExecutablePath = Join-Path $RegInner.bindir "Ax32.exe"

    $clientDetails.FileVersion = $BuildNumbers.FileVersion
    $clientDetails.ProductVersion = $BuildNumbers.ProductVersion
    $clientDetails.FileVersionUpdated = $BuildNumbers.FileVersionUpdated
    $clientDetails.ProductVersionUpdated = $BuildNumbers.ProductVersionUpdated

    [PSCustomObject] $clientDetails
}