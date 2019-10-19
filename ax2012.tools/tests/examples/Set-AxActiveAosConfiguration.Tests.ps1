$commandName = "Set-AxActiveAosConfig"
################################### New Example test ###################################

$exampleRaw = "Get-AxAosInstance | Select-Object -First 1 | Set-AxActiveAosConfig"
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