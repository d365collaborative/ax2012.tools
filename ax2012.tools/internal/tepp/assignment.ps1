<#
# Example:
Register-PSFTeppArgumentCompleter -Command Get-Alcohol -Parameter Type -Name ax2012.tools.alcohol
#>

Register-PSFTeppArgumentCompleter -Command Clear-AxClientCacheObjects -Parameter ObjectType -Name ax2012.client.cache.objects
Register-PSFTeppArgumentCompleter -Command Clear-AxClientCacheObjects -Parameter UserLocation -Name ax2012.client.cache.user.location

Register-PSFTeppArgumentCompleter -Command Clear-AxServerCacheObjects -Parameter ObjectType -Name ax2012.server.cache.objects

