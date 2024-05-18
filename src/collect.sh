#!/bin/bash
# src/collect.sh

MAX_RETRIES=3
RETRY_DELAY=5

# Function to collect data for Microsoft.ApiManagement/service resources
function getApiManagementServices() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.ApiManagement/service" --query "[].{id:id, name:name, location:location, sku:sku.name, capacity:sku.capacity, publisherEmail:properties.publisherEmail, publisherName:properties.publisherName, provisioningState:properties.provisioningState, gatewayUrl:properties.gatewayUrl, portalUrl:properties.portalUrl, managementApiUrl:properties.managementApiUrl, scmUrl:properties.scmUrl, hostnameConfigurations:properties.hostnameConfigurations, virtualNetworkType:properties.virtualNetworkType, virtualNetworkConfiguration:properties.virtualNetworkConfiguration, additionalLocations:properties.additionalLocations, customProperties:properties.customProperties, certificates:properties.certificates}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.ApiManagement/service. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Compute/virtualMachines/extensions resources
function getVmExtensions() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Compute/virtualMachines/extensions" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Compute/virtualMachines/extensions. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/networkWatchers/connectionMonitors resources
function getConnectionMonitors() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/networkWatchers/connectionMonitors" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/networkWatchers/connectionMonitors. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Insights/scheduledQueryRules resources
function getScheduledQueryRules() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Insights/scheduledQueryRules" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Insights/scheduledQueryRules. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.HybridCompute/machines resources
function getHybridMachines() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.HybridCompute/machines" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.HybridCompute/machines. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Cdn/cdnWebApplicationFirewallPolicies resources
function getCdnWafPolicies() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Cdn/cdnWebApplicationFirewallPolicies" --query "[].{id:id, name:name, location:location, sku:sku.name, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Cdn/cdnWebApplicationFirewallPolicies. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.ResourceGraph/queries resources
function getResourceGraphQueries() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.ResourceGraph/queries" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.ResourceGraph/queries. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/expressRouteCircuits resources
function getExpressRouteCircuits() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/expressRouteCircuits" --query "[].{id:id, name:name, location:location, sku:sku.name, sku:sku.tier, sku:sku.family, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/expressRouteCircuits. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/vpnGateways resources
function getVpnGateways() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/vpnGateways" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/vpnGateways. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/virtualNetworkGateways resources
function getVirtualNetworkGateways() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/virtualNetworkGateways" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/virtualNetworkGateways. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Resources/templateSpecs/versions resources
function getTemplateSpecVersions() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Resources/templateSpecs/versions" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Resources/templateSpecs/versions. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.DataLakeStore/accounts resources
function getDataLakeStoreAccounts() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.DataLakeStore/accounts" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.DataLakeStore/accounts. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.AnalysisServices/servers resources
function getAnalysisServicesServers() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.AnalysisServices/servers" --query "[].{id:id, name:name, location:location, sku:sku.name, sku:sku.tier, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.AnalysisServices/servers. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/frontdoorWebApplicationFirewallPolicies resources
function getFrontDoorWafPolicies() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/frontdoorWebApplicationFirewallPolicies" --query "[].{id:id, name:name, location:location, sku:sku.name, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/frontdoorWebApplicationFirewallPolicies. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/firewallPolicies resources
function getFirewallPolicies() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/firewallPolicies" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/firewallPolicies. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/loadBalancers resources
function getLoadBalancers() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/loadBalancers" --query "[].{id:id, name:name, location:location, sku:sku.name, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/loadBalancers. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/localNetworkGateways resources
function getLocalNetworkGateways() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/localNetworkGateways" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/localNetworkGateways. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.CognitiveServices/accounts resources
function getCognitiveServicesAccounts() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.CognitiveServices/accounts" --query "[].{id:id, name:name, location:location, sku:sku.name, kind:kind, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.CognitiveServices/accounts. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Search/searchServices resources
function getSearchServices() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Search/searchServices" --query "[].{id:id, name:name, location:location, sku:sku.name, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Search/searchServices. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies resources
function getAppGatewayWafPolicies() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/azureFirewalls resources
function getAzureFirewalls() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/azureFirewalls" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/azureFirewalls. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/applicationGateways resources
function getApplicationGateways() {
  for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    az resource list --resource-type "Microsoft.Network/applicationGateways" --query "[].{id:id, name:name, location:location, sku:sku.name, sku:sku.tier, sku:sku.capacity, properties:properties}" -o json 2>/dev/null
    if [[ $? -eq 0 ]]; then
      break
    else
      echo "Error collecting data for resource type: Microsoft.Network/applicationGateways. Retry $retry/$MAX_RETRIES."
      sleep $RETRY_DELAY
    fi
  done
}

# Function to collect data for Microsoft.Network/privateEndpoints resources
function getPrivateEndpoints() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Network/privateEndpoints" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/privateEndpoints. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.ContainerRegistry/registries resources
function getContainerRegistries() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.ContainerRegistry/registries" --query "[].{id:id, name:name, location:location, sku:sku.name, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.ContainerRegistry/registries. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/vpnSites resources
function getVpnSites() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Network/vpnSites" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/vpnSites. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.ContainerService/managedClusters resources
function getManagedClusters() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.ContainerService/managedClusters" --query "[].{id:id, name:name, location:location, sku:sku.name, sku:sku.tier, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.ContainerService/managedClusters. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Web/sites/slots resources
function getWebAppSlots() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Web/sites/slots" --query "[].{id:id, name:name, location:location, kind:kind, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Web/sites/slots. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/routeTables resources
function getRouteTables() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Network/routeTables" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/routeTables. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.DocumentDB/databaseAccounts resources
function getCosmosDBAccounts() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.DocumentDB/databaseAccounts" --query "[].{id:id, name:name, location:location, kind:kind, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.DocumentDB/databaseAccounts. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Web/sites resources
function getWebApps() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Web/sites" --query "[].{id:id, name:name, location:location, kind:kind, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Web/sites. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/publicIPAddresses resources
function getPublicIpAddresses() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Network/publicIPAddresses" --query "[].{id:id, name:name, location:location, sku:sku.name, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/publicIPAddresses. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.KeyVault/vaults resources
function getKeyVaults() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.KeyVault/vaults" --query "[].{id:id, name:name, location:location, sku:sku.name, sku:sku.family, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.KeyVault/vaults. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/networkSecurityGroups resources
function getNSGs() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Network/networkSecurityGroups" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/networkSecurityGroups. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/virtualNetworks resources
function getVirtualNetworks() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Network/virtualNetworks" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/virtualNetworks. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Storage/storageAccounts resources
function getStorageAccounts() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Storage/storageAccounts" --query "[].{id:id, name:name, location:location, sku:sku.name, sku:sku.tier, kind:kind, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Storage/storageAccounts. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/networkInterfaces resources
function getNetworkInterfaces() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az resource list --resource-type "Microsoft.Network/networkInterfaces" --query "[].{id:id, name:name, location:location, properties:properties}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/networkInterfaces. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/natGateways resources
function getNatGateways() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network nat gateway list --query "[].{id:id, name:name, location:location, skuName:sku.name, resourceGroup:resourceGroup, provisioningState:provisioningState, idleTimeoutInMinutes:idleTimeoutInMinutes, publicIpAddresses:publicIpAddresses, publicIpPrefixes:publicIpPrefixes}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/natGateways. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/networkIntentPolicies resources
function getNetworkIntentPolicies() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network intent-policy list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/networkIntentPolicies. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/virtualHubs resources
function getVirtualHubs() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network vhub list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, virtualWan:virtualWan.id, addressPrefix:addressPrefix, sku:sku, routeTable:routeTable}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/virtualHubs. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/applicationSecurityGroups resources
function getApplicationSecurityGroups() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network asg list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/applicationSecurityGroups. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/bastionHosts resources
function getBastionHosts() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network bastion list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, ipConfigurations:ipConfigurations, dnsName:dnsName}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/bastionHosts. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/ddosProtectionPlans resources
function getDdosProtectionPlans() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network ddos-protection list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, virtualNetworks:virtualNetworks}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/ddosProtectionPlans. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/connections resources
function getConnections() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network vpn-connection list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, connectionType:connectionType, virtualNetworkGateway1:virtualNetworkGateway1.id, virtualNetworkGateway2:virtualNetworkGateway2.id, localNetworkGateway2:localNetworkGateway2.id, sharedKey:sharedKey}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/connections. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.DevCenter/networkConnections resources
function getDevCenterNetworkConnections() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az devcenter admin network-connection list --query "[].{id:id, name:name, provisioningState:provisioningState, domainJoined:domainJoined, networkingResourceGroup:networkingResourceGroup, resourceGroup:resourceGroup, subscriptionId:subscriptionId, vnetName:vnetName, subnetName:subnetName}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.DevCenter/networkConnections. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/dnsResolvers/outboundEndpoints resources
function getDnsResolverOutboundEndpoints() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network dns-resolver outbound-endpoint list --query "[].{id:id, name:name, provisioningState:provisioningState, location:location, resourceGroup:resourceGroup, subnet:subnet.id, linkedResolver:linkedResolver.id}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/dnsResolvers/outboundEndpoints. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/dnsForwardingRulesets resources
function getDnsForwardingRulesets() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network dns-forwarding-ruleset list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, dnsResolverOutboundEndpoints:dnsResolverOutboundEndpoints}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/dnsForwardingRulesets. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/virtualWans resources
function getVirtualWans() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network vwan list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, type:type, disableVpnEncryption:disableVpnEncryption, allowBranchToBranchTraffic:allowBranchToBranchTraffic, allowVnetToVnetTraffic:allowVnetToVnetTraffic}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/virtualWans. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/serviceEndpointPolicies resources
function getServiceEndpointPolicies() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network service-endpoint policy list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, serviceEndpointPolicyDefinitions:serviceEndpointPolicyDefinitions}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/serviceEndpointPolicies. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/expressRouteGateways resources
function getExpressRouteGateways() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network express-route gateway list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, virtualHub:virtualHub.id}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/expressRouteGateways. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/dnsResolvers resources
function getDnsResolvers() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network dns-resolver list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, virtualNetworkId:virtualNetwork.id}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/dnsResolvers. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/dnsResolvers/inboundEndpoints resources
function getDnsResolverInboundEndpoints() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network dns-resolver inbound-endpoint list --query "[].{id:id, name:name, provisioningState:provisioningState, location:location, resourceGroup:resourceGroup, ipConfigurations:ipConfigurations}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/dnsResolvers/inboundEndpoints. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/publicIPPrefixes resources
function getPublicIPPrefixes() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network public-ip prefix list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, ipPrefix:ipPrefix, publicIPAddressVersion:publicIPAddressVersion}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/publicIPPrefixes. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/ipGroups resources
function getIPGroups() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network ip-group list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, ipAddresses:ipAddresses}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/ipGroups. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}

# Function to collect data for Microsoft.Network/networkManagers resources
function getNetworkManagers() {
 for ((retry=1; retry<=MAX_RETRIES; retry++)); do
   az network manager list --query "[].{id:id, name:name, location:location, resourceGroup:resourceGroup, provisioningState:provisioningState, networkManagerScopeAccesses:networkManagerScopeAccesses, networkManagerScopes:networkManagerScopes}" -o json 2>/dev/null
   if [[ $? -eq 0 ]]; then
     break
   else
     echo "Error collecting data for resource type: Microsoft.Network/networkManagers. Retry $retry/$MAX_RETRIES."
     sleep $RETRY_DELAY
   fi
 done
}