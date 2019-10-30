
<#
    .SYNOPSIS
        Get a valid Autorun XML file for AX 2012
        
    .DESCRIPTION
        Generate a valid Autorun XML file based on the selected parameters and have it saved on the disk
        
    .PARAMETER OutputPath
        The path where you want to store to autorun xml file
        
        The path must be a full path to a file
        
    .PARAMETER LogFile
        The path where you want the autorun process to save its log file
        
        The path must be a full path to a file
        
    .PARAMETER ExitWhenDone
        Instruct the autorun process wether you want it to exit the AX 2012 client when done or not
        
    .PARAMETER SynchronizeDB
        Instruct the autorun to do a synchronization of the database
        
    .PARAMETER CompileCilFull
        Instruct the autorun to do a full CIL compile
        
    .PARAMETER CompileCilIncremental
        Instruct the autorun to do a incremental CIL compile
        
    .PARAMETER CompileXpp
        Instruct the autorun to do a full X++ (Xpp) compile
        
    .PARAMETER CompileXppAndXRefUpdate
        Instruct the autorun to do a full X++ (Xpp) compile and do a full Cross Reference (XRef) update
        
    .EXAMPLE
        PS C:\> Get-AxAutoRunXml -ExitWhenDone -SynchronizeDB
        
        This will generate a valid Autorun xml file for synchronizing the database.
        It will use the default path "c:\temp\ax2012.tools\Autorun.xml" where the file will be stored.
        It will use the default path "c:\temp\ax2012.tools\Autorun_Output.txt" to instruct the Autorun where to save its log file.
        It will instruct the Autorun to exit when done.
        It will instruct the Autorun to do a synchronization of the database.
        
    .NOTES
        Tags:
        Author: Mötz Jensen (@Splaxi)
#>

function Get-AxAutoRunXml {
    [CmdletBinding()]
    param (

        [String] $OutputPath = (Join-Path $Script:DefaultTempPath "Autorun.xml"),

        [String] $LogFile = (Join-Path $Script:DefaultTempPath "Autorun_Output.txt"),

        [Switch] $ExitWhenDone,

        [Switch] $SynchronizeDB,

        [Switch] $CompileCilFull,

        [Switch] $CompileCilIncremental,
        
        [Switch] $CompileXpp,

        [Switch] $CompileXppAndXRefUpdate
        
    )

    $actions = New-Object System.Collections.Generic.List[string]
    
    if ($SynchronizeDB) {
        Write-PSFMessage -Level Verbose -Message "SynchronizeDB was added to the action list." -Target $SynchronizeDB
        $actions.Add("SynchronizeDB")
    }
    
    if ($CompileCilFull -or $CompileCilIncremental) {
        
        if ($CompileCilFull) {
            Write-PSFMessage -Level Verbose -Message "CompileCilFull was added to the action list." -Target $CompileCilFull
            $actions.Add("CompileCilFull")
        }
        else {
            Write-PSFMessage -Level Verbose -Message "CompileCilIncremental was added to the action list." -Target $CompileCilIncremental
            $actions.Add("CompileCilIncremental")
        }
    }

    if ($CompileXppAndXRefUpdate -or $CompileXpp) {
        
        if ($CompileXppAndXRefUpdate) {
            Write-PSFMessage -Level Verbose -Message "CompileXppAndXRefUpdate was added to the action list." -Target $CompileXppAndXRefUpdate
            $actions.Add("CompileXppAndXRef")
        }
        else {
            Write-PSFMessage -Level Verbose -Message "CompileXpp was added to the action list." -Target $CompileXpp
            $actions.Add("CompileXpp")
        }
    }

    $autoRunXml = New-Object System.Collections.Generic.List[string]

    foreach ($item in $actions.ToArray()) {
        $autoRunXml.Add($(Get-AutoRunXML -Action $item))
    }

    $resXml = (Get-Content "$script:ModuleRoot\internal\xml\autotemplate.xml") -join [Environment]::NewLine

    $resXml = $resXml.Replace("{{ExitWhenDone}}", $ExitWhenDone.ToBool().ToString())
    $resXml = $resXml.Replace("{{LogPath}}", $LogFile)

    $resXml = $resXml.Replace("{{Action}}", $($autoRunXml.ToArray() -join [Environment]::NewLine))

    $resXml | Out-File -FilePath $OutputPath -Encoding utf8

    
}