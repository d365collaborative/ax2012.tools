---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxAosServerFromDB

## SYNOPSIS
Get AOS server details from the SQL Server database

## SYNTAX

```
Get-AxAosServerFromDB [[-DatabaseServer] <String>] [[-DatabaseName] <String>] [[-SqlUser] <String>]
 [[-SqlPwd] <String>] [<CommonParameters>]
```

## DESCRIPTION
Traverse the SysServerConfig table from the AX 2012 database and get all registered AOS Servers

## EXAMPLES

### EXAMPLE 1
```
Get-AxAosServerFromDB
```

This will query the "MicrosoftDynamicsAx" hosted on the localhost server.
It will extract all AOS Servers from the SysServerConfig table.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
