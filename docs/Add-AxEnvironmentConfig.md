---
external help file: ax2012.tools-help.xml
Module Name: ax2012.tools
online version:
schema: 2.0.0
---

# Add-AxEnvironmentConfig

## SYNOPSIS
Add configuration details for an entire AX 2012 environment

## SYNTAX

```
Add-AxEnvironmentConfig [-Name] <String> [[-AosServers] <String[]>] [[-InstanceName] <String>]
 [[-DatabaseServers] <String[]>] [[-Database] <String>] [[-ModelstoreDatabase] <String>]
 [[-SsrsServers] <String[]>] [[-EpServers] <String[]>] [[-WmdpServers] <String[]>]
 [[-Mr2012Servers] <String[]>] [[-SsasServers] <String[]>] [-Append] [-Force] [-Temporary] [<CommonParameters>]
```

## DESCRIPTION
Build a configuration containing all the different servers / machines that is part of any given AX 2012 environment

You could register your TEST, SAT, UAT, PROD environment and easily switch between them when you want to troubleshoot or run maintenance work against them

## EXAMPLES

### EXAMPLE 1
```
Add-AxEnvironmentConfig -Name AXTEST -AosServers TESTAOS01 -InstanceName AXTEST -DatabaseServers TESTSQL01 -Database AXTEST -ModelstoreDatabase AXTEST_model -Temporary
```

This adds a new environment configuration to the configuration store.
The Name AXTEST is used as the name for the configuration of the environment.
The InstanceName AXTEST is used as the instance name for the configuration of the environment.
The server TESTAOS01 is registered as the AOS Server.
The server TESTSQL01 is registered as the SQL Server.
The database AXTEST is registered as the SQL Server database.
The database AXTEST_model is registered as the SQL Server database for the modelstore.

## PARAMETERS

### -Name
Name of the environment that you are adding

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AosServers
Array with server names of all the servers that host an AOS instance in the specific environment

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceName
Name of the instance that is used to uniquely identify the environment across multiple AOS instances

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

### -DatabaseServers
Array with server names of all the servers that host a SQL Server database for the environment

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: DatabaseServer

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Database
Database name for the SQL Server database that the AOS instance(s) connects to

```yaml
Type: String
Parameter Sets: (All)
Aliases: DatabaseName

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModelstoreDatabase
Database name for the SQL Server database that holds the modelstore (code)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SsrsServers
Array with server names of all the servers that host a Sql Server Reporting Services (SSRS) instance in the specific environment

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EpServers
Array with server names of all the servers that host a SharePoint installation with corresponding Enterprise Portal components in the specific environment

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WmdpServers
Array with server names of all the servers that host an IIS installation with corresponding Warehouse Mobile Device Portal (WMDP) components in the specific environment

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mr2012Servers
Array with server names of all the servers that host a Management Reporter 2012 instance in the specific environment

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SsasServers
Array with server names of all the servers that host a Sql Server Analysis Services (SSAS) instance in the specific environment

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Append
Instructs the cmdlet to append the different parameter values with those that might already exist in the configuration store

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

### -Force
Instruct the cmdlet to overwrite the specified parameter values in the configuration store

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

### -Temporary
Instruct the cmdlet to only temporarily add the environment configuration in the configuration store

Great help while building the configuration and you don't want to persist the configuration on the machine

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
Tags: Environment, Config, Configuration, Servers

Author: Mötz Jensen (@Splaxi)

## RELATED LINKS

[Clear-AxActiveEnvironmentConfig]()

[Get-AxActiveEnvironmentConfig]()

[Get-AxEnvironmentConfig]()

[Remove-AxEnvironmentConfig]()

[Set-AxActiveEnvironmentConfig]()

