---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Remove-AxEnvironmentConfig

## SYNOPSIS
Remove environment configuration

## SYNTAX

```
Remove-AxEnvironmentConfig [-Name] <String> [-Temporary] [<CommonParameters>]
```

## DESCRIPTION
Remove a environment configuration from the configuration store

## EXAMPLES

### EXAMPLE 1
```
Remove-AxEnvironmentConfig -Name "UAT"
```

This will remove the environment configuration name "UAT" from the machine.

## PARAMETERS

### -Name
Name of the environment configuration you want to remove from the configuration store

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Temporary
Instruct the cmdlet to only temporarily remove the environment configuration from the configuration store

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
Tags: Servicing, Environment, Config, Configuration, Servers

Author: Mötz Jensen (@Splaxi)

## RELATED LINKS

[Add-AxEnvironmentConfig]()

[Clear-AxActiveEnvironmentConfig]()

[Get-AxActiveEnvironmentConfig]()

[Get-AxEnvironmentConfig]()

[Set-AxActiveEnvironmentConfig]()

