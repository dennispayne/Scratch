$RemovalScope = Get-AzResourceGroup | Where-Object {$_.ResourceGroupName -like "WVD-*"} 

$RemovalScope | ForEach-Object {
    Write-Host "Removing $($_.ResourceGroupName)"
    $_ | Remove-AzResourceGroup -Force -AsJob
}