---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxClientBuild

## SYNOPSIS
Get the build numbers

## SYNTAX

```
Get-AxClientBuild [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get the build numbers for the AX 2012 client

## EXAMPLES

### EXAMPLE 1
```
Get-AxClientBuild
```

This will get the executable path and the build numbers for the client.

## PARAMETERS

### -Path
The path to the Ax32.exe file you want to work against

The default path is read from the registry

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $(Join-Path $Script:ClientBin "Ax32.exe")
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
