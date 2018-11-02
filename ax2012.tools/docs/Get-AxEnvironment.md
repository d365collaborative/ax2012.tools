---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxEnvironment

## SYNOPSIS
Get the status of an AX 2012 environment

## SYNTAX

### Default (Default)
```
Get-AxEnvironment [-ComputerName <String[]>] [-AllAxServices] [-AosInstanceName <String>] [-ScanAllAosServices]
 [-PipelineOutput] [<CommonParameters>]
```

### Specific
```
Get-AxEnvironment [-ComputerName <String[]>] [-AosInstanceName <String>] [-Aos] [-ManagementReporter] [-DIXF]
 [-ScanAllAosServices] [-PipelineOutput] [<CommonParameters>]
```

## DESCRIPTION
Get the status of AX 2012 services in your environment

## EXAMPLES

### EXAMPLE 1
```
Get-AxEnvironment
```

This will get the status for all the default services from your environment.
If AxActiveAosConfiguration has been configured, it will work against the ComputerName and AosInstanceName registered.

### EXAMPLE 2
```
Get-AxEnvironment -ScanAllAosServices
```

This will scan for all available AOS Services.
If AxActiveAosConfiguration has been configured, it will work against the ComputerName registered otherwise localhost is used.

### EXAMPLE 3
```
Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos -PipelineOutput
```

This will get all AOS instances from the server named "TEST-AOS-01".
If AxActiveAosConfiguration has been configured, it will work against the AosInstanceName registered otherwise it will find all.

### EXAMPLE 4
```
Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos -AosInstanceName *DEV*
```

This will get all AOS instances that match the search pattern "*DEV*" from the server named "TEST-AOS-01".

### EXAMPLE 5
```
Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos -PipelineOutput | Start-AxEnvironment -ShowOutput
```

This will scan the "TEST-AOS-01" server for all AOS instances and start them.
It will show the status for the service(s) on the server afterwards.

### EXAMPLE 6
```
Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos -PipelineOutput | Stop-AxEnvironment -ShowOutput
```

This will scan the "TEST-AOS-01" server for all AOS instances and stop them.
It will show the status for the service(s) on the server afterwards.

## PARAMETERS

### -ComputerName
Name of the computer(s) that you want to work against

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Server

Required: False
Position: Named
Default value: $Script:ActiveAosComputername
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllAxServices
Switch to instruct the cmdlet to include all known AX 2012 services

```yaml
Type: SwitchParameter
Parameter Sets: Default
Aliases:

Required: False
Position: 3
Default value: [switch]::Present
Accept pipeline input: False
Accept wildcard characters: False
```

### -AosInstanceName
Name of the AOS instance that you are looking for

Accepts wildcards for searching.
E.g.
-AosInstanceName "*DEV*"

If AxActiveAosConfiguration has been configured, the default value is the name of the instance registered

Default value is otherwise "*" which will search for all AOS instances

```yaml
Type: String
Parameter Sets: (All)
Aliases: InstanceName

Required: False
Position: Named
Default value: $(if (-not ([System.String]::IsNullOrEmpty($Script:ActiveAosInstancename))) { "*$Script:ActiveAosInstancename" } else { "*" })
Accept pipeline input: False
Accept wildcard characters: False
```

### -Aos
Switch to instruct the cmdlet to include the AOS service

```yaml
Type: SwitchParameter
Parameter Sets: Specific
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManagementReporter
Switch to instruct the cmdlet to include the ManagementReporter service

```yaml
Type: SwitchParameter
Parameter Sets: Specific
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DIXF
Switch to instruct the cmdlet to include the DIXF service

```yaml
Type: SwitchParameter
Parameter Sets: Specific
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanAllAosServices
Parameter description

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PipelineOutput
asdfsadfsdf

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
