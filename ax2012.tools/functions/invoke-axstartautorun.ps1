function Invoke-AxStartAutoRun {
    [CmdletBinding()]
    param (
        [string] $Action,

        [string] $OutputPath,

        [int] $TimeoutInMinute = 360
    )
    
    if($TimeoutInMinute -eq 0) {
        $TimeoutInMinute = [Int32]::MaxValue
    }
    
    [int] $millisecondFactor = 60000

#-development -internal=noModalBoxes 
#"-StartupCmd=autorun_{1}"
}