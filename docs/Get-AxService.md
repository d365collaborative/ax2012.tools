﻿---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxService

## SYNOPSIS
Get the status of the AX 2012 service(s)

## SYNTAX

### Default (Default)
```
Get-AxService [-ComputerName <String[]>] [-All] [-AosInstanceName <String>] [-ScanAllAosServices]
 [<CommonParameters>]
```

### Specific
```
Get-AxService [-ComputerName <String[]>] [-AosInstanceName <String>] [-Aos] [-ManagementReporter] [-DIXF]
 [-ScanAllAosServices] [<CommonParameters>]
```

## DESCRIPTION
Get the status of AX 2012 service(s) on the computer

## EXAMPLES

### EXAMPLE 1
```
Get-AxService
```

This will get the status for all the default services from the local computer.
If AxActiveAosConfiguration has been configured, it will work against the ComputerName and AosInstanceName registered.

### EXAMPLE 2
```
Get-AxService -ScanAllAosServices
```

This will scan for all available AOS Services.
If AxActiveAosConfiguration has been configured, it will work against the ComputerName registered otherwise localhost is used.

### EXAMPLE 3
```
Get-AxService -ComputerName TEST-AOS-01 -Aos
```

This will get all AOS instances (services) from the server named "TEST-AOS-01".
If AxActiveAosConfiguration has been configured, it will work against the AosInstanceName registered otherwise it will find all.

### EXAMPLE 4
```
Get-AxService -ComputerName TEST-AOS-01 -Aos -AosInstanceName *DEV*
```

This will get all AOS instances (services) that match the search pattern "*DEV*" from the server named "TEST-AOS-01".

### EXAMPLE 5
```
Get-AxService -ComputerName TEST-AOS-01 -Aos | Start-AxService -ShowOriginalProgress
```

This will scan the "TEST-AOS-01" server for all AOS instances (services) and start them.
It will show the status for the service(s) on the server afterwards.

If AxActiveAosConfiguration has been configured, it will work against the AosInstanceName registered otherwise it will find all.

### EXAMPLE 6
```
Get-AxService -ComputerName TEST-AOS-01 -Aos | Stop-AxService -ShowOriginalProgress
```

This will scan the "TEST-AOS-01" server for all AOS instances (services) and stop them.
It will show the status for the service(s) on the server afterwards.

If AxActiveAosConfiguration has been configured, it will work against the AosInstanceName registered otherwise it will find all.

## PARAMETERS

### -ComputerName
Name of the computer(s) that you want to work against

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: ServerName

Required: False
Position: Named
Default value: $Script:ActiveAosComputername
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -All
Instruct the cmdlet to include all known AX 2012 services

```yaml
Type: SwitchParameter
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: True
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
Instruct the cmdlet to include the AOS service

```yaml
Type: SwitchParameter
Parameter Sets: Specific
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManagementReporter
Instruct the cmdlet to include the ManagementReporter service

```yaml
Type: SwitchParameter
Parameter Sets: Specific
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DIXF
Instruct the cmdlet to include the DIXF service

```yaml
Type: SwitchParameter
Parameter Sets: Specific
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanAllAosServices
Instruct the cmdlet to look for all available AOS Instances on the computer

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
