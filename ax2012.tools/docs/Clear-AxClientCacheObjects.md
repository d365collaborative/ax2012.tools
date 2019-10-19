---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Clear-AxClientCacheObjects

## SYNOPSIS
Clear AX 2012 Client Cache Objects

## SYNTAX

```
Clear-AxClientCacheObjects [[-ObjectType] <String[]>] [[-UserLocation] <String>] [-ListOnly]
 [<CommonParameters>]
```

## DESCRIPTION
Remove AX 2012 Client Cache Object files from the file system

## EXAMPLES

### EXAMPLE 1
```
Clear-AxClientCacheObjects -ObjectType "Auc" -UserLocation "CurrentUser" -ListOnly
```

This will list all the Auc files under the current user location.
It will work against the ObjectType "Auc".
It will work againt the UserLocation "CurrentUser".
It will only list the files and folders, it will NOT delete anything.

### EXAMPLE 2
```
Clear-AxClientCacheObjects -ObjectType "Auc" -UserLocation "CurrentUser"
```

This will delete all the Auc files under the current user location.
It will work against the ObjectType "Auc".
It will work againt the UserLocation "CurrentUser".

It WILL delete the files without further warning or notification!

### EXAMPLE 3
```
Clear-AxClientCacheObjects -ObjectType "Auc" -UserLocation "AllUsers"
```

This will delete all the Auc files under all users locations.
It will work against the ObjectType "Auc".
It will work againt the UserLocation "AllUsers".

It WILL delete the files without further warning or notification!

### EXAMPLE 4
```
Clear-AxClientCacheObjects -ObjectType "Auc","Kti","VSAssemblies" -UserLocation "CurrentUser"
```

This will delete all the Auc,Kti and VSAssemblies files under the current user location.
It will work against the ObjectType "Auc","Kti","VSAssemblies".
It will work againt the UserLocation "CurrentUser".

It WILL delete the files without further warning or notification!

## PARAMETERS

### -ObjectType
The type of cache object that you want to remove

Valid options are:
AUC
KTI
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

### -UserLocation
Decide which user location that you want to work against

Do you want to remove the cache objects from the current user or all users?

Valid options are:
CurrentUser
AllUsers

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
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
Tags: Client Cache, Cache, KTI, AUC, VSAssemblies

Author: Mötz Jensen (@Splaxi)

All credits goes to Kenneth Madsen (@KennethGrupp) for providing detailed examples on how to achieve this the best way using powershell

## RELATED LINKS
