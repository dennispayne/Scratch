$RemovalScope = Get-AzResourceGroup | Where-Object {$_.ResourceGroupName -like "WVD-*"} 

$RemovalScope | ForEach-Object {
    Write-Host "Removing $RG"
    Remove-AzResourceGroup $RG -Force
}