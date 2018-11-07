$Script:TimeSignals = @{}

Write-PSFMessage -Level Verbose -Message "Gathering all variables to assist the different cmdlets to function" -FunctionName "Variables.ps1"

$Script:IsAdminRuntime = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$Script:AxPowerShellModule = "C:\Program Files\Microsoft Dynamics AX\60\ManagementUtilities\Microsoft.Dynamics.ManagementUtilities.ps1"

$Script:RegistryAos = "HKLM:\SYSTEM\ControlSet001\Services\Dynamics Server\6.0"

$Script:RegistryClient = "HKCU:\Software\Microsoft\Dynamics\6.0\Configuration"

$Script:LayerDictionary = @{"ISV" = "01."; "ISP" = "02."; "VAR" = "03."; "VAP" = "04."; "CUS" = "05."; "CUP" = "06."; "USR" = "07." ; "USP" = "08."}

$Script:ClientBin = Get-ClientBinDir

#Microsoft.Dynamics.BusinessConnectorNet.dll

Update-ActiveVariables

$Script:DefaultTempPath = "c:\temp\ax2012.tools"

# ActiveAosAosPort -
# ActiveAosBindirectory -
# ActiveAosComputername -
# ActiveAosDatabase -
# ActiveAosInstancename -
# ActiveAosInstanceNumber -
# ActiveAosModelstoredatabase -
# ActiveAosNettcpPort -
# ActiveAosWsdlPort -

$maskOutput = @(
    "AccessToken"
)

(Get-Variable -Scope Script) | ForEach-Object {
    $val = $null

    if ($maskOutput -contains $($_.Name)) {
        $val = "The variable was found - but the content masked while outputting."
    }
    else {
        $val = $($_.Value)
    }
   
    Write-PSFMessage -Level Verbose -Message "$($_.Name) - $val" -Target $val -FunctionName "Variables.ps1"
}

Write-PSFMessage -Level Verbose -Message "Finished outputting all the variable content." -FunctionName "Variables.ps1"