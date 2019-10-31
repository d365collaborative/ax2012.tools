
<#
    .SYNOPSIS
        Execute the AutoRun feature of the AX 2012 Client
        
    .DESCRIPTION
        AX 2012 offers several ways to automate some core developer tasks, like DB Sync & Xpp Compile
        
    .PARAMETER Path
        Path to the autorun xml file that contains the desired automation tasks that you want to execute
        
    .PARAMETER AxClientExePath
        Path to the AX 2012 Client (ax32.exe) file, which is needed to run the automated tasks
        
        The default value is read from the registry on the local machine
        
    .PARAMETER TimeoutInMinutes
        Number of minutes the autorun task is allowed to run, before you want it to exit
        
        Default value is: 360 minutes (6 hours)
        
    .PARAMETER ShowOriginalProgress
        Instruct the cmdlet to show the standard output in the console
        
        Default is $false which will silence the standard output
        
    .PARAMETER OutputCommandOnly
        Instruct the cmdlet to only generate the needed command and not execute it
        
    .PARAMETER EnableException
        This parameters disables user-friendly warnings and enables the throwing of exceptions
        This is less user friendly, but allows catching exceptions in calling scripts
        
    .EXAMPLE
        PS C:\> Invoke-AxStartAutoRun -Path "c:\temp\ax2012.tools\autorun_syncDB.xml"
        
        This will invoke the autorun feature of the AX 2012 client.
        It will use the "c:\temp\ax2012.tools\autorun_syncDB.xml" as path passed to the AX 2012 Client.
        It will use the default path of the AX 2012 Client, read from the registry.
        It will run for a maximum of 360 minutes.
        
    .NOTES
        Tags:
        
        Author: Mötz Jensen (@Splaxi)
        
#>

function Invoke-AxStartAutoRun {
    [CmdletBinding()]
    [OutputType([System.String], ParameterSetName = "Generate")]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('AutoRunXml')]
        [string] $Path,

        [string] $AxClientExePath = $(Join-Path $Script:ClientBin "Ax32.exe"),

        [Int32] $TimeoutInMinutes = 360,

        [switch] $ShowOriginalProgress,

        [Parameter(ParameterSetName = "Generate")]
        [switch] $OutputCommandOnly,

        [switch] $EnableException
    )

    $executable = $AxClientExePath
    $logPath = ""

    if (-not (Test-PathExists -Path $Path, $executable, $AxClientExePath -Type Leaf)) { return }

    if (Test-PSFFunctionInterrupt) { return }

    $autoRunNode = Select-Xml -Path $Path -XPath "//AxaptaAutoRun"
    
    if ([System.IO.Path]::HasExtension($($autoRunNode.Node.logFile))) {
        $logPath = $autoRunNode.Node.logFile
        $parentPath = Split-Path -Path $logPath -Parent

        if (-not (Test-PathExists -Path $parentPath -Type Container -Create)) { return }

        if (Test-PSFFunctionInterrupt) { return }
    }

    $params = New-Object System.Collections.Generic.List[string]

    $params.Add("-development")
    $params.Add("-internal=noModalBoxes")
    $params.Add("-StartupCmd=autorun_`"$Path`"")

    Invoke-Process -Executable $executable -Params $($params.ToArray()) -TimeoutInMinutes $TimeoutInMinutes -ShowOriginalProgress:$ShowOriginalProgress -OutputCommandOnly:$OutputCommandOnly -EnableException:$EnableException

    if (-not ($OutputCommandOnly)) {
        # [string]$logString = Get-Content -Path $logPath -Raw

        # [xml]$outputContent = $logString.Replace("&", "&amp;")

        # $stringWriter = New-Object System.IO.StringWriter

        # $xmlSettings = New-object System.Xml.XmlWriterSettings
        # $xmlSettings.Encoding = [System.Text.Encoding]::UTF8
        # $xmlSettings.Indent = $true
        # $xmlSettings.NewLineHandling = [System.Xml.NewLineHandling]::Entitize
        
        # $xmlWriter = [System.Xml.XmlWriter]::Create($stringWriter, $xmlSettings)
        
        # # $xmlWriter.Indentation = 4
        
        # $outputContent.WriteTo($xmlWriter)
        # $xmlWriter.Flush()
        # $stringWriter.Flush()
        # $outputContent.LoadXml($stringWriter.ToString())
        # $outputContent.Save($logPath)

        [PSCustomObject]@{
            Path = $logPath
        }
    }
}