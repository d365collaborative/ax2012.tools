<#
This is an example configuration file

By default, it is enough to have a single one of them,
however if you have enough configuration settings to justify having multiple copies of it,
feel totally free to split them into multiple files.
#>

<#
# Example Configuration
Set-PSFConfig -Module 'ax2012.tools' -Name 'Example.Setting' -Value 10 -Initialize -Validation 'integer' -Handler { } -Description "Example configuration setting. Your module can then use the setting using 'Get-PSFConfigValue'"
#>

Set-PSFConfig -Module 'ax2012.tools' -Name 'Import.DoDotSource' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be dotsourced on import. By default, the files of this module are read as string value and invoked, which is faster but worse on debugging."
Set-PSFConfig -Module 'ax2012.tools' -Name 'Import.IndividualFiles' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be imported individually. During the module build, all module code is compiled into few files, which are imported instead by default. Loading the compiled versions is faster, using the individual files is easier for debugging and testing out adjustments."

Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.computername' -Value "" -Initialize -Description "The computername on which the specific AOS instance is running."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.bindirectory' -Value "" -Initialize -Description "The path to the bin directory where the AOS instance is installed."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.instance.number' -Value "" -Initialize -Description "The registered instance number the AOS has on the specific machine."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.instancename' -Value "" -Initialize -Description "The registered instance name the AOS has on the specific machine."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.databaseserver' -Value "" -Initialize -Description "The registered SQL Server the AOS is communicating with."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.database' -Value "" -Initialize -Description "The registered database the AOS is saving all its data."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.modelstoredatabase' -Value "" -Initialize -Description "The registered modelstore database the AOS is storing all its code."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.aos.port' -Value "" -Initialize -Description "The registered port the AOS is listing for clients on."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.wsdl.port' -Value "" -Initialize -Description "The registered WSDL port the AOS is exposing WSDL services on."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.aos.nettcp.port' -Value "" -Initialize -Description "The registered NetTcp port the AOS is exposing Custom services on."

Set-PSFConfig -Module 'ax2012.tools' -Name 'active.logicapp.email' -Value "" -Initialize -Description "The registered email address the Invoke-AxLogicApp should notify when firing a notification request."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.logicapp.url' -Value "" -Initialize -Description "The registered URL/URI the Invoke-AxLogicApp should contact when firing a notification request."
Set-PSFConfig -Module 'ax2012.tools' -Name 'active.logicapp.subject' -Value "" -Initialize -Description "The registered subject the Invoke-AxLogicApp should use as context when firing a notification request."
