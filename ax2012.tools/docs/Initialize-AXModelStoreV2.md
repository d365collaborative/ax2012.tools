---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Initialize-AXModelStoreV2

## SYNOPSIS
Initialize an AX 2012 modelstore

## SYNTAX

### CreateSchema (Default)
```
Initialize-AXModelStoreV2 [-DatabaseServer <String>] [-ModelstoreDatabase <String>] [-SchemaName <String>]
 [-CreateSchema] [-GenerateScript] [<CommonParameters>]
```

### Drop
```
Initialize-AXModelStoreV2 [-DatabaseServer <String>] [-ModelstoreDatabase <String>] [-SchemaName <String>]
 [-DropSchema] [-GenerateScript] [<CommonParameters>]
```

### CreateDB
```
Initialize-AXModelStoreV2 [-DatabaseServer <String>] [-ModelstoreDatabase <String>] [-CreateDb]
 [-GenerateScript] [<CommonParameters>]
```

## DESCRIPTION
Initialize an AX 2012 modelstore against a modelstore database

## EXAMPLES

### EXAMPLE 1
```
Initialize-AXModelStoreV2 -SchemaName TempSchema -CreateSchema
```

This will execute the cmdlet with some of the default values.
This will work against the SQL server that is on localhost.
The database is expected to be "MicrosoftDynamicsAx_model".
The cmdlet will create the "TempSchema" schema inside the modelstore database.

### EXAMPLE 2
```
Initialize-AXModelStoreV2 -SchemaName TempSchema -DropSchema
```

This will execute the cmdlet with some of the default values.
This will work against the SQL server that is on localhost.
The database is expected to be "MicrosoftDynamicsAx_model".
The cmdlet will drop the "TempSchema" schema inside the modelstore database.

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
Default value: Localhost
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModelstoreDatabase
Name of the modelstore database

Default value is: "MicrosoftDynamicsAx_model"

Note: From AX 2012 R2 and upwards you need to provide the full name for the modelstore database.
E.g.
"AX2012R3_PROD_model"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: MicrosoftDynamicsAx_model
Accept pipeline input: False
Accept wildcard characters: False
```

### -SchemaName
Name of the schema in the modelstore database that you want to work against

Default value is: "TempSchema"

```yaml
Type: String
Parameter Sets: CreateSchema, Drop
Aliases:

Required: False
Position: Named
Default value: TempSchema
Accept pipeline input: False
Accept wildcard characters: False
```

### -DropSchema
Switch to instruct the cmdlet to drop the schema supplied with the -SchemaName parameter

```yaml
Type: SwitchParameter
Parameter Sets: Drop
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreateSchema
Switch to instruct the cmdlet to create the schema supplied with the -SchemaName parameter

```yaml
Type: SwitchParameter
Parameter Sets: CreateSchema
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreateDb
Switch to instruct the cmdlet to create a new modelstore inside the supplied -ModelstoreDatabase parameter

```yaml
Type: SwitchParameter
Parameter Sets: CreateDB
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenerateScript
Switch to instruct the cmdlet to only generate the needed command and not execute it

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
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
