---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Resolve-AxTableFieldIDs

## SYNOPSIS
Fix table and field ID conflicts

## SYNTAX

```
Resolve-AxTableFieldIDs [[-DatabaseServer] <String>] [[-DatabaseName] <String>]
 [[-ModelstoreDatabase] <String>] [[-SqlUser] <String>] [[-SqlPwd] <String>] [-GenerateScript]
 [<CommonParameters>]
```

## DESCRIPTION
Fixes both table and field IDs in the AX SqlDictionary (data db) to match the AX code (Model db)

Useful for after a database has been restored and the table or field IDs do not match
Run this command instead of letting the database synchronization process drop and recreate the table

Before running:
Stop the AOS
Always take the appropriate SQL backups before running this script

After running:
Start the AOS
Sync the database within AX

Note:
Objects that are new in AOT will get created in SQL dictionary when synchronization happens

## EXAMPLES

### EXAMPLE 1
```
Resolve-AxTableFieldIDs
```

This will execute the cmdlet with all the default values.
This will work against the SQL server that is on localhost.
The database is expected to be "MicrosoftDynamicsAx_model".

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
Accept pipeline input: False
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
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModelstoreDatabase
Name of the modelstore database

Default value is: "MicrosoftDynamicsAx_model"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $Script:ActiveAosModelstoredatabase
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlUser
User name of the SQL Server credential that you want to use when working against the database

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

### -SqlPwd
Password of the SQL Server credential that you want to use when working against the database

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Author: Dag Calafell, III (@dodiggitydag)
Reference: http://calafell.me/the-ultimate-ax-2012-table-and-field-id-fix-for-synchronization-errors/

## RELATED LINKS
