---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Clear-AxInstanceGlobalGuid

## SYNOPSIS
Clear the Global Guid id from the AX 2012 database

## SYNTAX

```
Clear-AxInstanceGlobalGuid [-DatabaseServer <String>] [-DatabaseName <String>] [-SqlUser <String>]
 [-SqlPwd <String>] [-OutputCommandOnly] [<CommonParameters>]
```

## DESCRIPTION
Reset the Global Guid located in the SysSqmSettings table

This guid (id) is used by the client to identify cache objects, so resetting this can be useful when troubleshooting

## EXAMPLES

### EXAMPLE 1
```
Clear-AxInstanceGlobalGuid
```

This will clear the current global guid in the AX 2012 database.

## PARAMETERS

### -DatabaseServer
Server name of the database server

Default value is: "localhost"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputCommandOnly
Instruct the cmdlet to only generate the needed command and not execute it

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

### System.String
## NOTES
Tags:

Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
