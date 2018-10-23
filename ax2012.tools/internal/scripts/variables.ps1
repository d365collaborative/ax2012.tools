$Script:TimeSignals = @{}

Write-PSFMessage -Level Verbose -Message "Gathering all variables to assist the different cmdlets to function"

$Script:AxPowerShellModule = "C:\Program Files\Microsoft Dynamics AX\60\ManagementUtilities\Microsoft.Dynamics.ManagementUtilities.ps1"

$Script:RegistryAos = "HKLM:\SYSTEM\ControlSet001\Services\Dynamics Server\6.0"

$Script:RegistryClient = "HKCU:\Software\Microsoft\Dynamics\6.0\Configuration"

[System.Collections.ArrayList] $layerList = New-Object System.Collections.ArrayList
$Script:LayerDictionary = @{"ISV" = "01."; "ISP" = "02."; "VAR" = "03."; "VAP" = "04."; "CUS" = "05."; "CUP" = "06."; "USR" = "07." ; "USP" = "08."}

$Script:ClientBin = Get-ClientBinDir

#Microsoft.Dynamics.BusinessConnectorNet.dll

foreach ($item in (Get-PSFConfig -FullName ax2012.tools.active*)) {
    $nameTemp = $item.FullName -replace "^ax2012.tools.", ""
    $name = ($nameTemp -Split "\." | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) } ) -Join ""
    
    New-Variable -Name $name -Value $item.Value -Scope Script
}

$maskOutput = @(
    "AccessToken"
)

foreach ($item in (Get-Variable -Scope Script)) {
    $val = $null

    if ($maskOutput -contains $($item.Name)) {
        $val = "The variable was found - but the content masked while outputting."
    }
    else {
        $val = $($item.Value)
    }
    
    Write-PSFMessage -Level Verbose -Message "$($item.Name) - $val" -Target $val
}

Write-PSFMessage -Level Verbose -Message "Finished outputting all the variable content."