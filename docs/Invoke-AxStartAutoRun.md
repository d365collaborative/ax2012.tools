---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Invoke-AxStartAutoRun

## SYNOPSIS
Execute the AutoRun feature of the AX 2012 Client

## SYNTAX

```
Invoke-AxStartAutoRun -Path <String> [-AxClientExePath <String>] [-TimeoutInMinutes <Int32>]
 [-ShowOriginalProgress] [-OutputCommandOnly] [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
AX 2012 offers several ways to automate some core developer tasks, like DB Sync & Xpp Compile

## EXAMPLES

### EXAMPLE 1
```
Invoke-AxStartAutoRun -Path "c:\temp\ax2012.tools\autorun_syncDB.xml"
```

This will invoke the autorun feature of the AX 2012 client.
It will use the "c:\temp\ax2012.tools\autorun_syncDB.xml" as path passed to the AX 2012 Client.
It will use the default path of the AX 2012 Client, read from the registry.
It will run for a maximum of 360 minutes.

## PARAMETERS

### -Path
Path to the autorun xml file that contains the desired automation tasks that you want to execute

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AxClientExePath
Path to the AX 2012 Client (ax32.exe) file, which is needed to run the automated tasks

The default value is read from the registry on the local machine

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $(Join-Path $Script:ClientBin "Ax32.exe")
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeoutInMinutes
Number of minutes the autorun task is allowed to run, before you want it to exit

Default value is: 360 minutes (6 hours)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 360
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
Instruct the cmdlet to only generate the needed command and not execute it

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

### -EnableException
This parameters disables user-friendly warnings and enables the throwing of exceptions
This is less user friendly, but allows catching exceptions in calling scripts

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
Tags:

Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
