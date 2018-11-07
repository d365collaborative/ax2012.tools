<#
.SYNOPSIS
Update all the active variables

.DESCRIPTION
All PSF configuration entries that are names *.active* will be extracted to their corresponding $script:VARIABLENAMe

.EXAMPLE
PS C:\> Update-ActiveVariables

This will update all the variables that maps directly to a PSF configuration value in the *.active* part of the configuration store.

.NOTES
Author: Mötz Jensen (@Splaxi)
#>
function Update-ActiveVariables {
    [CmdletBinding()]
    param ()
    
    foreach ($item in (Get-PSFConfig -FullName ax2012.tools.active*)) {
        $nameTemp = $item.FullName -replace "^ax2012.tools.", ""
        $name = ($nameTemp -Split "\." | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) } ) -Join ""
        
        New-Variable -Name $name -Value $item.Value -Scope Script -Force
    }
    
    if ([System.String]::IsNullOrEmpty(($Script:ActiveAosDatabaseserver -replace "null", "" ))) {
        Write-PSFMessage -Level Verbose -Message "ActiveAosDatabaseserver was empty. Defaulting to `"localhost`""
        $Script:ActiveAosDatabaseserver = "localhost"
    }
    
    if ([System.String]::IsNullOrEmpty(($Script:ActiveAosModelstoredatabase -replace "null", "" ))) {
        Write-PSFMessage -Level Verbose -Message "ActiveAosModelstoredatabase was empty. Defaulting to `"MicrosoftDynamicsAx_model`""
        $Script:ActiveAosModelstoredatabase = "MicrosoftDynamicsAx_model"
    }
    
    if ([System.String]::IsNullOrEmpty(($Script:ActiveAosDatabase -replace "null", "" ))) {
        Write-PSFMessage -Level Verbose -Message "ActiveAosDatabase was empty. Defaulting to `"MicrosoftDynamicsAx`""
        $Script:ActiveAosDatabase = "MicrosoftDynamicsAx"
    }
}