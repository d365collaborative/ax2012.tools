
<#
    .SYNOPSIS
        Get the build numbers
        
    .DESCRIPTION
        Get the build numbers for the AX 2012 client
        
    .PARAMETER Path
        The path to the Ax32.exe file you want to work against
        
        The default path is read from the registry
        
    .EXAMPLE
        PS C:\> Get-AxClientBuild
        
        This will get the executable path and the build numbers for the client.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxClientBuild {
    [CmdletBinding()]
    Param(
        [string] $Path = $(Join-Path $Script:ClientBin "Ax32.exe")
    )
    
    $BuildNumbers = Get-FileVersion -Path $Path

    $clientDetails = [Ordered]@{}

    $clientDetails.ExecutablePath = $Path

    $clientDetails.FileVersion = $BuildNumbers.FileVersion
    $clientDetails.ProductVersion = $BuildNumbers.ProductVersion
    $clientDetails.FileVersionUpdated = $BuildNumbers.FileVersionUpdated
    $clientDetails.ProductVersionUpdated = $BuildNumbers.ProductVersionUpdated

    [PSCustomObject] $clientDetails
}