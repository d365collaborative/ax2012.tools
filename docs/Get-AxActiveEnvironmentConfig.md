---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxActiveEnvironmentConfig

## SYNOPSIS
Get the active environment configuration

## SYNTAX

```
Get-AxActiveEnvironmentConfig [-OutputAsHashtable] [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
Get the active environment configuration from the configuration store

## EXAMPLES

### EXAMPLE 1
```
Get-AxActiveEnvironmentConfig
```

This will get the active environment configuration.

## PARAMETERS

### -OutputAsHashtable
Instruct the cmdlet to return a hashtable object

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

### -EnableException
This parameters disables user-friendly warnings and enables the throwing of exceptions
This is less user friendly, but allows catching exceptions in calling scripts

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
Tags: Environment, Config, Configuration, Servers

Author: Mötz Jensen (@Splaxi)

## RELATED LINKS

[Add-AxEnvironmentConfig]()

[Get-AxEnvironmentConfig]()

[Set-AxActiveEnvironmentConfig]()

