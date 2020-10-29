[CmdletBinding(SupportsShouldProcess=$true)]
Param(
    [Parameter(Mandatory=$true)]
    [string] $Prefix
)

$RemovalScope = Get-AzResourceGroup | Where-Object {$_.ResourceGroupName -like "$($Prefix)*"} 
Write-Verbose "Found $($RemovalScope.count) Resource Groups"

$RemovalScope | ForEach-Object {
    if($PSCmdlet.ShouldProcess($_.ResourceGroupName, "Remove Locks")){
        $AllLocks = Get-AzResourceLock -ResourceGroupName $_.ResourceGroupName
        Write-Verbose "Found $($AllLocks.count) locks"
        $AllLocks | ForEach-Object {
            Write-Verbose "Removing lock $($_.Name)"
            Remove-AzResourceLock -LockId $_.LockId -Force
        }
    }
    
<#
if($PSCmdlet.ShouldProcess($_.ResourceGroupName, "Remove WVD Hostpools")){
    #TODO #3 Add some foreach loops to enumerate all hostpools, session hosts within them, then delete

    Remove-AzWvdSessionHost -HostPoolName $hp.name -ResourceGroupName "WVDSD-sharedsvcs-rg" -Name "WVDSDvm1.wvdhints.com"
    Remove-AzWvdHostPool -ResourceGroupName "WVDSD-sharedsvcs-rg" -Name $hp.name
}
#>

    if($PSCmdlet.ShouldProcess($_.ResourceGroupName, "Remove ResourceGroup")){
        $_ | Remove-AzResourceGroup -Force -AsJob
    }
}
Get-Job | Group-Object State