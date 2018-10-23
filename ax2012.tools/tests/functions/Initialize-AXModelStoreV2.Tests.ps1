Describe "Initialize-AXModelStoreV2 Unit Tests" -Tag "Unit" {
	BeforeAll {
		# Place here all things needed to prepare for the tests
	}
	AfterAll {
		# Here is where all the cleanup tasks go
	}
	
	Describe "Ensuring unchanged command signature" {
		It "should have the expected parameter sets" {
			(Get-Command Initialize-AXModelStoreV2).ParameterSets.Name | Should -Be 'CreateSchema', 'Drop', 'CreateDB'
		}
		
		It 'Should habe the expected parameter DatabaseServer' {
			$parameter = (Get-Command Initialize-AXModelStoreV2).Parameters['DatabaseServer']
			$parameter.Name | Should -Be 'DatabaseServer'
			$parameter.ParameterType.ToString() | Should -Be System.String
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be '__AllParameterSets'
			$parameter.ParameterSets.Keys | Should -Contain '__AllParameterSets'
			$parameter.ParameterSets['__AllParameterSets'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].Position | Should -Be -2147483648
			$parameter.ParameterSets['__AllParameterSets'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should habe the expected parameter ModelstoreDatabase' {
			$parameter = (Get-Command Initialize-AXModelStoreV2).Parameters['ModelstoreDatabase']
			$parameter.Name | Should -Be 'ModelstoreDatabase'
			$parameter.ParameterType.ToString() | Should -Be System.String
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be '__AllParameterSets'
			$parameter.ParameterSets.Keys | Should -Contain '__AllParameterSets'
			$parameter.ParameterSets['__AllParameterSets'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].Position | Should -Be -2147483648
			$parameter.ParameterSets['__AllParameterSets'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['__AllParameterSets'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should habe the expected parameter SchemaName' {
			$parameter = (Get-Command Initialize-AXModelStoreV2).Parameters['SchemaName']
			$parameter.Name | Should -Be 'SchemaName'
			$parameter.ParameterType.ToString() | Should -Be System.String
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'CreateSchema', 'Drop'
			$parameter.ParameterSets.Keys | Should -Contain 'CreateSchema'
			$parameter.ParameterSets['CreateSchema'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['CreateSchema'].Position | Should -Be -2147483648
			$parameter.ParameterSets['CreateSchema'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['CreateSchema'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['CreateSchema'].ValueFromRemainingArguments | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Contain 'Drop'
			$parameter.ParameterSets['Drop'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['Drop'].Position | Should -Be -2147483648
			$parameter.ParameterSets['Drop'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['Drop'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['Drop'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should habe the expected parameter DropSchema' {
			$parameter = (Get-Command Initialize-AXModelStoreV2).Parameters['DropSchema']
			$parameter.Name | Should -Be 'DropSchema'
			$parameter.ParameterType.ToString() | Should -Be System.Management.Automation.SwitchParameter
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'Drop'
			$parameter.ParameterSets.Keys | Should -Contain 'Drop'
			$parameter.ParameterSets['Drop'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['Drop'].Position | Should -Be -2147483648
			$parameter.ParameterSets['Drop'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['Drop'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['Drop'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should habe the expected parameter CreateSchema' {
			$parameter = (Get-Command Initialize-AXModelStoreV2).Parameters['CreateSchema']
			$parameter.Name | Should -Be 'CreateSchema'
			$parameter.ParameterType.ToString() | Should -Be System.Management.Automation.SwitchParameter
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'CreateSchema'
			$parameter.ParameterSets.Keys | Should -Contain 'CreateSchema'
			$parameter.ParameterSets['CreateSchema'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['CreateSchema'].Position | Should -Be -2147483648
			$parameter.ParameterSets['CreateSchema'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['CreateSchema'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['CreateSchema'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should habe the expected parameter CreateDb' {
			$parameter = (Get-Command Initialize-AXModelStoreV2).Parameters['CreateDb']
			$parameter.Name | Should -Be 'CreateDb'
			$parameter.ParameterType.ToString() | Should -Be System.Management.Automation.SwitchParameter
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'CreateDB'
			$parameter.ParameterSets.Keys | Should -Contain 'CreateDB'
			$parameter.ParameterSets['CreateDB'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['CreateDB'].Position | Should -Be -2147483648
			$parameter.ParameterSets['CreateDB'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['CreateDB'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['CreateDB'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should habe the expected parameter GenerateScript' {
			$parameter = (Get-Command Initialize-AXModelStoreV2).Parameters['GenerateScript']
			$parameter.Name | Should -Be 'GenerateScript'
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
	
	Describe "Testing parameterset CreateSchema" {
		<#
		CreateSchema -
		CreateSchema -DatabaseServer -ModelstoreDatabase -SchemaName -CreateSchema -GenerateScript
		#>
	}
 	Describe "Testing parameterset Drop" {
		<#
		Drop -
		Drop -DatabaseServer -ModelstoreDatabase -SchemaName -DropSchema -GenerateScript
		#>
	}
 	Describe "Testing parameterset CreateDB" {
		<#
		CreateDB -
		CreateDB -DatabaseServer -ModelstoreDatabase -CreateDb -GenerateScript
		#>
	}

}