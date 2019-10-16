function Add-AxEnvironmentConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $Name,

        [string[]] $AosServers,

        [string[]] $DatabaseServers,

        [string[]] $SsrsServers,

        [string[]] $EpServers,

        [string[]] $WmdpServers,

        [string[]] $Mr2012Servers,

        [string[]] $SsasServers,

        [switch] $Append,

        [switch] $Force,

        [switch] $Temporary
    )
    
    Write-PSFMessage -Level Verbose -Message "Testing if configuration with the name already exists or not." -Target $configurationValue

    if (((Get-PSFConfig -FullName "ax2012.tools.environment.*.name").Value -contains $Name) -and (-not $Force) -and (-not $Append)) {
        $messageString = "An environment configuration with <c='em'>$Name</c> as name <c='em'>already exists</c>. If you want to <c='em'>overwrite</c> the current configuration, please supply the <c='em'>-Force</c> parameter. If you want to <c='em'>append</c> the current configuration, please supply the <c='em'>-Append</c> parameter"
        Write-PSFMessage -Level Host -Message $messageString
        Stop-PSFFunction -Message "Stopping because an environment configuration already exists with that name." -Exception $([System.Exception]::new($($messageString -replace '<[^>]+>', '')))
        return
    }

    $configName = $Name.ToLower()

    #The ':keys' label is used to have a continue inside the switch statement itself
    :keys foreach ($key in $PSBoundParameters.Keys) {
        
        $configurationValue = $PSBoundParameters.Item($key)
        $configurationName = $key.ToLower()
        $fullConfigName = ""

        Write-PSFMessage -Level Verbose -Message "Working on $key with $configurationValue" -Target $configurationValue
        
        switch ($key) {
            "Name" {
                $fullConfigName = "ax2012.tools.environment.$configName.name"
            }

            { "Temporary", "Force", "Append" -contains $_ } {
                continue keys
            }
            
            Default {
                $fullConfigName = "ax2012.tools.environment.$configName.$configurationName"
            }
        }

        if ($Append -and $key -ne "Name") {
            $oldValue = @(Get-PsfConfigValue -FullName $fullConfigName)
            $temp = @()

            if($null -ne $oldValue) {
                $temp += $oldValue
            }

            $temp += $configurationValue

            $configurationValue = $temp
        }

        Write-PSFMessage -Level Verbose -Message "Setting $fullConfigName to $configurationValue" -Target $configurationValue
        
        Set-PSFConfig -FullName $fullConfigName -Value $configurationValue
        
        if (-not $Temporary) { Register-PSFConfig -FullName $fullConfigName -Scope UserDefault }
    }
}