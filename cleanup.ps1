$RemovalScope = Get-AzResourceGroup | Where-Object {$_.ResourceGroupName -like "WVD-*"} 

foreach ($RG in $RemovalScope) {
    write-host "Removing $RG"
    remove-azresourcegroup $RG
}