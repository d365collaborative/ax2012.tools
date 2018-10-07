<#
    .SYNOPSIS
        Convert HashTable into an array
        
    .DESCRIPTION
        Convert HashTable into an array of Key and Value
        
    .PARAMETER InputObject
        The HashTable object that you want to work against
        
    .PARAMETER KeyPrefix
        The prefix that you want to append to the key of the HashTable
        
        The default value is "-"
        
    .PARAMETER ValuePrefix
        The prefix that you want to append to the value of the HashTable
        
        The default value is " "
        
    .EXAMPLE
        PS C:\> $params = @{DatabaseServer = "Localhost"; DatabaseName = "MicrosoftDynamicsAx_model"}
        PS C:\> $arguments = Convert-HashToArgString -Inputs $params
        
        This will convert the $params into an array of strings, each with the Key and Value.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)

#>
function Convert-HashToArgString {
    [CmdletBinding()]
    param (
        [HashTable] $InputObject,

        [string] $KeyPrefix = "-",

        [string] $ValuePrefix = " "
    )

    $InputObject.Keys | ForEach-Object { "$KeyPrefix$($_)$ValuePrefix`"$($InputObject.Item($_))`""}
}