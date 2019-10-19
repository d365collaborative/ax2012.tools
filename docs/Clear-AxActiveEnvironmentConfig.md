---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Clear-AxActiveEnvironmentConfig

## SYNOPSIS
Clear the active environment config

## SYNTAX

```
Clear-AxActiveEnvironmentConfig [-Temporary] [<CommonParameters>]
```

## DESCRIPTION
Clear the active environment config from the configuration store

## EXAMPLES

### EXAMPLE 1
```
Clear-AxActiveEnvironmentConfig
```

This will clear the active environment configuration from the configuration store.

## PARAMETERS

### -Temporary
Instruct the cmdlet to only temporarily clear the active environment configuration in the configuration store

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

[Get-AxActiveEnvironmentConfig]()

[Get-AxEnvironmentConfig]()

[Remove-AxEnvironmentConfig]()

[Set-AxActiveEnvironmentConfig]()

