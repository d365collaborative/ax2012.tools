---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxEnvironmentConfig

## SYNOPSIS
Get AX 2012 environment details from the configuration store

## SYNTAX

```
Get-AxEnvironmentConfig [[-Name] <String>] [-OutputAsHashtable] [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
Get the environment details for the AX 2012 environment(s) that are stored in the configuration store

## EXAMPLES

### EXAMPLE 1
```
Get-AxEnvironmentConfig
```

This will get all saved environment configurations.

## PARAMETERS

### -Name
Name of the configuration that you want to work against

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

### -OutputAsHashtable
Instruct the cmdlet to return a hastable object

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

### PSCustomObject
## NOTES
Tags: Servicing, Environment, Config, Configuration, Servers

Author: Mötz Jensen (@Splaxi)

## RELATED LINKS

[Add-AxEnvironmentConfig]()

[Get-AxActiveEnvironmentConfig]()

[Set-AxActiveEnvironmentConfig]()

