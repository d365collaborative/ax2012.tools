---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Set-AxActiveAosConfig

## SYNOPSIS
Set the active AX 2012 AOS configuration

## SYNTAX

```
Set-AxActiveAosConfig [[-ComputerName] <String[]>] [[-BinDirectory] <String>] [[-InstanceNumber] <String>]
 [[-InstanceName] <String>] [[-DatabaseServer] <String>] [[-DatabaseName] <String>]
 [[-ModelstoreDatabase] <String>] [[-AosPort] <String>] [[-WsdlPort] <String>] [[-NetTcpPort] <String>]
 [-ConfigStorageLocation <String>] [-Temporary] [-Clear] [<CommonParameters>]
```

## DESCRIPTION
Set the active AX 2012 AOS details and store it into the configuration storage

## EXAMPLES

### EXAMPLE 1
```
Get-AxAosInstance | Select-Object -First 1 | Set-AxActiveAosConfig
```

This will get all the AX 2012 AOS instances from the local machine and only select the first output.
The output from the first AOS instance is saved into the configuration store.

### EXAMPLE 2
```
Set-AxActiveAosConfig -ComputerName AX2012PROD -DatabaseServer SQLSERVER -DatabaseName AX2012R3_PROD -ModelstoreDatabase AX2012R3_PROD_model -AosPort 2712
```

This will update the active AOS configuration store settings.
The computer name will be registered to: AX2012PROD
The database server will be registered to: SQLSERVER
The database name will be registered to: AX2012R3_PROD
The model store database will be registered to: AX2012R3_PROD_model
The AOS port will be registered to: 2712

### EXAMPLE 3
```
Set-AxActiveAosConfig -Clear
```

This will clear out all the stored configuration values.
It updates all the internal configuration variables, so all aos default values across the module will be empty.

## PARAMETERS

### -ComputerName
The name of the computer / server that AOS resides on

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: @($env:computername)
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BinDirectory
The full path to the bin directory where the AOS instance is physical installed

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceNumber
The 2 digit (\[0-9\]\[0-9\]) number that the AOS instance has on the server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceName
The instance name the AOS server is registered with

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DatabaseServer
The name of the server running SQL Server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DatabaseName
The name of the AX 2012 business data database

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ModelstoreDatabase
The name of the AX 2012 modelstore database

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AosPort
The TCP port that the AX 2012 AOS server is communicating with the AX clients on

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WsdlPort
The TCP port that the AX 2012 AOS server is communicating with all WSDL consuming applications on

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NetTcpPort
The TCP port that the AX 2012 AOS server is communicating with all NetTcp consuming applications on

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConfigStorageLocation
Parameter used to instruct where to store the configuration objects

The default value is "User" and this will store all configuration for the active user

Valid options are:
"User"
"System"

"System" will store the configuration so all users can access the configuration objects

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: User
Accept pipeline input: False
Accept wildcard characters: False
```

### -Temporary
Instruct the cmdlet to only temporarily override the persisted settings in the configuration storage

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

### -Clear
Instruct the cmdlet to clear out all the stored configuration values

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
Author: Mötz Jensen (@Splaxi)

## RELATED LINKS
