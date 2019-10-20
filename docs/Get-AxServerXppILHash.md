---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Get-AxServerXppILHash

## SYNOPSIS
Get hash values for XppIL files

## SYNTAX

```
Get-AxServerXppILHash [[-InstanceName] <String>] [[-OutputPath] <String>] [[-FileName] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Generate the file hash values for each *.netmodule & *.dll file in the XppIL folder

## EXAMPLES

### EXAMPLE 1
```
Get-AxServerXppILHash -InstanceName "AXTEST"
```

This will generate the file hash values for the XppIL files for the AXTEST AOS Instance.
It will work against the Instance AXTEST.
It will save the output file to the default folder location "C:\temp\ax2012.tools".
The file will named "SERVER_AXTEST_XppIL_HashValues.txt"

### EXAMPLE 2
```
Get-AxServerXppILHash
```

This will generate the file hash values for the XppIL files for the default AOS Instance.
It will work against the default AOS Instance that has been configured with Set-AxActiveAosConfig.
It will save the output file to the default folder location "C:\temp\ax2012.tools".
The file will named "SERVER_INSTANCENAME_XppIL_HashValues.txt"

The default value of the instance name can be configured with the Set-AxActiveAosConfig cmdlet.

## PARAMETERS

### -InstanceName
Name of the instance that you are working against

Default value can be configured with the Set-AxActiveAosConfig cmdlet

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $Script:ActiveAosInstancename
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputPath
Path to the folder where the output file must be saved

Default value is: "C:\temp\ax2012.tools"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $Script:DefaultTempPath
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName
Name of the output as you want it to be named

If left empty the output file will be named based on the following pattern: "SERVERNAME_INSTANCENAME_XppIL_HashValue.txt"

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Tags: XppIL, Hash, Files

Author: Mötz Jensen (@Splaxi)

All credits goes to Kenneth Madsen (@KennethGrupp) for providing detailed examples on how to achieve this the best way using powershell

## RELATED LINKS
