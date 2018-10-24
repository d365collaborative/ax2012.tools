---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Invoke-AxExportModelstore

## SYNOPSIS
Export an AX 2012 modelstore file

## SYNTAX

```
Invoke-AxExportModelstore [[-DatabaseServer] <String>] [[-ModelstoreDatabase] <String>]
 [[-InstanceName] <String>] [[-Suffix] <String>] [[-Path] <String>] [-GenerateScript] [<CommonParameters>]
```

## DESCRIPTION
Export an AX 2012 modelstore file from the modelstore database

## EXAMPLES

### EXAMPLE 1
```
Invoke-AxExportModelstore
```

This will execute the cmdlet with all the default values.
This will work against the SQL server that is on localhost.
The database is expected to be "MicrosoftDynamicsAx_model".
The path where the exported modelstore file will be saved is: "c:\temp\ax2012.tools".

## PARAMETERS

### -DatabaseServer
Server name of the database server

Default value is: "localhost"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 2
Default value: MicrosoftDynamicsAx_model
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceName
Name of the instance that you are working against

If not supplied the cmdlet will take the name of the database and use that

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Suffix
A suffix text value that you want to add to the name of the file while it is exported

The default value is: (Get-Date).ToString("yyyyMMdd")

This will always name you file with the current date

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $((Get-Date).ToString("yyyyMMdd"))
Accept pipeline input: False
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
Position: 5
Default value: C:\temp\ax2012.tools
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
