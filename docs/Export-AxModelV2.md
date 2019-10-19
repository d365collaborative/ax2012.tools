---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Export-AxModelV2

## SYNOPSIS
Export AX 2012 model

## SYNTAX

```
Export-AxModelV2 [[-DatabaseServer] <String>] [[-ModelstoreDatabase] <String>] [[-Path] <String>]
 [[-Name] <String>] [[-Id] <String>] [[-Layer] <String>] [-GenerateScript] [<CommonParameters>]
```

## DESCRIPTION
Export AX 2012 model from the AX 2012 model store

## EXAMPLES

### EXAMPLE 1
```
Get-AxAosInstance | Export-AxModelV2
```

This will fetch all the AX 2012 AOS instances that are configured on the machine.
Foreach of the instances it will export all AX 2012 Models into a sub folder to "c:\temp\ax2012.tools".

### EXAMPLE 2
```
Export-AxModelV2 -DatabaseServer localhost -ModelstoreDatabase MicrosoftDynamicsAx_model -Name *CUS*
```

This will fetch all the AX 2012 AOS instances that are configured on the machine.
Foreach of the instances it will export all AX 2012 Models into a sub folder to "c:\temp\ax2012.tools".

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
Position: 3
Default value: $Script:ActiveAosModelstoredatabase
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Path to the location where you want the file to be exported

Default value is: "c:\temp\ax2012.tools"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $Script:DefaultTempPath
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the AX 2012 model that you are looking for

Accepts wildcards for searching.
E.g.
-Name "ISV*MODULE*"

Default value is "*" which will search for all models

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Id of the AX 2012 model that you are looking for

Accepts wildcards for searching.
E.g.
-Id "2*"

Default value is "*" which will search for all models

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -Layer
Layer where the AX 2012 model that you are looking for should reside

Accepts wildcards for searching.
E.g.
-Layer "IS*"

Default value is "*" which will search for models in all layers

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenerateScript
Switch to instruct the cmdlet to output the script to execute the command in hand

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
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
