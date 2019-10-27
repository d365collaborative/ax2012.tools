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

.PARAMETER TimeoutInMinute
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
    [OutputType([System.String], ParameterSetName="Generate")]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string] $Path,

        [string] $AxClientExePath = $(Join-Path $Script:ClientBin "Ax32.exe"),

        [Int32] $TimeoutInMinutes = 360,

        [switch] $ShowOriginalProgress,

        [Parameter(ParameterSetName = "Generate")]
        [switch] $OutputCommandOnly,

        [switch] $EnableException
    )

    $executable = $AxClientExePath
    
    if (-not (Test-PathExists -Path $executable -Type Leaf)) { return }

    $params = New-Object System.Collections.Generic.List[string]

    $params.Add("-development")
    $params.Add("-internal=noModalBoxes")
    $params.Add("-StartupCmd=autorun_`"$Path`"")

    Invoke-Process -Executable $executable -Params $($params.ToArray()) -TimeoutInMinutes $TimeoutInMinutes -ShowOriginalProgress:$ShowOriginalProgress -OutputCommandOnly:$OutputCommandOnly -EnableException:$EnableException
}