Describe "Import-AXModelStoreV2 Unit Tests" -Tag "Unit" {
	BeforeAll {
		# Place here all things needed to prepare for the tests
	}
	AfterAll {
		# Here is where all the cleanup tasks go
	}
	
	Describe "Ensuring unchanged command signature" {
		It "should have the expected parameter sets" {
			(Get-Command Import-AXModelStoreV2).ParameterSets.Name | Should -Be 'ImportModelstore', 'ApplyModelstore', 'Generate'
		}
		
		It 'Should have the expected parameter DatabaseServer' {
			$parameter = (Get-Command Import-AXModelStoreV2).Parameters['DatabaseServer']
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
		It 'Should have the expected parameter ModelstoreDatabase' {
			$parameter = (Get-Command Import-AXModelStoreV2).Parameters['ModelstoreDatabase']
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
		It 'Should have the expected parameter SchemaName' {
			$parameter = (Get-Command Import-AXModelStoreV2).Parameters['SchemaName']
			$parameter.Name | Should -Be 'SchemaName'
			$parameter.ParameterType.ToString() | Should -Be System.String
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'ApplyModelstore', 'ImportModelstore'
			$parameter.ParameterSets.Keys | Should -Contain 'ApplyModelstore'
			$parameter.ParameterSets['ApplyModelstore'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['ApplyModelstore'].Position | Should -Be -2147483648
			$parameter.ParameterSets['ApplyModelstore'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['ApplyModelstore'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['ApplyModelstore'].ValueFromRemainingArguments | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Contain 'ImportModelstore'
			$parameter.ParameterSets['ImportModelstore'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].Position | Should -Be -2147483648
			$parameter.ParameterSets['ImportModelstore'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should have the expected parameter Path' {
			$parameter = (Get-Command Import-AXModelStoreV2).Parameters['Path']
			$parameter.Name | Should -Be 'Path'
			$parameter.ParameterType.ToString() | Should -Be System.String
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'ImportModelstore'
			$parameter.ParameterSets.Keys | Should -Contain 'ImportModelstore'
			$parameter.ParameterSets['ImportModelstore'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].Position | Should -Be -2147483648
			$parameter.ParameterSets['ImportModelstore'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should have the expected parameter IdConflictMode' {
			$parameter = (Get-Command Import-AXModelStoreV2).Parameters['IdConflictMode']
			$parameter.Name | Should -Be 'IdConflictMode'
			$parameter.ParameterType.ToString() | Should -Be System.String
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'ImportModelstore'
			$parameter.ParameterSets.Keys | Should -Contain 'ImportModelstore'
			$parameter.ParameterSets['ImportModelstore'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].Position | Should -Be -2147483648
			$parameter.ParameterSets['ImportModelstore'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['ImportModelstore'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should have the expected parameter Apply' {
			$parameter = (Get-Command Import-AXModelStoreV2).Parameters['Apply']
			$parameter.Name | Should -Be 'Apply'
			$parameter.ParameterType.ToString() | Should -Be System.Management.Automation.SwitchParameter
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'ApplyModelstore'
			$parameter.ParameterSets.Keys | Should -Contain 'ApplyModelstore'
			$parameter.ParameterSets['ApplyModelstore'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['ApplyModelstore'].Position | Should -Be -2147483648
			$parameter.ParameterSets['ApplyModelstore'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['ApplyModelstore'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['ApplyModelstore'].ValueFromRemainingArguments | Should -Be $False
		}
		It 'Should have the expected parameter ShowOriginalProgress' {
			$parameter = (Get-Command Import-AXModelStoreV2).Parameters['ShowOriginalProgress']
			$parameter.Name | Should -Be 'ShowOriginalProgress'
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
		It 'Should have the expected parameter OutputCommandOnly' {
			$parameter = (Get-Command Import-AXModelStoreV2).Parameters['OutputCommandOnly']
			$parameter.Name | Should -Be 'OutputCommandOnly'
			$parameter.ParameterType.ToString() | Should -Be System.Management.Automation.SwitchParameter
			$parameter.IsDynamic | Should -Be $False
			$parameter.ParameterSets.Keys | Should -Be 'Generate'
			$parameter.ParameterSets.Keys | Should -Contain 'Generate'
			$parameter.ParameterSets['Generate'].IsMandatory | Should -Be $False
			$parameter.ParameterSets['Generate'].Position | Should -Be -2147483648
			$parameter.ParameterSets['Generate'].ValueFromPipeline | Should -Be $False
			$parameter.ParameterSets['Generate'].ValueFromPipelineByPropertyName | Should -Be $False
			$parameter.ParameterSets['Generate'].ValueFromRemainingArguments | Should -Be $False
		}
	}
	
	Describe "Testing parameterset ImportModelstore" {
		<#
		ImportModelstore -
		ImportModelstore -DatabaseServer -ModelstoreDatabase -SchemaName -Path -IdConflictMode -ShowOriginalProgress
		#>
	}
 	Describe "Testing parameterset ApplyModelstore" {
		<#
		ApplyModelstore -
		ApplyModelstore -DatabaseServer -ModelstoreDatabase -SchemaName -Apply -ShowOriginalProgress
		#>
	}
 	Describe "Testing parameterset Generate" {
		<#
		Generate -
		Generate -DatabaseServer -ModelstoreDatabase -ShowOriginalProgress -OutputCommandOnly
		#>
	}

}