---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version: https://community.dynamics.com/365/financeandoperations/b/axsupport/posts/how-to-proactively-avoid-parameter-sniffing-step-by-step
schema: 2.0.0
---

# Set-AxParameterSniffingSetting

## SYNOPSIS
Set the parameter sniffing configuration

## SYNTAX

```
Set-AxParameterSniffingSetting [[-DatabaseServer] <String>] [[-DatabaseName] <String>] [[-SqlUser] <String>]
 [[-SqlPwd] <String>] [-GenerateScript] [<CommonParameters>]
```

## DESCRIPTION
Set the parameter sniffing value in the database based on the released hotfix from Microsoft for AX 2012

## EXAMPLES

### EXAMPLE 1
```
Set-AxParameterSniffingSetting
```

This will configure the correct parameter sniffing settings.

## PARAMETERS

### -DatabaseServer
Server name of the database server

Default value is: "localhost"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $Script:ActiveAosDatabaseserver
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DatabaseName
Name of the database

Default value is: "MicrosoftDynamicsAx"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: $Script:ActiveAosDatabase
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SqlUser
User name of the SQL Server credential that you want to use when working against the database

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlPwd
Password of the SQL Server credential that you want to use when working against the database

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenerateScript
When provided the SQL is returned and not executed

Note: This is useful for troubleshooting or providing the script to a DBA with access to the server

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
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS

[https://community.dynamics.com/365/financeandoperations/b/axsupport/posts/how-to-proactively-avoid-parameter-sniffing-step-by-step](https://community.dynamics.com/365/financeandoperations/b/axsupport/posts/how-to-proactively-avoid-parameter-sniffing-step-by-step)

