---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Import-AxModelV2

## SYNOPSIS
Import AX 2012 model

## SYNTAX

```
Import-AxModelV2 [[-DatabaseServer] <String>] [[-ModelstoreDatabase] <String>] [[-Path] <String>]
 [[-ConflictMode] <String>] [-CreateParents] [-NoOptimize] [-NoPrompt] [-OutputCommandOnly] [<CommonParameters>]
```

## DESCRIPTION
Import AX 2012 model into the AX 2012 Model store

## EXAMPLES

### EXAMPLE 1
```
Import-AxModelV2 -Path "c:\temp\ax2012.tools\dev-models"
```

The cmdlet will look for all the AX 2012 models located in "c:\temp\ax2012.tools\dev-models" or any of its sub folders.
The ConflictMode is set to the default value of "OverWrite".
The Database Server is set to the default value of "localhost".
The Modelstore Database is set to the default value of "MicrosoftDynamicsAx_model".

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
Accept pipeline input: True (ByPropertyName, ByValue)
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
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Path
Path to the folder containing the AX model file(s) that you want to import

The cmdlet will traverse all sub folders for files and import them based on their names

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

### -ConflictMode
Instructs the cmdlet to handle conflicts

The list of options is:
"Reject"
"Push"
"Overwrite"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: Overwrite
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreateParents
Switch to instruct the cmdlet to create missing parents on import

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

### -NoOptimize
Switch to instruct the cmdlet to skip the optimization on import

This makes sense if you are import more than 1-2 AX 2012 models at the same time

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

### -NoPrompt
Switch to instruct the cmdlet not to prompt you with anything

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

### -OutputCommandOnly
Switch to instruct the cmdlet to output a script that you can execute manually later

Using this will not import any AX 2012 models into the model store

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
