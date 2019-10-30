---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxAutoRunXml

## SYNOPSIS
Get a valid Autorun XML file for AX 2012

## SYNTAX

```
Get-AxAutoRunXml [[-OutputPath] <String>] [[-LogFile] <String>] [-ExitWhenDone] [-SynchronizeDB]
 [-CompileCilFull] [-CompileCilIncremental] [-CompileXpp] [-CompileXppAndXRefUpdate] [<CommonParameters>]
```

## DESCRIPTION
Generate a valid Autorun XML file based on the selected parameters and have it saved on the disk

## EXAMPLES

### EXAMPLE 1
```
Get-AxAutoRunXml -ExitWhenDone -SynchronizeDB
```

This will generate a valid Autorun xml file for synchronizing the database.
It will use the default path "c:\temp\ax2012.tools\Autorun.xml" where the file will be stored.
It will use the default path "c:\temp\ax2012.tools\Autorun_Output.txt" to instruct the Autorun where to save its log file.
It will instruct the Autorun to exit when done.
It will instruct the Autorun to do a synchronization of the database.

## PARAMETERS

### -OutputPath
The path where you want to store to autorun xml file

The path must be a full path to a file

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Join-Path $Script:DefaultTempPath "Autorun.xml")
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
The path where you want the autorun process to save its log file

The path must be a full path to a file

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Join-Path $Script:DefaultTempPath "Autorun_Output.txt")
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExitWhenDone
Instruct the autorun process wether you want it to exit the AX 2012 client when done or not

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

### -SynchronizeDB
Instruct the autorun to do a synchronization of the database

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

### -CompileCilFull
Instruct the autorun to do a full CIL compile

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

### -CompileCilIncremental
Instruct the autorun to do a incremental CIL compile

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

### -CompileXpp
Instruct the autorun to do a full X++ (Xpp) compile

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

### -CompileXppAndXRefUpdate
Instruct the autorun to do a full X++ (Xpp) compile and do a full Cross Reference (XRef) update

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
Tags:
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
