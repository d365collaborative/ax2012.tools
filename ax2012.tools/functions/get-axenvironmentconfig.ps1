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