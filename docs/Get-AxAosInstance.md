---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxAosInstance

## SYNOPSIS
Get AX 2012 AOS Instance

## SYNTAX

```
Get-AxAosInstance [[-Name] <String>] [[-InstanceNo] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get AX 2012 AOS Instance details from the local machine

## EXAMPLES

### EXAMPLE 1
```
Get-AxAosInstance
```

This will get you all the installed AX 2012 AOS instances on the machine

## PARAMETERS

### -Name
The search string to filter the AOS instance that you're looking for

The parameter supports wildcards.
E.g.
-Name "*DEV*"

Default value is "*" and will give you all the instances

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceNo
The search string to filter the AOS instance that you're looking for

The parameter supports wildcards.
E.g.
-InstanceNo "*1*"

Default value is "*" and will give you all the instances

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: *
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
