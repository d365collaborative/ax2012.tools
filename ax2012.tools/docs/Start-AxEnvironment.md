---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Start-AxEnvironment

## SYNOPSIS
Start an AX 2012 environment

## SYNTAX

### Default (Default)
```
Start-AxEnvironment [[-Server] <String[]>] [-DisplayName] <String> [-ShowOriginalProgress] [<CommonParameters>]
```

### Pipeline
```
Start-AxEnvironment [[-Server] <String[]>] [-Name <String[]>] [-ShowOriginalProgress] [<CommonParameters>]
```

## DESCRIPTION
Start AX 2012 services in your environment

## EXAMPLES

### EXAMPLE 1
```
Start-AxEnvironment -Server TEST-AOS-01 -DisplayName *ax*obj*
```

This will start the service(s) that match the search pattern "*ax*obj*" on the server named "TEST-AOS-01".

### EXAMPLE 2
```
Start-AxEnvironment -Server TEST-AOS-01 -DisplayName *ax*obj* -ShowOriginalProgress
```

This will start the service(s) that match the search pattern "*ax*obj*" on the server named "TEST-AOS-01".
It will show the status for the service(s) on the server afterwards.

### EXAMPLE 3
```
Get-AxEnvironment -ComputerName TEST-AOS-01 -Aos | Start-AxEnvironment -ShowOriginalProgress
```

This will scan the "TEST-AOS-01" server for all AOS instances and start them.
It will show the status for the service(s) on the server afterwards.

## PARAMETERS

### -Server
Name of the computer(s) that you want to work against

Default value is the name from the ComputerName from AxActiveAosConfiguration

```yaml
Type: String[]
Parameter Sets: Default
Aliases: ComputerName

Required: False
Position: 2
Default value: $Script:ActiveAosComputername
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String[]
Parameter Sets: Pipeline
Aliases: ComputerName

Required: False
Position: 2
Default value: $Script:ActiveAosComputername
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
DisplayName of windows service that you want to work against

Accepts wildcards for searching.
E.g.
-DisplayName "*ax*obj*"

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the Windows Service that you want to work against

This parameter is used when piping in the details

Designed to work together with the Get-AxEnvironment cmdlet

```yaml
Type: String[]
Parameter Sets: Pipeline
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ShowOriginalProgress
Switch to instruct the cmdlet to output the status for the service

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
