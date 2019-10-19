<#
.SYNOPSIS
Clear AX 2012 AOS Server Cache Objects

.DESCRIPTION
Remove AX 2012 AOS Server Cache Object files from the file system

.PARAMETER ObjectType
The type of cache object that you want to remove

Valid options are:
XppIL
Label
VSAssemblies

.PARAMETER InstanceName
        Name of the instance that you are working against
    
        Default value can be configured with the Set-AxActiveAosConfig cmdlet

.PARAMETER ListOnly
Instruct the cmdlet to only list the files that matches your selection from the other parameters

.EXAMPLE
PS C:\> Clear-AxServerCacheObjects -ObjectType "XppIL" -InstanceName "AXTEST" -ListOnly

This will list all the XppIL files under the AXTEST AOS Instance location.
It will work against the ObjectType "XppIL".
It will work againt the InstanceName "AXTEST".
It will only list the files and folders, it will NOT delete anything.

.EXAMPLE
PS C:\> Clear-AxServerCacheObjects -ObjectType "XppIL" -InstanceName "AXTEST"

This will delete all the XppIL files under the AXTEST AOS Instance location.
It will work against the ObjectType "XppIL".
It will work againt the InstanceName "AXTEST".

It WILL delete the files without further warning or notification!

.EXAMPLE
PS C:\> Clear-AxServerCacheObjects -ObjectType "XppIL","Label","VSAssemblies" -InstanceName "AXTEST"

This will delete all the XppIL,Label and VSAssemblies files under the AXTEST AOS Instance location.
It will work against the ObjectType "XppIL","Label","VSAssemblies".
It will work againt the InstanceName "AXTEST".

It WILL delete the files without further warning or notification!

.NOTES
Tags: Client Cache, Cache, Label, XppIL, VSAssemblies

Author: Mötz Jensen (@Splaxi)

All credits goes to Kenneth Madsen (@KennethGrupp) for providing detailed examples on how to achieve this the best way using powershell

#>

function Clear-AxServerCacheObjects {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    param (
        [string[]] $ObjectType,

        [string] $InstanceName = $Script:ActiveAosInstancename,

        [switch] $ListOnly
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

    $basePath = (Get-AxAosInstance -InstanceName $InstanceName).BinDirectory

    $parms = @{}
    foreach ($item in $ObjectType) {
        switch ($item.ToUpper()) {
            "XPPIL" {
                Write-PSFMessage -Level Verbose -Message "Working against cache object type: `"XppIL`""

                $parms.Path = (Join-Path $basePath "XppIL")
                $parms.Include = "*.*"
            }
            "LABEL" {
                Write-PSFMessage -Level Verbose -Message "Working against cache object type: `"Label`""
                
                $parms.Path = (Join-Path $basePath "Application\appl\standard\ax*.*")
            }
            "VSASSEMBLIES" {
                Write-PSFMessage -Level Verbose -Message "Working against cache object type: `"VSAssemblies`""
                
                $parms.Path = (Join-Path $basePath "VSAssemblies\*.*")
            }
        }

        Write-PSFMessage -Level Verbose -Message "Working against path: $($parms.Path)" -Target $parms.Path
        
        if ($ListOnly) {
            Get-ChildItem @parms -Recurse
        }
        else {
            Remove-Item @parms -Recurse -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
        }
    }
}