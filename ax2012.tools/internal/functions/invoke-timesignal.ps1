<#
.SYNOPSIS
Invoke timing logic

.DESCRIPTION
Invoke timing logic that keeps track of the time spend inside a function

.PARAMETER Start
Switch to instruct the cmdlet that the starting of measurement

.PARAMETER End
Switch to instruct the cmdlet that the ending of measurement

.EXAMPLE
PS C:\> Invoke-TimeSignal -Start

This will start the timing measurement.

.EXAMPLE
PS C:\> Invoke-TimeSignal -End

This will end the timing measurement and have the cmdlet write the details into the verbose log.

.NOTES
Author: Mötz Jensen (@Splaxi)

#>
function Invoke-TimeSignal {
    [CmdletBinding(DefaultParameterSetName = 'Start')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Start', Position = 1 )]
        [switch] $Start,
        
        [Parameter(Mandatory = $True, ParameterSetName = 'End', Position = 2 )]
        [switch] $End
    )
    $Time = (Get-Date)

    $Command = (Get-PSCallStack)[1].Command

    if($Start.IsPresent) {
        if($Script:TimeSignals.ContainsKey($Command)) {
            Write-PSFMessage -Level Verbose -Message "The command '$Command' was already taking part in time measurement. The entry has been update with current date and time."
            $Script:TimeSignals[$Command] = $Time
        }
        else{
            $Script:TimeSignals.Add($Command, $Time)
        }
    }
    else{
        if($Script:TimeSignals.ContainsKey($Command)) {
            $TimeSpan = New-TimeSpan -End $Time -Start (($Script:TimeSignals)[$Command])

            Write-PSFMessage -Level Verbose -Message "Total time spent inside the function was $TimeSpan" -Target $TimeSpan -FunctionName $Command -Tag "TimeSignal"
            $Script:TimeSignals.Remove($Command)
        }
        else {
            Write-PSFMessage -Level Verbose -Message "The command '$Command' was never started to take part in time measurement."
        }
    }
}
