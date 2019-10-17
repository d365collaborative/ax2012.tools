
<#
    .SYNOPSIS
        Get Management Reporter 2012 Instance
        
    .DESCRIPTION
        Get Management Reporter 2012 Instance details from the local machine
        
    .EXAMPLE
        PS C:\> Get-AxMr2012Instance
        
        This will output all the core Management Reporter details on the machine.
        
    .NOTES
        Author: Mötz Jensen (@Splaxi)
        
#>
function Get-AxMr2012Instance {
    [CmdletBinding()]
    Param()
    
    $RegistryPath = $Script:RegistryMr2012
    $RegKey = Get-Item -Path $RegistryPath.Replace("HKEY_LOCAL_MACHINE", "HKLM:")
    $RegOuter = Get-ItemProperty -Path ($RegKey.Name).Replace("HKEY_LOCAL_MACHINE", "HKLM:")

    $res = [Ordered]@{ }

    $res.BinDirectory = Join-Path $RegOuter.InstallLocation Server

    if (Test-PathExists -Path $Script:Mr2012DeploymentLogsPath -Type Container) {
        $res.DeploymentLogsPath = $Script:Mr2012DeploymentLogsPath
    }

    $configPath = Join-Path $res.BinDirectory $Script:Mr2012ConfigPath
    $serviceConfigPath = Join-Path $res.BinDirectory $Script:Mr2012ServiceConfigPath

    if (-not (Test-PathExists -Path $configPath, $serviceConfigPath -Type Leaf)) { return }

    if (Test-PSFFunctionInterrupt) { return }

    $configXmlString = Get-Content -Path $configPath

    $configXmlString -split ";" | ForEach-Object {
        $tempArray = $_.ToString().Split("=")

        switch -Wildcard  ($_) {
            "*Data Source=*" {
                $res.DatabaseServer = $tempArray[$tempArray.Length - 1]
            }
            "*Initial Catalog=*" {
                $res.Database = $tempArray[$tempArray.Length - 1]
                
            }
        }
    }

    $serviceConfigXmlString = Get-Content -Path $serviceConfigPath

    $serviceConfigXmlString -split "<" | ForEach-Object {
        $tempArray = $_.ToString().Split("=")

        switch -Wildcard  ($_) {
            "*DefaultHttpBaseAddress*" {
                $tempString = $tempArray[$tempArray.Length - 1]
                
                $res.HttpAddress = $tempString.Substring(0, $tempString.LastIndexOf('"')) -replace '"', ''
            }
        }
    }

    [PSCustomObject]$res | Select-PSFObject -TypeName "AX2012.TOOLS.Mr2012.Config"
}