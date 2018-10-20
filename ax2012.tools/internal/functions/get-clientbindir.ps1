
<#
    .SYNOPSIS
        Get the AX 2012 Client bin directory
        
    .DESCRIPTION
        Get the AX 2012 Client bin directory from the registry
        
    .EXAMPLE
        PS C:\> Get-ClientBinDir
        
        This will get the full path for the AX 2012 client bin directory
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-ClientBinDir {
    [CmdletBinding()]
    [OutputType('System.String')]
    param ( )

    $RegKey = Get-Item -Path $Script:RegistryClient -ErrorAction SilentlyContinue
    
    if(-not ($null -eq $RegKey)) {
        $RegOuter = Get-ItemProperty -Path $($RegKey.Name.Replace("HKEY_CURRENT_USER", "HKCU:"))

        $RegInner = Get-ItemProperty -Path (Join-Path $RegKey.Name $RegOuter.Current).Replace("HKEY_CURRENT_USER", "HKCU:")
    
        $RegInner.bindir
    }
}