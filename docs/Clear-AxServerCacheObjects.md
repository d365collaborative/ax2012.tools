---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Clear-AxServerCacheObjects

## SYNOPSIS
Clear AX 2012 AOS Server Cache Objects

## SYNTAX

```
Clear-AxServerCacheObjects [[-ObjectType] <String[]>] [[-InstanceName] <String>] [-ListOnly]
 [<CommonParameters>]
```

## DESCRIPTION
Remove AX 2012 AOS Server Cache Object files from the file system

## EXAMPLES

### EXAMPLE 1
```
Clear-AxServerCacheObjects -ObjectType "XppIL" -InstanceName "AXTEST" -ListOnly
```

This will list all the XppIL files under the AXTEST AOS Instance location.
It will work against the ObjectType "XppIL".
It will work againt the InstanceName "AXTEST".
It will only list the files and folders, it will NOT delete anything.

### EXAMPLE 2
```
Clear-AxServerCacheObjects -ObjectType "XppIL" -InstanceName "AXTEST"
```

This will delete all the XppIL files under the AXTEST AOS Instance location.
It will work against the ObjectType "XppIL".
It will work againt the InstanceName "AXTEST".

It WILL delete the files without further warning or notification!

### EXAMPLE 3
```
Clear-AxServerCacheObjects -ObjectType "XppIL","Label","VSAssemblies" -InstanceName "AXTEST"
```

This will delete all the XppIL,Label and VSAssemblies files under the AXTEST AOS Instance location.
It will work against the ObjectType "XppIL","Label","VSAssemblies".
It will work againt the InstanceName "AXTEST".

It WILL delete the files without further warning or notification!

## PARAMETERS

### -ObjectType
The type of cache object that you want to remove

Valid options are:
XppIL
Label
VSAssemblies

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceName
Name of the instance that you are working against

Default value can be configured with the Set-AxActiveAosConfig cmdlet

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $Script:ActiveAosInstancename
Accept pipeline input: False
Accept wildcard characters: False
```

### -ListOnly
Instruct the cmdlet to only list the files that matches your selection from the other parameters

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
Tags: Client Cache, Cache, Label, XppIL, VSAssemblies

Author: Mötz Jensen (@Splaxi)

All credits goes to Kenneth Madsen (@KennethGrupp) for providing detailed examples on how to achieve this the best way using powershell

## RELATED LINKS
