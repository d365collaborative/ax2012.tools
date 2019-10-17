
<#
    .SYNOPSIS
        Add configuration details for an entire AX 2012 environment
        
    .DESCRIPTION
        Build a configuration containing all the different servers / machines that is part of any given AX 2012 environment
        
        You could register your TEST, SAT, UAT, PROD environment and easily switch between them when you want to troubleshoot or run maintenance work against them
        
    .PARAMETER Name
        Name of the environment that you are adding
        
    .PARAMETER AosServers
        Array with server names of all the servers that host an AOS instance in the specific environment
        
    .PARAMETER InstanceName
        Name of the instance that is used to uniquely identify the environment across multiple AOS instances
        
    .PARAMETER DatabaseServers
        Array with server names of all the servers that host a SQL Server database for the environment
        
    .PARAMETER Database
        Database name for the SQL Server database that the AOS instance(s) connects to
        
    .PARAMETER ModelstoreDatabase
        Database name for the SQL Server database that holds the modelstore (code)
        
    .PARAMETER SsrsServers
        Array with server names of all the servers that host a Sql Server Reporting Services (SSRS) instance in the specific environment
        
    .PARAMETER EpServers
        Array with server names of all the servers that host a SharePoint installation with corresponding Enterprise Portal components in the specific environment
        
    .PARAMETER WmdpServers
        Array with server names of all the servers that host an IIS installation with corresponding Warehouse Mobile Device Portal (WMDP) components in the specific environment
        
    .PARAMETER Mr2012Servers
        Array with server names of all the servers that host a Management Reporter 2012 instance in the specific environment
        
    .PARAMETER SsasServers
        Array with server names of all the servers that host a Sql Server Analysis Services (SSAS) instance in the specific environment
        
    .PARAMETER Append
        Instructs the cmdlet to append the different parameter values with those that might already exist in the configuration store
        
    .PARAMETER Force
        Instruct the cmdlet to overwrite the specified parameter values in the configuration store
        
    .PARAMETER Temporary
        Instruct the cmdlet to only temporarily add the environment configuration in the configuration store
        
        Great help while building the configuration and you don't want to persist the configuration on the machine
        
    .EXAMPLE
        PS C:\> Add-AxEnvironmentConfig -Name AXTEST -AosServers TESTAOS01 -InstanceName AXTEST -DatabaseServers TESTSQL01 -Database AXTEST -ModelstoreDatabase AXTEST_model -Temporary
        
        This adds a new environment configuration to the configuration store.
        The Name AXTEST is used as the name for the configuration of the environment.
        The InstanceName AXTEST is used as the instance name for the configuration of the environment.
        The server TESTAOS01 is registered as the AOS Server.
        The server TESTSQL01 is registered as the SQL Server.
        The database AXTEST is registered as the SQL Server database.
        The database AXTEST_model is registered as the SQL Server database for the modelstore.
        
    .NOTES
        
#>

function Add-AxEnvironmentConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $Name,

        [string[]] $AosServers,

        [string] $InstanceName,

        [string[]] $DatabaseServers,

        [string] $Database,

        [string] $ModelstoreDatabase,

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