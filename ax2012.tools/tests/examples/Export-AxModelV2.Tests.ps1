$commandName = "Export-AxModelV2"
################################### New Example test ###################################

$exampleRaw = "Get-AxAosInstance | Export-AxModelV2"
#Remember to escape any variables names in the line above.
#Remember to you need to output $true to the pester test, otherwise is fails.
#; `$var -eq `$true

#Here you declare any variable(s) you need to complete the test.

$example = $exampleRaw -replace "`n.*" -replace "PS C:\\>"

Describe "Specific example testing for $commandName" {

    It "Example - $example" {
        # mock the tested command so we don't actually do anything
        # because it can be unsafe and we don't have the environment setup
        # (so the only thing we are testing is that the code is semantically
        # correct and provides all the needed params)
        Mock Get-AxAosInstance { 
            $InstanceDetail = [Ordered]@{}
    
            $InstanceDetail.InstanceName = ""
            $InstanceDetail.ConfigurationName = ""
            $InstanceDetail.BinDirectory = ""
            $InstanceDetail.ExecutablePath = ""
    
            $InstanceDetail.FileVersion = ""
            $InstanceDetail.ProductVersion = ""
            $InstanceDetail.FileVersionUpdated = ""
            $InstanceDetail.ProductVersionUpdated = ""
    
            $InstanceDetail.DatabaseServer = ""
            $InstanceDetail.DatabaseName = ""
            $InstanceDetail.ModelstoreDatabase = ""
    
            $InstanceDetail.AosPort = ""
            $InstanceDetail.WsdlPort = ""
            $InstanceDetail.NetTcpPort = ""
        
            $InstanceDetail.RegistryKeyPath = ""
            $InstanceDetail.InstanceNumber = ""
            $InstanceDetail.ComputerName = ""
    
            [PSCustomObject] $InstanceDetail
        }

        Mock $commandName {
            # I am returning true here,
            # but some of the examples drill down to the returned object
            # so in strict mode we would fail
            $true
        }
        # here simply invoke the example
        $result = Invoke-Expression $example
        # and check that we got result from the mock
        $result | Should -BeTrue
    }
}
################################### New Example test ###################################

$exampleRaw = "`$Test = `"1`"" + [environment]::NewLine
$exampleRaw = "Export-AxModelV2 -DatabaseServer localhost -ModelstoreDatabase MicrosoftDynamicsAx_model -Name *CUS*"
#Remember to escape any variables names in the line above.
#Remember to you need to output $true to the pester test, otherwise is fails.
#; `$var -eq `$true

#Here you declare any variable(s) you need to complete the test.

$example = $exampleRaw -replace "`n.*" -replace "PS C:\\>"

Describe "Specific example testing for $commandName" {

    It "Example - $example" {
        # mock the tested command so we don't actually do anything
        # because it can be unsafe and we don't have the environment setup
        # (so the only thing we are testing is that the code is semantically
        # correct and provides all the needed params)
        Mock $commandName {
            # I am returning true here,
            # but some of the examples drill down to the returned object
            # so in strict mode we would fail
            $true
        }
        # here simply invoke the example
        $result = Invoke-Expression $example
        # and check that we got result from the mock
        $result | Should -BeTrue
    }
}
################################### Entire help loaded ###################################

<#


NAME
    Export-AxModelV2
    
SYNOPSIS
    Export AX 2012 model
    
    
SYNTAX
    Export-AxModelV2 [[-DatabaseServer] <String>] [[-ModelstoreDatabase] <String>] [[-Path] <String>] [[-Name] <String>
    ] [[-Id] <String>] [[-Layer] <String>] [-OutputCommandOnly] [<CommonParameters>]
    
    
DESCRIPTION
    Export AX 2012 model from the AX 2012 model store
    

PARAMETERS
    -DatabaseServer <String>
        Server name of the database server
        
        Default value is: "localhost"
        
        Required?                    false
        Position?                    2
        Default value                localhost
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false
        
    -ModelstoreDatabase <String>
        Name of the modelstore database
        
        Default value is: "MicrosoftDynamicsAx_model"
        
        Note: From AX 2012 R2 and upwards you need to provide the full name for the modelstore database. E.g. "AX2012R3
        _PROD_model"
        
        Required?                    false
        Position?                    3
        Default value                MicrosoftDynamicsAx_model
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false
        
    -Path <String>
        Path to the location where you want the file to be exported
        
        Default value is: "c:\temp\ax2012.tools"
        
        Required?                    false
        Position?                    4
        Default value                c:\temp\ax2012.tools
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Name <String>
        Name of the AX 2012 model that you are looking for
        
        Accepts wildcards for searching. E.g. -Name "ISV*MODULE*"
        
        Default value is "*" which will search for all models
        
        Required?                    false
        Position?                    5
        Default value                *
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Id <String>
        Id of the AX 2012 model that you are looking for
        
        Accepts wildcards for searching. E.g. -Id "2*"
        
        Default value is "*" which will search for all models
        
        Required?                    false
        Position?                    6
        Default value                *
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Layer <String>
        Layer where the AX 2012 model that you are looking for should reside
        
        Accepts wildcards for searching. E.g. -Layer "IS*"
        
        Default value is "*" which will search for models in all layers
        
        Required?                    false
        Position?                    7
        Default value                *
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -OutputCommandOnly [<SwitchParameter>]
        Switch to instruct the cmdlet to output the script to execute the command in hand
        
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    System.String
    
    
NOTES
    
    
        Author: Mötz Jensen (@Splaxi)
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-AxAosInstance | Export-AxModelV2
    
    This will fetch all the AX 2012 AOS instances that are configured on the machine.
    Foreach of the instances it will export all AX 2012 Models into a sub folder to "c:\temp\ax2012.tools".
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>$Test = "1"
    
    PS C:\> Export-AxModelV2 -DatabaseServer "localhost" -ModelstoreDatabase "MicrosoftDynamicsAx_model" -Names "*CUS*"
    
    This will fetch all the AX 2012 AOS instances that are configured on the machine.
    Foreach of the instances it will export all AX 2012 Models into a sub folder to "c:\temp\ax2012.tools".
    
    
    
    
    
RELATED LINKS



#>
