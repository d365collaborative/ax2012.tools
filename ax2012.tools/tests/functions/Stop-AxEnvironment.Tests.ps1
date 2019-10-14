Describe "Stop-AxEnvironment Unit Tests" -Tag "Unit" {
	BeforeAll {
		# Place here all things needed to prepare for the tests
	}
	AfterAll {
		# Here is where all the cleanup tasks go
	}
	
	Describe "Ensuring unchanged command signature" {
		It "should have the expected parameter sets" {
			(Get-Command Stop-AxEnvironment).ParameterSets.Name | Should -Be 'Default', 'Pipeline'
		}
		
		It 'Should have the expected parameter Server' {
			$parameter = (Get-Command Stop-AxEnvironment).Parameters['Server']
			$parameter.Name | Should -Be 'Server'
			$parameter.ParameterType.ToString() | Should -Be System.String[]
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'Default', 'Pipeline'
			$parameter.ParameterSets.Keys | Should -Contain 'Default'
			$parameter.ParameterSets['Default'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['Default'].Position | Should -Be 1
			$parameter.ParameterSets['Default'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['Default'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['Default'].ValueFromRemainingArguments | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Contain 'Pipeline'
			$parameter.ParameterSets['Pipeline'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['Pipeline'].Position | Should -Be -2147483648
			$parameter.ParameterSets['Pipeline'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['Pipeline'].ValueFromPipelineByPropertyName | Should -Be $True
			$parameter.ParameterSets['Pipeline'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should have the expected parameter DisplayName' {
			$parameter = (Get-Command Stop-AxEnvironment).Parameters['DisplayName']
			$parameter.Name | Should -Be 'DisplayName'
			$parameter.ParameterType.ToString() | Should -Be System.String
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'Default'
			$parameter.ParameterSets.Keys | Should -Contain 'Default'
			$parameter.ParameterSets['Default'].IsMandatory | Should -Be $True
			$parameter.ParameterSets['Default'].Position | Should -Be 2
			$parameter.ParameterSets['Default'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['Default'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['Default'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should have the expected parameter Name' {
			$parameter = (Get-Command Stop-AxEnvironment).Parameters['Name']
			$parameter.Name | Should -Be 'Name'
			$parameter.ParameterType.ToString() | Should -Be System.String[]
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'Pipeline'
			$parameter.ParameterSets.Keys | Should -Contain 'Pipeline'
			$parameter.ParameterSets['Pipeline'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['Pipeline'].Position | Should -Be -2147483648
			$parameter.ParameterSets['Pipeline'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['Pipeline'].ValueFromPipelineByPropertyName | Should -Be $True
			$parameter.ParameterSets['Pipeline'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should have the expected parameter ShowOriginalOutput' {
			$parameter = (Get-Command Stop-AxEnvironment).Parameters['ShowOriginalOutput']
			$parameter.Name | Should -Be 'ShowOriginalOutput'
			$parameter.ParameterType.ToString() | Should -Be System.Management.Automation.SwitchParameter
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be '__AllParameterSets'
			$parameter.ParameterSets.Keys | Should -Contain '__AllParameterSets'
			$parameter.ParameterSets['__AllParameterSets'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].Position | Should -Be -2147483648
			$parameter.ParameterSets['__AllParameterSets'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should have the expected parameter Force' {
			$parameter = (Get-Command Stop-AxEnvironment).Parameters['Force']
			$parameter.Name | Should -Be 'Force'
			$parameter.ParameterType.ToString() | Should -Be System.Management.Automation.SwitchParameter
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be '__AllParameterSets'
			$parameter.ParameterSets.Keys | Should -Contain '__AllParameterSets'
			$parameter.ParameterSets['__AllParameterSets'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].Position | Should -Be -2147483648
			$parameter.ParameterSets['__AllParameterSets'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].ValueFromRemainingArguments | Should -Be $False
		}
	}
	
	Describe "Testing parameterset Default" {
		<#
		Default -DisplayName
		Default -Server -DisplayName -ShowOriginalOutput -Force
		#>
	}
 	Describe "Testing parameterset Pipeline" {
		<#
		Pipeline -
		Pipeline -Server -Name -ShowOriginalOutput -Force
		#>
	}

}