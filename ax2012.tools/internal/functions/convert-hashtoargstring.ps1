<#
.SYNOPSIS
Convert HashTable into an array

.DESCRIPTION
Convert HashTable into an array of Key and Value

.PARAMETER Inputs
The HashTable object that you want to work against

.EXAMPLE
$params = @{DatabaseServer = "Localhost"; DatabaseName = "MicrosoftDynamicsAx_model"}
$arguments = Convert-HashToArgString -Inputs $params

This will convert the $params into an array of strings, each with the Key and Value.

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
function Convert-HashToArgString {
    [CmdletBinding()]
    param (
        [HashTable] $Inputs
    )

    $Inputs.Keys | ForEach-Object { "-$_ `"$($params.Item($_))`""}
}