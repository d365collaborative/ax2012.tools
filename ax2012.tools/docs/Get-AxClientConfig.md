---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxClientConfig

## SYNOPSIS
Get the AX 2012 client configuration

## SYNTAX

```
Get-AxClientConfig [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get the AX 2012 client configuration from the registry

## EXAMPLES

### EXAMPLE 1
```
Get-AxClientConfig
```

This will get all available client configurations from the registry and display them.

## PARAMETERS

### -Name
Name of the configuration that you are looking for

The parameter supports wildcards.
E.g.
-Name "*DEV*"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: *
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
