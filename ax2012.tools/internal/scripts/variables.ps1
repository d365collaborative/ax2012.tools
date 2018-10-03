$Script:TimeSignals = @{}

Write-PSFMessage -Level Verbose -Message "Gathering all variables to assist the different cmdlets to function"

$Script:AxPowerShellModule = "C:\Program Files\Microsoft Dynamics AX\60\ManagementUtilities\Microsoft.Dynamics.ManagementUtilities.ps1"

$Script:RegistryAos = "HKLM:\SYSTEM\ControlSet001\Services\Dynamics Server\6.0"