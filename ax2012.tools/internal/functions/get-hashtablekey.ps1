
<#
    .SYNOPSIS
        Get key from HashTable
        
    .DESCRIPTION
        Get specific key(s) from a HashTable returned as a HashTable
        
    .PARAMETER InputObject
        The HashTable that you want to extract key(s) from
        
    .PARAMETER Keys
        Names of the key(s) that you want to to extract from the HashTable
        
    .EXAMPLE
        PS C:\> $params = @{NoPrompt = $true; CreateParent = $false}
        
        Get-HashtableKey -InputObject $params -Keys "NoPrompt"
        
        This will return a new HashTable only containing the "NoPrompt" entry.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-HashtableKey {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        [parameter(Mandatory = $true)]
        [HashTable] $InputObject,

        [Parameter(Mandatory = $true)]
        [string[]] $Keys
        
    )

    $var = Get-DeepClone $InputObject
    $res = @{}

    foreach ($key in $var.Keys) {
        Write-PSFMessage -Level Verbose -Message "Working on key: $key" -Target $key
        
        if($Keys.Contains($key)) {
            Write-PSFMessage -Level Verbose -Message "Found key: $key" -Target $key
            $null = $res.Add($key, $var.Item($key))
        }
    }

    $res
}