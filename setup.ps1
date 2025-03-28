Clear-Host
write-host "Starting script at $(Get-Date)"
## variables

$resourceGroupName = "lab-resource-group"
$eventNsName = "simulated-orders-app"
$eventHubName = "simulated-orders-app-event-hub"


# Prepare JavaScript EventHub client app
write-host "Creating Event Hub client app..."
npm install @azure/event-hubs@5.9.0 -s
Update-AzConfig -DisplayBreakingChangeWarning $false | Out-Null
$conStrings = Get-AzEventHubKey -ResourceGroupName $resourceGroupName -NamespaceName $eventNsName -AuthorizationRuleName "RootManageSharedAccessKey"
$conString = $conStrings.PrimaryConnectionString
$javascript = Get-Content -Path "setup.txt" -Raw
$javascript = $javascript.Replace("EVENTHUBCONNECTIONSTRING", $conString)
$javascript = $javascript.Replace("EVENTHUBNAME",$eventHubName)
Set-Content -Path "orderclient.js" -Value $javascript

write-host "Script completed at $(Get-Date)"


