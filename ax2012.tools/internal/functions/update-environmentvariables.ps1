
<#
    .SYNOPSIS
        Update the environment config variables
        
    .DESCRIPTION
        Update the active environment config variables that the module will use as default values
        
    .EXAMPLE
        PS C:\> Update-ActiveEnvironmentVariables
        
        This will update the environment variables.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
#>

function Update-ActiveEnvironmentVariables {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    [OutputType()]
    param ( )
    
    $configName = (Get-PSFConfig -FullName "ax2012.tools.active.environment.config.name").Value

    if (([string]::IsNullOrEmpty($configName))) {
        return
    }

    $configName = $configName.ToString().ToLower()
    
    if (-not ($configName -eq "")) {
        $configHash = Get-AxActiveEnvironmentConfig -OutputAsHashtable
        foreach ($item in $configHash.Keys) {
            if ($item -eq "name") { continue }
            
            $name = "Environment" + (Get-Culture).TextInfo.ToTitleCase($item)
        
            Write-PSFMessage -Level Verbose -Message "$name - $($configHash[$item])" -Target $configHash[$item]
            Set-Variable -Name $name -Value $configHash[$item] -Scope Script
        }
    }
}