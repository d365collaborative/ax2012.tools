
<#
    .SYNOPSIS
        Get AX 2012 environment details from the configuration store
        
    .DESCRIPTION
        Get the environment details for the AX 2012 environment(s) that are stored in the configuration store
        
    .PARAMETER Name
        Name of the configuration that you want to work against
        
    .PARAMETER OutputAsHashtable
        Instruct the cmdlet to return a hastable object
        
    .PARAMETER EnableException
        This parameters disables user-friendly warnings and enables the throwing of exceptions
        This is less user friendly, but allows catching exceptions in calling scripts
        
    .EXAMPLE
        PS C:\> Get-AxEnvironmentConfig
        
        This will get all saved environment configurations.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>

function Get-AxEnvironmentConfig {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseOutputTypeCorrectly', '')]
    [CmdletBinding()]
    [OutputType('PSCustomObject')]
    param (
        [string] $Name = "*",

        [switch] $OutputAsHashtable,

        [switch] $EnableException
    )
    
    Write-PSFMessage -Level Verbose -Message "Fetch all configurations based on $Name" -Target $Name

    $Name = $Name.ToLower()
    $configurations = Get-PSFConfig -FullName "ax2012.tools.environment.$Name.name"

    if($($configurations.count) -lt 1) {
        $messageString = "No configurations found <c='em'>with</c> the name."
        Write-PSFMessage -Level Host -Message $messageString
        Stop-PSFFunction -Message "Stopping because no configuration found." -Exception $([System.Exception]::new($($messageString -replace '<[^>]+>','')))
        return
    }
    
    foreach ($configName in $configurations.Value.ToLower()) {
        Write-PSFMessage -Level Verbose -Message "Working against the $configName configuration" -Target $configName
        $res = @{}

        $configName = $configName.ToLower()

        foreach ($config in Get-PSFConfig -FullName "ax2012.tools.environment.$configName.*") {
            Write-PSFMessage -Level Verbose -Message "Working against the $($config.FullName.ToString()) of $configName configuration" -Target $configName

            $propertyName = (Get-Culture).TextInfo.ToTitleCase($config.FullName.ToString().Replace("ax2012.tools.environment.$configName.", "")).Replace("servers","Servers")
            $res.$propertyName = $config.Value
        }
        
        if($OutputAsHashtable) {
            $res
        } else {
            [PSCustomObject]$res | Select-PSFObject -TypeName "AX2012.TOOLS.Environment.Config"
        }
    }
}