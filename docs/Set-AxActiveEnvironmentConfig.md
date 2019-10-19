---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Set-AxActiveEnvironmentConfig

## SYNOPSIS
Set the active environment configuration

## SYNTAX

```
Set-AxActiveEnvironmentConfig [-Name] <String> [-Temporary] [<CommonParameters>]
```

## DESCRIPTION
Updates the current active environment configuration with a new one

Use this to update the default parameters across the module, to make it easier to call your different commands

## EXAMPLES

### EXAMPLE 1
```
Set-AxActiveEnvironmentConfig -Name "UAT"
```

This will set the environment configuration named "UAT" as the active configuration.

## PARAMETERS

### -Name
Name of the environment configuration you want to load into the active environment configuration

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
Instruct the cmdlet to only temporarily override the persisted settings in the configuration store

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

[Get-AxActiveEnvironmentConfig]()

[Get-AxEnvironmentConfig]()

