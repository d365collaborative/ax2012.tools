---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Invoke-AxBuild

## SYNOPSIS
Start the AxBuild.exe

## SYNTAX

```
Invoke-AxBuild [-BinDirectory <String>] [-AlternativeBinPath <String>] [-InstanceNumber <String>]
 [-DatabaseServer <String>] [-ModelstoreDatabase <String>] [-Workers <Int32>] [-OutputPath <String>]
 [-ShowOriginalProgress] [-OutputCommandOnly] [<CommonParameters>]
```

## DESCRIPTION
Invoke the AxBuild.exe with the necessary parameters to make it compile your application

## EXAMPLES

### EXAMPLE 1
```
Get-AxAosInstance | Invoke-AxBuild
```

This will find all AOS instances using the Get-AxAosInstance on the machine and pipe them to Invoke-AxBuild.
For each AOS instance found it will start the AxBuild.exe against their individual details.
It will store the log file under the default ax2012.tools folder.

### EXAMPLE 2
```
Invoke-AxBuild
```

This will start the AxBuild.exe against the ActiveAos configuration.
It will store the log file under the default ax2012.tools folder.

## PARAMETERS

### -BinDirectory
The full path to the bin directory where the AOS instance is physical installed

```yaml
Type: String
Parameter Sets: (All)
Aliases: Path

Required: False
Position: Named
Default value: $Script:ActiveAosBindirectory
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AlternativeBinPath
The full path to the client bin directory where AX 2012 Client is physical installed

```yaml
Type: String
Parameter Sets: (All)
Aliases: AltBin

Required: False
Position: Named
Default value: $Script:ClientBin
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceNumber
The 2 digit (\[0-9\]\[0-9\]) number that the AOS instance has on the server

```yaml
Type: String
Parameter Sets: (All)
Aliases: Aos

Required: False
Position: Named
Default value: $Script:ActiveAosInstanceNumber
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DatabaseServer
The name of the server running SQL Server

```yaml
Type: String
Parameter Sets: (All)
Aliases: DBServer

Required: False
Position: Named
Default value: $Script:ActiveAosDatabaseserver
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ModelstoreDatabase
The name of the AX 2012 modelstore database

```yaml
Type: String
Parameter Sets: (All)
Aliases: Modelstore

Required: False
Position: Named
Default value: $Script:ActiveAosModelstoredatabase
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Workers
Number of workers that you want to utilize while compiling

The built-in logic from AxBuild.exe will choose a number equal to your visible cores
Leaving it blank or with 0 (Zero) will use the built-in logic from AxBuild.exe

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputPath
Path to the log file you want AxBuild.exe to output to

Default location is: "c:\temp\ax2012.tools\AxBuild\"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $(Join-Path $Script:DefaultTempPath "AxBuildLog")
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowOriginalProgress
Instruct the cmdlet to show the standard output in the console

Default is $false which will silence the standard output

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
Instruct the cmdlet to output a script that you can execute manually later

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
