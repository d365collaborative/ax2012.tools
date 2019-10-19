<#
.SYNOPSIS
Clear AX 2012 Client Cache Objects

.DESCRIPTION
Remove AX 2012 Client Cache Object files from the file system

.PARAMETER ObjectType
The type of cache object that you want to remove

Valid options are:
AUC
KTI
VSAssemblies

.PARAMETER UserLocation
Decide which user location that you want to work against

Do you want to remove the cache objects from the current user or all users?

Valid options are:
CurrentUser
AllUsers

.PARAMETER ListOnly
Instruct the cmdlet to only list the files that matches your selection from the other parameters

.EXAMPLE
PS C:\> Clear-AxClientCacheObjects -ObjectType "Auc" -UserLocation "CurrentUser" -ListOnly

This will list all the Auc files under the current user location.
It will work against the ObjectType "Auc".
It will work againt the UserLocation "CurrentUser".
It will only list the files and folders, it will NOT delete anything.

.EXAMPLE
PS C:\> Clear-AxClientCacheObjects -ObjectType "Auc" -UserLocation "CurrentUser"

This will delete all the Auc files under the current user location.
It will work against the ObjectType "Auc".
It will work againt the UserLocation "CurrentUser".

It WILL delete the files without further warning or notification!

.EXAMPLE
PS C:\> Clear-AxClientCacheObjects -ObjectType "Auc" -UserLocation "AllUsers"

This will delete all the Auc files under all users locations.
It will work against the ObjectType "Auc".
It will work againt the UserLocation "AllUsers".

It WILL delete the files without further warning or notification!

.EXAMPLE
PS C:\> Clear-AxClientCacheObjects -ObjectType "Auc","Kti", "VSAssemblies" -UserLocation "CurrentUser"

This will delete all the Auc,Kti and VSAssemblies files under the current user location.
It will work against the ObjectType "Auc","Kti","VSAssemblies".
It will work againt the UserLocation "CurrentUser".

It WILL delete the files without further warning or notification!

.NOTES
Tags: Client Cache, Cache, KTI, AUC

Author: Mötz Jensen (@Splaxi)

All credits goes to Kenneth Madsen for providing detailed examples on how to achieve this the best way using powershell

#>

function Clear-AxClientCacheObjects {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    param (
        [string[]] $ObjectType,

        [string] $UserLocation,

        [switch] $ListOnly
    )
    
    $basePath = ""

    switch ($UserLocation) {
        "CurrentUser" {
            Write-PSFMessage -Level Verbose -Message "CurrentUser path was selected as the location to clear."

            $basePath = $env:LocalAppData
          }
        "AllUsers" {
            Write-PSFMessage -Level Verbose -Message "AllUsers path was selected as the location to clear."

            $basePath = "$env:LocalAppData" -replace "$env:username", "*"
          }
    }

    $pathToClear = ""
    foreach ($item in $ObjectType) {
        switch ($item.ToUpper()) {
            "AUC" {
                Write-PSFMessage -Level Verbose -Message "Working against cache object type: `"AUC`""

                $pathToClear = Join-Path $basePath "*.auc"
             }
            "KTI" {
                Write-PSFMessage -Level Verbose -Message "Working against cache object type: `"KTI`""

                $pathToClear = Join-Path $basePath "*.kti"
              }
            "VSASSEMBLIES" {
                Write-PSFMessage -Level Verbose -Message "Working against cache object type: `"VSAssemblies`""

                $pathToClear = Join-Path $basePath "Microsoft\Dynamics Ax\VSAssemblies*\*"
             }
        }

        Write-PSFMessage -Level Verbose -Message "Working against path: $pathToClear" -Target $pathToClear
        
        if($ListOnly){
            Get-ChildItem -Path $pathToClear
        }
        else {
            Remove-Item -Path $pathToClear -Force
        }
    }
}