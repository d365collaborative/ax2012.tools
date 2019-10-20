
<#
    .SYNOPSIS
        Get hash values for XppIL files
        
    .DESCRIPTION
        Generate the file hash values for each *.netmodule & *.dll file in the XppIL folder
        
    .PARAMETER InstanceName
        Name of the instance that you are working against
        
        Default value can be configured with the Set-AxActiveAosConfig cmdlet
        
    .PARAMETER OutputPath
        Path to the folder where the output file must be saved
        
        Default value is: "C:\temp\ax2012.tools"
        
    .PARAMETER FileName
        Name of the output as you want it to be named
        
        If left empty the output file will be named based on the following pattern: "SERVERNAME_INSTANCENAME_XppIL_HashValue.txt"
        
    .EXAMPLE
        PS C:\> Get-AxServerXppILHash -InstanceName "AXTEST"
        
        This will generate the file hash values for the XppIL files for the AXTEST AOS Instance.
        It will work against the Instance AXTEST.
        It will save the output file to the default folder location "C:\temp\ax2012.tools".
        The file will named "SERVER_AXTEST_XppIL_HashValues.txt"
        
    .EXAMPLE
        PS C:\> Get-AxServerXppILHash
        
        This will generate the file hash values for the XppIL files for the default AOS Instance.
        It will work against the default AOS Instance that has been configured with Set-AxActiveAosConfig.
        It will save the output file to the default folder location "C:\temp\ax2012.tools".
        The file will named "SERVER_INSTANCENAME_XppIL_HashValues.txt"
        
        The default value of the instance name can be configured with the Set-AxActiveAosConfig cmdlet.
        
    .NOTES
        Tags: XppIL, Hash, Files
        
        Author: Mötz Jensen (@Splaxi)
        
        All credits goes to Kenneth Madsen (@KennethGrupp) for providing detailed examples on how to achieve this the best way using powershell
        
#>

function Get-AxServerXppILHash {
    [CmdletBinding()]
    param (
        [string] $InstanceName = $Script:ActiveAosInstancename,

        [string] $OutputPath = $Script:DefaultTempPath,

        [string] $FileName
    )
    
    if ([String]::IsNullOrEmpty($InstanceName)) {
        $messageString = "Instance name was <c='em'>empty</c>. You either need to supply it with <c='em'>-InstanceName</c> parameter or configure it using the <c='em'>Set-AxActiveAosConfig</c> cmdlet."
        Write-PSFMessage -Level Host -Message $messageString
        Stop-PSFFunction -Message "Stopping because of missing instance name parameter." -Exception $([System.Exception]::new($($messageString -replace '<[^>]+>', '')))
        return
    }

    if ($InstanceName -eq "*") {
        $messageString = "Instance name cannot be <c='em'>*</c>. You either need to supply an instance name that will only result in <c='em'>one</c> AOS instance."
        Write-PSFMessage -Level Host -Message $messageString
        Stop-PSFFunction -Message "Stopping because of missing instance name parameter." -Exception $([System.Exception]::new($($messageString -replace '<[^>]+>', '')))
        return
    }

    if (-not (Test-PathExists -Path $Path -Type Container -Create)) { return }

    Invoke-TimeSignal -Start

    if ([String]::IsNullOrEmpty($FileName)) {
        $filename = "$($env:COMPUTERNAME)_$InstanceName`_XppIL_HashValues.txt"
    }
    
    $outputFile = Join-Path $OutputPath $FileName

    Write-PSFMessage -Level Verbose -Message "Removing old output file: $outputFile" -Target $outputFile
    Remove-Item -Path $outputFile -Force -WarningAction SilentlyContinue -ErrorAction SilentlyContinue

    $basePath = (Get-AxAosInstance -InstanceName $InstanceName).BinDirectory

    $fileExtensions = @("*.netmodule", "*.dll")

    $searchPath = (Join-Path $basePath "XppIL")

    Write-PSFMessage -Level Verbose -Message "Working against the $InstanceName instance with the path: $searchPath" -Target $searchPath
    $xppFiles = Get-ChildItem -Path $searchPath -Include $fileExtensions -Recurse
    
    $resList = New-Object System.Collections.Generic.List[object]

    foreach ($item in $xppFiles) {
        $resList.Add($(Get-FileHash -Path $item.FullName))
    }

    Write-PSFMessage -Level Verbose -Message "Generating the hash values and saving the output to path: $outputFile" -Target $outputFile
    $resList.ToArray() | Sort-Object Path | Format-Table Hash, Path -Wrap -AutoSize | Out-String -Width 4000 | Out-File $outputFile -Encoding utf8

    Invoke-TimeSignal -End
}