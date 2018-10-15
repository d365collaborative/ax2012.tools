$Script:TimeSignals = @{}

Write-PSFMessage -Level Verbose -Message "Gathering all variables to assist the different cmdlets to function"

$Script:AxPowerShellModule = "C:\Program Files\Microsoft Dynamics AX\60\ManagementUtilities\Microsoft.Dynamics.ManagementUtilities.ps1"

$Script:RegistryAos = "HKLM:\SYSTEM\ControlSet001\Services\Dynamics Server\6.0"

$Script:RegistryClient = "HKCU:\Software\Microsoft\Dynamics\6.0\Configuration"

[System.Collections.ArrayList] $layerList = New-Object System.Collections.ArrayList
$Script:LayerDictionary = @{"ISV" = "01."; "ISP" = "02."; "VAR" = "03."; "VAP" = "04."; "CUS" = "05."; "CUP" = "06."; "USR" = "07." ; "USP" = "08."}