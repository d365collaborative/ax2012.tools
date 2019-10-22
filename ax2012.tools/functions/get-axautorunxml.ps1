function Get-AxAutoRunXml {
    [CmdletBinding()]
    param (

        [String] $OutputPath,

        [String] $LogFile,

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