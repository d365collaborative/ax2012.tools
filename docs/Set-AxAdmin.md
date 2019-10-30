---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Set-AxAdmin

## SYNOPSIS
Set the admin account inside the AX 2012 database

## SYNTAX

```
Set-AxAdmin -Username <String> [-DatabaseServer <String>] [-DatabaseName <String>] [-SqlUser <String>]
 [-SqlPwd <String>] [-OutputCommandOnly] [<CommonParameters>]
```

## DESCRIPTION
Set the user account details (credentails) that will be the considered as the admin account in the AX 2012 database

## EXAMPLES

### EXAMPLE 1
```
Set-AxAdmin -Username "ACME.local\test"
```

This will update the admin record in the AX 2012 database to "ACME.local\test".

## PARAMETERS

### -Username
Username of the user that you want to be the new admin in the database

Must include domain details, either in PRE-2000 or UPN style

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
