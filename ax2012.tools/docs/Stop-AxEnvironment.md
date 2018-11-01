---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Stop-AxEnvironment

## SYNOPSIS
Stop an AX 2012 environment

## SYNTAX

### Default (Default)
```
Stop-AxEnvironment [-ComputerName <String[]>] [-All] [<CommonParameters>]
```

### Specific
```
Stop-AxEnvironment [-ComputerName <String[]>] [-Aos] [-ManagementReporter] [-DIXF] [<CommonParameters>]
```

## DESCRIPTION
Stop an AX 2012 services in your environment

## EXAMPLES

### EXAMPLE 1
```
Stop-AxEnvironment
```

This will stop all the known AX 2012 services on the machine that you are executing it on.

## PARAMETERS

### -ComputerName
Name of the computer(s) that you want to work against

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $Script:ActiveAosComputername
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
