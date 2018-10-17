<#
.SYNOPSIS
Aaaaa aaa a aaa a a aa 

.DESCRIPTION
Bbbb b b b b bbbbb  bbbb

.PARAMETER Path
Cccc ccccc ccc cc cc

.EXAMPLE
PS C:\> Invoke-AxAxBuild

This will work

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
function Invoke-AxAxBuild {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseOutputTypeCorrectly', '')]
    [CmdletBinding()]
    param (
        [string] $Path = $Script:ActiveAosBindirectory

        <#
        ActiveAosAosPort
        ActiveAosBindirectory
        ActiveAosComputername
        ActiveAosDatabase
        ActiveAosDatabaseserver
        ActiveAosInstancename
        ActiveAosInstanceNumber
        ActiveAosModelstoredatabase
        ActiveAosNettcpPort
        ActiveAosWsdlPort
        #>
    )
    
    Get-Variable
}