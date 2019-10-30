
<#
    .SYNOPSIS
        Get the autorun xml element
        
    .DESCRIPTION
        Get the correct autorun xml element based on the action that you want to perform
        
    .PARAMETER Action
        The action name that you want to execute when running the autorun feature of the AX 2012 Client
        
        Valid options are:
        "CompileCilFull"
        "CompileCilIncremental"
        "CompileXpp"
        "CompileXppAndXRef"
        "SynchronizeDB"
        
    .EXAMPLE
        PS C:\> Get-AutoRunXML -Action "SynchronizeDB"
        
        This will return the correct XML element for "SynchronizeDB".
        
    .NOTES
        Tags:
        
        Author: Mötz Jensen (@Splaxi)
        
        #https://docs.microsoft.com/en-us/previous-versions/dynamics/ax-2012/application-classes/gg922801%28v%3dax.60%29
#>

function Get-AutoRunXML {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [String] $Action
    )
     
    $res = ""

    switch ($Action) {
        "SynchronizeDB" {
            $res = '<Synchronize syncDb="true"/>'
            # $element = $xml.CreateElement('Synchronize')
            # $element.SetAttribute("syncDb", "true")
        }

        "SynchronizeRoles" {
            # $res = '<Synchronize "syncDb"="true"/>'
            # $element = $xml.CreateElement('Synchronize')
            # $element.SetAttribute("syncRoles", "true")
        }

        "CompileCilFull" {
            $res = '<CompileIL incremental="false"/>'
            # $element = $xml.CreateElement('CompileIL')
            # $element.SetAttribute("incremental", "false")
        }

        "CompileCilIncremental" {
            $res = '<CompileIL incremental="true"/>'
            # $element = $xml.CreateElement('CompileIL')
            # $element.SetAttribute("incremental", "true")
        }

        "CompileXpp" {
            $res = '<CompileApplication crossReference="false"/>'
            # $element = $xml.CreateElement('CompileApplication')
            # $element.SetAttribute("crossReference", "false")
        }

        "CompileXppAndXRef" {
            $res = '<CompileApplication crossReference="true"/>'
            # $element = $xml.CreateElement('CompileApplication')
            # $element.SetAttribute("crossReference", "true")
        }
    }

    $res
}