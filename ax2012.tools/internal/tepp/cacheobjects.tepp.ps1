Register-PSFTeppScriptblock -Name "ax2012.client.cache.objects" -ScriptBlock { 'auc', 'kti', 'VSAssemblies'}
Register-PSFTeppScriptblock -Name "ax2012.client.cache.user.location" -ScriptBlock { 'CurrentUser', 'AllUsers'}

Register-PSFTeppScriptblock -Name "ax2012.server.cache.objects" -ScriptBlock { 'XppIL', 'Label', 'VSAssemblies'}
