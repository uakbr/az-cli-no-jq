#!/bin/bash
# src/analyze.sh

# Function to analyze collected resource data for potential security issues
function analyzeData() {
  local data=("$@")
  local findings=()

  for resource in "${data[@]}"; do
    local resource_type=$(echo "$resource" | grep -oP '"type": "\K[^"]+')
    local resource_name=$(echo "$resource" | grep -oP '"name": "\K[^"]+')
    local resource_id=$(echo "$resource" | grep -oP '"id": "\K[^"]+')

    echo "Analyzing resource: $resource_name ($resource_type)"

    # Call the respective analysis function based on resource type
    case $resource_type in
      "Microsoft.ApiManagement/service")
        analyzeApiManagementService "$resource"
        ;;
      "Microsoft.Compute/virtualMachines/extensions")
        analyzeVmExtension "$resource"
        ;;
      "Microsoft.Network/networkWatchers/connectionMonitors")
        analyzeConnectionMonitor "$resource"
        ;;
      "Microsoft.Insights/scheduledQueryRules")
        analyzeScheduledQueryRule "$resource"
        ;;
      "Microsoft.HybridCompute/machines")
        analyzeHybridMachine "$resource"
        ;;
      "Microsoft.Cdn/cdnWebApplicationFirewallPolicies")
        analyzeCdnWafPolicy "$resource"
        ;;
      "Microsoft.ResourceGraph/queries")
        analyzeResourceGraphQuery "$resource"
        ;;
      "Microsoft.Network/expressRouteCircuits")
        analyzeExpressRouteCircuit "$resource"
        ;;
      "Microsoft.Network/vpnGateways")
        analyzeVpnGateway "$resource"
        ;;
      "Microsoft.Network/virtualNetworkGateways")
        analyzeVirtualNetworkGateway "$resource"
        ;;
      "Microsoft.Resources/templateSpecs/versions")
        analyzeTemplateSpecVersion "$resource"
        ;;
      "Microsoft.DataLakeStore/accounts")
        analyzeDataLakeStoreAccount "$resource"
        ;;
      "Microsoft.AnalysisServices/servers")
        analyzeAnalysisServicesServer "$resource"
        ;;
      "Microsoft.Network/frontdoorWebApplicationFirewallPolicies")
        analyzeFrontDoorWafPolicy "$resource"
        ;;
      "Microsoft.Network/firewallPolicies")
        analyzeFirewallPolicy "$resource"
        ;;
      "Microsoft.Network/loadBalancers")
        analyzeLoadBalancer "$resource"
        ;;
      "Microsoft.Network/localNetworkGateways")
        analyzeLocalNetworkGateway "$resource"
        ;;
      "Microsoft.CognitiveServices/accounts")
        analyzeCognitiveServicesAccount "$resource"
        ;;
      "Microsoft.Search/searchServices")
        analyzeSearchService "$resource"
        ;;
      "Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies")
        analyzeAppGatewayWafPolicy "$resource"
        ;;
      "Microsoft.Network/azureFirewalls")
        analyzeAzureFirewall "$resource"
        ;;
      "Microsoft.Network/applicationGateways")
        analyzeApplicationGateway "$resource"
        ;;
      "Microsoft.Network/privateEndpoints")
        analyzePrivateEndpoint "$resource"
        ;;
      "Microsoft.ContainerRegistry/registries")
        analyzeContainerRegistry "$resource"
        ;;
      "Microsoft.Network/vpnSites")
        analyzeVpnSite "$resource"
        ;;
      "Microsoft.ContainerService/managedClusters")
        analyzeManagedCluster "$resource"
        ;;
      "Microsoft.Web/sites/slots")
        analyzeWebAppSlot "$resource"
        ;;
      "Microsoft.Network/routeTables")
        analyzeRouteTable "$resource"
        ;;
      "Microsoft.DocumentDB/databaseAccounts")
        analyzeCosmosDBAccount "$resource"
        ;;
      "Microsoft.Web/sites")
        analyzeWebApp "$resource"
        ;;
      "Microsoft.Network/publicIPAddresses")
        analyzePublicIpAddress "$resource"
        ;;
      "Microsoft.KeyVault/vaults")
        analyzeKeyVault "$resource"
        ;;
      "Microsoft.Network/networkSecurityGroups")
        analyzeNSG "$resource"
        ;;
      "Microsoft.Network/virtualNetworks")
        analyzeVirtualNetwork "$resource"
        ;;
      "Microsoft.Storage/storageAccounts")
        analyzeStorageAccount "$resource"
        ;;
      "Microsoft.Network/networkInterfaces")
        analyzeNetworkInterface "$resource"
        ;;
      "Microsoft.Network/natGateways")
        analyzeNatGateway "$resource"
        ;;
      "Microsoft.Network/networkIntentPolicies")
        analyzeNetworkIntentPolicy "$resource"
        ;;
      "Microsoft.Network/virtualHubs")
        analyzeVirtualHub "$resource"
        ;;
      "Microsoft.Network/applicationSecurityGroups")
        analyzeApplicationSecurityGroup "$resource"
        ;;
      "Microsoft.Network/bastionHosts")
        analyzeBastionHost "$resource"
        ;;
      "Microsoft.Network/ddosProtectionPlans")
        analyzeDdosProtectionPlan "$resource"
        ;;
      "Microsoft.Network/connections")
        analyzeConnection "$resource"
        ;;
      "Microsoft.DevCenter/networkConnections")
        analyzeDevCenterNetworkConnection "$resource"
        ;;
      "Microsoft.Network/dnsResolvers/outboundEndpoints")
        analyzeDnsResolverOutboundEndpoint "$resource"
        ;;
      "Microsoft.Network/dnsForwardingRulesets")
        analyzeDnsForwardingRuleset "$resource"
        ;;
      "Microsoft.Network/virtualWans")
        analyzeVirtualWan "$resource"
        ;;
      "Microsoft.Network/serviceEndpointPolicies")
        analyzeServiceEndpointPolicy "$resource"
        ;;
      "Microsoft.Network/expressRouteGateways")
        analyzeExpressRouteGateway "$resource"
        ;;
      "Microsoft.Network/dnsResolvers")
        analyzeDnsResolver "$resource"
        ;;
      "Microsoft.Network/dnsResolvers/inboundEndpoints")
        analyzeDnsResolverInboundEndpoint "$resource"
        ;;
      "Microsoft.Network/publicIPPrefixes")
        analyzePublicIPPrefix "$resource"
        ;;
      "Microsoft.Network/ipGroups")
        analyzeIPGroup "$resource"
        ;;
      "Microsoft.Network/networkManagers")
        analyzeNetworkManager "$resource"
        ;;
      *)
        echo "Unknown resource type: $resource_type"
        ;;
    esac

    # Append findings to the findings array
    findings+=("${FINDINGS[@]}")
    unset FINDINGS
  done

  # Return the findings as a JSON string
  echo "${findings[@]}" | sed 's/"/\\"/g' | sed 's/\[/\\\[/g' | sed 's/\]/\\\]/g' | sed 's/\\\{/\{/g' | sed 's/\\\}/\}/g'
}

# Analysis functions for each resource type
function analyzeApiManagementService() {
  local resource=$1

  # Check if API Management service is not using the Premium SKU
  if [[ $(echo "$resource" | grep -oP '"sku":\s*{\s*"name":\s*"\K[^"]+') != "Premium" ]]; then
    FINDINGS+=("API Management service $resource_name is not using the Premium SKU")
  fi

  # Check if API Management service has public network access enabled
  if [[ $(echo "$resource" | grep -oP '"publicNetworkAccess":\s*"\K[^"]+') == "Enabled" ]]; then
    FINDINGS+=("API Management service $resource_name has public network access enabled")
  fi

  # Check if API Management service is not connected to a virtual network
  if [[ $(echo "$resource" | grep -oP '"virtualNetworkType":\s*"\K[^"]+') == "None" ]]; then
    FINDINGS+=("API Management service $resource_name is not connected to a virtual network")
  fi
}

function analyzeVmExtension() {
  local resource=$1

  local extension_type=$(echo "$resource" | grep -oP '"type":\s*"\K[^"]+')
  local extension_publisher=$(echo "$resource" | grep -oP '"publisher":\s*"\K[^"]+')
  local extension_provisioning_state=$(echo "$resource" | grep -oP '"provisioningState":\s*"\K[^"]+')

  # Check if VM extension provisioning state is not 'Succeeded'
  if [[ $extension_provisioning_state != "Succeeded" ]]; then
    FINDINGS+=("VM extension $resource_name has a provisioning state of $extension_provisioning_state")
  fi

  case $extension_type in
    "AzureDiskEncryption")
      # Check if Azure Disk Encryption extension is not enabled
      if [[ $(echo "$resource" | grep -oP '"EncryptionOperation":\s*"\K[^"]+') != "EnableEncryption" ]]; then
        FINDINGS+=("Azure Disk Encryption extension $resource_name is not enabled")
      fi
      ;;
    "MicrosoftMonitoringAgent")
      # Check if Microsoft Monitoring Agent extension is not connected to a Log Analytics workspace
      if [[ $(echo "$resource" | grep -oP '"workspaceId":\s*"\K[^"]+') == "" ]]; then
        FINDINGS+=("Microsoft Monitoring Agent extension $resource_name is not connected to a Log Analytics workspace")
      fi
      ;;
    "DependencyAgentWindows" | "DependencyAgentLinux")
      # Check if Dependency Agent extension is not enabled for Azure Monitor for VMs
      if [[ $(echo "$resource" | grep -oP '"enableAMA":\s*\K[^,}]+') != "true" ]]; then
        FINDINGS+=("Dependency Agent extension $resource_name is not enabled for Azure Monitor for VMs")
      fi
      ;;
    "IaaSAntimalware")
      # Check if Antimalware extension is not enabled
      if [[ $(echo "$resource" | grep -oP '"AntimalwareEnabled":\s*\K[^,}]+') != "true" ]]; then
        FINDINGS+=("Antimalware extension $resource_name is not enabled")
      fi
      ;;
    *)
      echo "Unknown VM extension type: $extension_type"
      ;;
  esac
}

function analyzeConnectionMonitor() {
  local resource=$1

  local endpoint_count=$(echo "$resource" | grep -oP '"endpoints":\s*\K[^,}\]]*' | grep -o '{' | wc -l)
  local test_group_count=$(echo "$resource" | grep -oP '"testGroups":\s*\K[^,}\]]*' | grep -o '{' | wc -l)

  # Check if connection monitor has no endpoints defined
  if [[ $endpoint_count -eq 0 ]]; then
    FINDINGS+=("Connection monitor $resource_name has no endpoints defined")
  fi

  # Check if connection monitor has no test groups defined
  if [[ $test_group_count -eq 0 ]]; then
    FINDINGS+=("Connection monitor $resource_name has no test groups defined")
  fi
}

function analyzeScheduledQueryRule() {
  local resource=$1

  local query=$(echo "$resource" | grep -oP '"query":\s*"\K[^"]+')
  local frequency=$(echo "$resource" | grep -oP '"frequencyInMinutes":\s*\K\d+')

  # Check if scheduled query rule has no query defined
  if [[ -z $query ]]; then
    FINDINGS+=("Scheduled query rule $resource_name has no query defined")
  fi

  # Check if scheduled query rule has a frequency greater than 60 minutes
  if [[ $frequency -gt 60 ]]; then
    FINDINGS+=("Scheduled query rule $resource_name has a frequency greater than 60 minutes")
  fi
}

function analyzeHybridMachine() {
  local resource=$1

  local os_name=$(echo "$resource" | grep -oP '"osName":\s*"\K[^"]+')
  local os_version=$(echo "$resource" | grep -oP '"osVersion":\s*"\K[^"]+')
  local provisioning_state=$(echo "$resource" | grep -oP '"provisioningState":\s*"\K[^"]+')

  # Check if hybrid machine has an unknown OS name
  if [[ $os_name != "Windows" && $os_name != "Linux" ]]; then
    FINDINGS+=("Hybrid machine $resource_name has an unknown OS name: $os_name")
  fi

  # Check if hybrid machine has a provisioning state other than 'Succeeded'
  if [[ $provisioning_state != "Succeeded" ]]; then
    FINDINGS+=("Hybrid machine $resource_name has a provisioning state of $provisioning_state")
  fi
}

function analyzeCdnWafPolicy() {
  local resource=$1

  local policy_enabled=$(echo "$resource" | grep -oP '"enabledState":\s*"\K[^"]+')
  local mode=$(echo "$resource" | grep -oP '"mode":\s*"\K[^"]+')

  # Check if CDN WAF policy is not enabled
  if [[ $policy_enabled != "Enabled" ]]; then
    FINDINGS+=("CDN WAF policy $resource_name is not enabled")
  fi

  # Check if CDN WAF policy is not in Prevention mode
  if [[ $mode != "Prevention" ]]; then
    FINDINGS+=("CDN WAF policy $resource_name is not in Prevention mode")
  fi
}

function analyzeResourceGraphQuery() {
  local resource=$1

  local query=$(echo "$resource" | grep -oP '"query":\s*"\K[^"]+')

  # Check if Resource Graph query has no query defined
  if [[ -z $query ]]; then
    FINDINGS+=("Resource Graph query $resource_name has no query defined")
  fi

  # Check if Resource Graph query contains potentially expensive operations (join or union)
  if [[ $query =~ (join|union) ]]; then
    FINDINGS+=("Resource Graph query $resource_name contains a potentially expensive operation (join or union)")
  fi
}

function analyzeExpressRouteCircuit() {
  local resource=$1

  local sku_tier=$(echo "$resource" | grep -oP '"tier":\s*"\K[^"]+')
  local peering_location=$(echo "$resource" | grep -oP '"peeringLocation":\s*"\K[^"]+')

  # Check if Express Route circuit is using the Standard SKU
  if [[ $sku_tier == "Standard" ]]; then
    FINDINGS+=("Express Route circuit $resource_name is using the Standard SKU (consider upgrading to Premium)")
  fi

  # Check if Express Route circuit has no peering location defined
  if [[ -z $peering_location ]]; then
    FINDINGS+=("Express Route circuit $resource_name has no peering location defined")
  fi
}

function analyzeVpnGateway() {
  local resource=$1

  local gateway_type=$(echo "$resource" | grep -oP '"gatewayType":\s*"\K[^"]+')
  local vpn_type=$(echo "$resource" | grep -oP '"vpnType":\s*"\K[^"]+')

  # Check if VPN gateway has an unexpected gateway type
  if [[ $gateway_type != "Vpn" ]]; then
    FINDINGS+=("VPN gateway $resource_name has an unexpected gateway type: $gateway_type")
  fi

# Check if VPN gateway is not using route-based VPN
 if [[ $vpn_type != "RouteBased" ]]; then
   FINDINGS+=("VPN gateway $resource_name is not using route-based VPN")
 fi
}

function analyzeVirtualNetworkGateway() {
 local resource=$1

 local sku_name=$(echo "$resource" | grep -oP '"name":\s*"\K[^"]+')
 local active_active=$(echo "$resource" | grep -oP '"activeActive":\s*\K[^,}]+')

 # Check if virtual network gateway is using the Basic SKU
 if [[ $sku_name == "Basic" ]]; then
   FINDINGS+=("Virtual network gateway $resource_name is using the Basic SKU (consider upgrading)")
 fi

 # Check if virtual network gateway does not have active-active mode enabled
 if [[ $active_active != "true" ]]; then
   FINDINGS+=("Virtual network gateway $resource_name does not have active-active mode enabled")
 fi
}

function analyzeTemplateSpecVersion() {
 local resource=$1

 local version_description=$(echo "$resource" | grep -oP '"description":\s*"\K[^"]+')
 local artifact_type=$(echo "$resource" | grep -oP '"kind":\s*"\K[^"]+')

 # Check if template spec version has no description
 if [[ -z $version_description ]]; then
   FINDINGS+=("Template spec version $resource_name has no description")
 fi

 # Check if template spec version has an unexpected artifact type
 if [[ $artifact_type != "template" ]]; then
   FINDINGS+=("Template spec version $resource_name has an unexpected artifact type: $artifact_type")
 fi
}

function analyzeDataLakeStoreAccount() {
 local resource=$1

 local encryption_state=$(echo "$resource" | grep -oP '"encryptionState":\s*"\K[^"]+')
 local firewall_state=$(echo "$resource" | grep -oP '"firewallState":\s*"\K[^"]+')

 # Check if Data Lake Store account does not have encryption enabled
 if [[ $encryption_state != "Enabled" ]]; then
   FINDINGS+=("Data Lake Store account $resource_name does not have encryption enabled")
 fi

 # Check if Data Lake Store account does not have firewall enabled
 if [[ $firewall_state != "Enabled" ]]; then
   FINDINGS+=("Data Lake Store account $resource_name does not have firewall enabled")
 fi
}

function analyzeAnalysisServicesServer() {
 local resource=$1

 local backup_blob_container_uri=$(echo "$resource" | grep -oP '"backupBlobContainerUri":\s*"\K[^"]+')
 local query_pool_connection_mode=$(echo "$resource" | grep -oP '"queryPoolConnectionMode":\s*"\K[^"]+')

 # Check if Analysis Services server has no backup blob container URI defined
 if [[ -z $backup_blob_container_uri ]]; then
   FINDINGS+=("Analysis Services server $resource_name has no backup blob container URI defined")
 fi

 # Check if Analysis Services server is not using the 'All' query pool connection mode
 if [[ $query_pool_connection_mode != "All" ]]; then
   FINDINGS+=("Analysis Services server $resource_name is not using the 'All' query pool connection mode")
 fi
}

function analyzeFrontDoorWafPolicy() {
 local resource=$1

 local enabled_state=$(echo "$resource" | grep -oP '"enabledState":\s*"\K[^"]+')
 local mode=$(echo "$resource" | grep -oP '"mode":\s*"\K[^"]+')

 # Check if Front Door WAF policy is not enabled
 if [[ $enabled_state != "Enabled" ]]; then
   FINDINGS+=("Front Door WAF policy $resource_name is not enabled")
 fi

 # Check if Front Door WAF policy is not in Prevention mode
 if [[ $mode != "Prevention" ]]; then
   FINDINGS+=("Front Door WAF policy $resource_name is not in Prevention mode")
 fi
}

function analyzeFirewallPolicy() {
 local resource=$1

 local threat_intel_mode=$(echo "$resource" | grep -oP '"threatIntelMode":\s*"\K[^"]+')
 local sql_injection_detection=$(echo "$resource" | grep -oP '"mode":\s*"\K[^"]+')

 # Check if firewall policy has threat intelligence mode turned off
 if [[ $threat_intel_mode == "Off" ]]; then
   FINDINGS+=("Firewall policy $resource_name has threat intelligence mode turned off")
 fi

 # Check if firewall policy does not have SQL injection detection set to Prevent
 if [[ $sql_injection_detection != "Prevent" ]]; then
   FINDINGS+=("Firewall policy $resource_name does not have SQL injection detection set to Prevent")
 fi
}

function analyzeLoadBalancer() {
 local resource=$1

 local sku_name=$(echo "$resource" | grep -oP '"name":\s*"\K[^"]+')
 local probe_count=$(echo "$resource" | grep -oP '"probes":\s*\K[^,}\]]*' | grep -o '{' | wc -l)

 # Check if load balancer is using the Basic SKU
 if [[ $sku_name == "Basic" ]]; then
   FINDINGS+=("Load balancer $resource_name is using the Basic SKU (consider upgrading to Standard)")
 fi

 # Check if load balancer has no health probes defined
 if [[ $probe_count -eq 0 ]]; then
   FINDINGS+=("Load balancer $resource_name has no health probes defined")
 fi
}

function analyzeLocalNetworkGateway() {
 local resource=$1

 local gateway_ip_address=$(echo "$resource" | grep -oP '"gatewayIpAddress":\s*"\K[^"]+')

 # Check if local network gateway has no gateway IP address defined
 if [[ -z $gateway_ip_address ]]; then
   FINDINGS+=("Local network gateway $resource_name has no gateway IP address defined")
 fi
}

function analyzeCognitiveServicesAccount() {
 local resource=$1

 local sku_name=$(echo "$resource" | grep -oP '"name":\s*"\K[^"]+')
 local network_acls_default_action=$(echo "$resource" | grep -oP '"defaultAction":\s*"\K[^"]+')

 # Check if Cognitive Services account is using the free tier (F0)
 if [[ $sku_name == "F0" ]]; then
   FINDINGS+=("Cognitive Services account $resource_name is using the free tier (F0)")
 fi

 # Check if Cognitive Services account does not have network ACLs set to deny by default
 if [[ $network_acls_default_action != "Deny" ]]; then
   FINDINGS+=("Cognitive Services account $resource_name does not have network ACLs set to deny by default")
 fi
}

function analyzeSearchService() {
 local resource=$1

 local partition_count=$(echo "$resource" | grep -oP '"partitionCount":\s*\K[^,}]+')
 local replica_count=$(echo "$resource" | grep -oP '"replicaCount":\s*\K[^,}]+')

 # Check if search service has less than 2 partitions
 if [[ $partition_count -lt 2 ]]; then
   FINDINGS+=("Search service $resource_name has less than 2 partitions")
 fi

 # Check if search service has less than 2 replicas
 if [[ $replica_count -lt 2 ]]; then
   FINDINGS+=("Search service $resource_name has less than 2 replicas")
 fi
}

function analyzeAppGatewayWafPolicy() {
 local resource=$1

 local policy_settings=$(echo "$resource" | grep -oP '"policySettings":\s*\K[^,}]+')
 local managed_rules=$(echo "$resource" | grep -oP '"managedRules":\s*\K[^,}]+')

 # Check if application gateway WAF policy has no policy settings defined
 if [[ -z $policy_settings ]]; then
   FINDINGS+=("Application Gateway WAF policy $resource_name has no policy settings defined")
 fi

 # Check if application gateway WAF policy has no managed rules defined
 if [[ -z $managed_rules ]]; then
   FINDINGS+=("Application Gateway WAF policy $resource_name has no managed rules defined")
 fi
}

function analyzeAzureFirewall() {
 local resource=$1

 local threat_intel_mode=$(echo "$resource" | grep -oP '"threatIntelMode":\s*"\K[^"]+')
 local virtual_hub=$(echo "$resource" | grep -oP '"virtualHub":\s*\K[^,}]+')

 # Check if Azure Firewall has threat intel mode set to Alert or Deny
 if [[ $threat_intel_mode != "Alert" && $threat_intel_mode != "Deny" ]]; then
   FINDINGS+=("Azure Firewall $resource_name has threat intel mode set to $threat_intel_mode (should be Alert or Deny)")
 fi

 # Check if Azure Firewall is associated with a virtual hub
 if [[ -n $virtual_hub ]]; then
   FINDINGS+=("Azure Firewall $resource_name is associated with a virtual hub (consider using a hub-spoke topology)")
 fi
}

function analyzeApplicationGateway() {
 local resource=$1

 local sku_name=$(echo "$resource" | grep -oP '"name":\s*"\K[^"]+')
 local waf_configuration=$(echo "$resource" | grep -oP '"webApplicationFirewallConfiguration":\s*\K[^,}]+')

 # Check if application gateway is not using a v2 SKU
 if [[ $sku_name != "Standard_v2" && $sku_name != "WAF_v2" ]]; then
   FINDINGS+=("Application Gateway $resource_name is not using a v2 SKU")
 fi

 # Check if application gateway does not have WAF enabled
 if [[ -z $waf_configuration ]]; then
   FINDINGS+=("Application Gateway $resource_name does not have WAF enabled")
 fi
}

function analyzePrivateEndpoint() {
 local resource=$1

 local private_link_service_connections=$(echo "$resource" | grep -oP '"privateLinkServiceConnections":\s*\K[^,}]*')

 # Check if private endpoint has no private link service connections
 if [[ -z $private_link_service_connections ]]; then
   FINDINGS+=("Private Endpoint $resource_name has no private link service connections")
 fi
}

function analyzeContainerRegistry() {
 local resource=$1

 local admin_user_enabled=$(echo "$resource" | grep -oP '"adminUserEnabled":\s*\K[^,}]+')
 local network_rule_set=$(echo "$resource" | grep -oP '"defaultAction":\s*"\K[^"]+')

 # Check if container registry has admin user enabled
 if [[ $admin_user_enabled == "true" ]]; then
   FINDINGS+=("Container Registry $resource_name has admin user enabled")
 fi

 # Check if container registry does not have network rules set to deny by default
 if [[ $network_rule_set != "Deny" ]]; then
   FINDINGS+=("Container Registry $resource_name does not have network rules set to deny by default")
 fi
}

function analyzeVpnSite() {
 local resource=$1

 local virtual_wan=$(echo "$resource" | grep -oP '"virtualWan":\s*\K[^,}]+')
 local address_space=$(echo "$resource" | grep -oP '"addressSpace":\s*\K[^,}]+')

 # Check if VPN Site is not associated with a Virtual WAN
 if [[ -z $virtual_wan ]]; then
   FINDINGS+=("VPN Site $resource_name is not associated with a Virtual WAN")
 fi

 # Check if VPN Site has no address space defined
 if [[ -z $address_space ]]; then
   FINDINGS+=("VPN Site $resource_name has no address space defined")
 fi
}

function analyzeManagedCluster() {
 local resource=$1

 local kubernetes_version=$(echo "$resource" | grep -oP '"kubernetesVersion":\s*"\K[^"]+"')
 local network_plugin=$(echo "$resource" | grep -oP '"networkPlugin":\s*"\K[^"]+"')

 # Check if managed cluster (AKS) is using an outdated Kubernetes version
 if [[ ! $kubernetes_version =~ ^1\.(2[1-9]|[3-9][0-9])\. ]]; then
   FINDINGS+=("Managed Cluster (AKS) $resource_name is using an outdated Kubernetes version: $kubernetes_version")
 fi

 # Check if managed cluster (AKS) is not using the Azure CNI network plugin
 if [[ $network_plugin != "azure" ]]; then
   FINDINGS+=("Managed Cluster (AKS) $resource_name is not using the Azure CNI network plugin")
 fi
}

function analyzeWebAppSlot() {
 local resource=$1

 local https_only=$(echo "$resource" | grep -oP '"httpsOnly":\s*\K[^,}]+')
 local min_tls_version=$(echo "$resource" | grep -oP '"minTlsVersion":\s*"\K[^"]+')

 # Check if web app slot does not have HTTPS only enabled
 if [[ $https_only != "true" ]]; then
   FINDINGS+=("Web App Slot $resource_name does not have HTTPS only enabled")
 fi

 # Check if web app slot is not using the minimum TLS version of 1.2
 if [[ $min_tls_version != "1.2" ]]; then
   FINDINGS+=("Web App Slot $resource_name is not using the minimum TLS version of 1.2")
 fi
}

function analyzeRouteTable() {
 local resource=$1

 local routes=$(echo "$resource" | grep -oP '"routes":\s*\K[^,}]+')

 # Check if route table has no routes defined
 if [[ -z $routes ]]; then
   FINDINGS+=("Route Table $resource_name has no routes defined")
 fi

 # Check for any routes with 0.0.0.0/0 next hop
 if [[ $routes =~ "0.0.0.0/0" ]]; then
   FINDINGS+=("Route Table $resource_name has a route with 0.0.0.0/0 next hop (potential security risk)")
 fi
}

function analyzeCosmosDBAccount() {
 local resource=$1

 local public_network_access=$(echo "$resource" | grep -oP '"publicNetworkAccess":\s*"\K[^"]+"')
 local backup_interval=$(echo "$resource" | grep -oP '"backupIntervalInMinutes":\s*\K[^,}]+')

 # Check if Cosmos DB account has public network access enabled
 if [[ $public_network_access != "Disabled" ]]; then
   FINDINGS+=("Cosmos DB account $resource_name has public network access enabled")
 fi

 # Check if Cosmos DB account has a backup interval greater than 4 hours
 if [[ $backup_interval -gt 240 ]]; then
   FINDINGS+=("Cosmos DB account $resource_name has a backup interval greater than 4 hours")
 fi
}

function analyzeWebApp() {
 local resource=$1

 local https_only=$(echo "$resource" | grep -oP '"httpsOnly":\s*\K[^,}]+')
 local client_cert_enabled=$(echo "$resource" | grep -oP '"clientCertEnabled":\s*\K[^,}]+')

 # Check if web app does not have HTTPS only enabled
 if [[ $https_only != "true" ]]; then
   FINDINGS+=("Web App $resource_name does not have HTTPS only enabled")
 fi

 # Check if web app does not have client certificates enabled
 if [[ $client_cert_enabled != "true" ]]; then
   FINDINGS+=("Web App $resource_name does not have client certificates enabled")
 fi
}

function analyzePublicIpAddress() {
 local resource=$1

 local allocation_method=$(echo "$resource" | grep -oP '"publicIPAllocationMethod":\s*"\K[^"]+')
 local idle_timeout=$(echo "$resource" | grep -oP '"idleTimeoutInMinutes":\s*\K[^,}]+')

 # Check if public IP address is not using static allocation
 if [[ $allocation_method != "Static" ]]; then
   FINDINGS+=("Public IP address $resource_name is not using static allocation")
 fi

 # Check if public IP address has an idle timeout less than 5 minutes
 if [[ $idle_timeout -lt 5 ]]; then
   FINDINGS+=("Public IP address $resource_name has an idle timeout less than 5 minutes")
 fi
}

function analyzeKeyVault() {
 local resource=$1

 local soft_delete_enabled=$(echo "$resource" | grep -oP '"enableSoftDelete":\s*\K[^,}]+')
 local purge_protection_enabled=$(echo "$resource" | grep -oP '"enablePurgeProtection":\s*\K[^,}]+')

 # Check if key vault does not have soft delete enabled
 if [[ $soft_delete_enabled != "true" ]]; then
   FINDINGS+=("Key Vault $resource_name does not have soft delete enabled")
 fi

 # Check if key vault does not have purge protection enabled
 if [[ $purge_protection_enabled != "true" ]]; then
   FINDINGS+=("Key Vault $resource_name does not have purge protection enabled")
 fi
}

function analyzeNSG() {
 local resource=$1

 local default_security_rules=$(echo "$resource" | grep -oP '"defaultSecurityRules":\s*\K[^,}]+')
 local security_rules=$(echo "$resource" | grep -oP '"securityRules":\s*\K[^,}]+')

 # Check for any rules allowing inbound access from '*' or '0.0.0.0/0'
 if [[ $default_security_rules =~ (\"[^\"]*\*[^\"]*\"|\"0\.0\.0\.0\/0\") ]]; then
   FINDINGS+=("NSG $resource_name has a default security rule allowing inbound access from any source")
 fi

 if [[ $security_rules =~ (\"[^\"]*\*[^\"]*\"|\"0\.0\.0\.0\/0\") ]]; then
   FINDINGS+=("NSG $resource_name has a security rule allowing inbound access from any source")
 fi
}

function analyzeVirtualNetwork() {
 local resource=$1

 local address_space=$(echo "$resource" | grep -oP '"addressPrefixes":\s*\K[^,}]+')
 local subnets=$(echo "$resource" | grep -oP '"subnets":\s*\K[^,}]+')

 # Check for any address space larger than /8
 if [[ $address_space =~ \/[1-7][^0-9] ]]; then
   FINDINGS+=("Virtual Network $resource_name has an address space larger than /8: $address_space")
 fi

 # Check if virtual network has no subnets defined
 if [[ -z $subnets ]]; then
   FINDINGS+=("Virtual Network $resource_name has no subnets defined")
 fi
}

function analyzeStorageAccount() {
 local resource=$1

 local https_traffic_only=$(echo "$resource" | grep -oP '"supportsHttpsTrafficOnly":\s*\K[^,}]+')
 local network_acls_default_action=$(echo "$resource" | grep -oP '"defaultAction":\s*"\K[^"]+"')

 # Check if storage account does not have HTTPS traffic only enabled
 if [[ $https_traffic_only != "true" ]]; then
   FINDINGS+=("Storage Account $resource_name does not have HTTPS traffic only enabled")
 fi

 # Check if storage account does not have network ACLs set to deny by default
 if [[ $network_acls_default_action != "Deny" ]]; then
   FINDINGS+=("Storage Account $resource_name does not have network ACLs set to deny by default")
 fi
}

function analyzeNetworkInterface() {
 local resource=$1

 local ip_forwarding=$(echo "$resource" | grep -oP '"enableIPForwarding":\s*\K[^,}]+')
 local accelerated_networking=$(echo "$resource" | grep -oP '"enableAcceleratedNetworking":\s*\K[^,}]+')

 # Check if network interface has IP forwarding enabled
 if [[ $ip_forwarding == "true" ]]; then
   FINDINGS+=("Network Interface $resource_name has IP forwarding enabled")
 fi

 # Check if network interface does not have accelerated networking enabled
 if [[ $accelerated_networking != "true" ]]; then
   FINDINGS+=("Network Interface $resource_name does not have accelerated networking enabled")
 fi
}

function analyzeNatGateway() {
 local resource=$1

 # Check if NAT Gateway has no public IP addresses defined
 if [[ $(echo "$resource" | grep -oP '"publicIpAddresses":\s*\K[^,}]+' | grep -o '{' | wc -l) -eq 0 ]]; then
   FINDINGS+=("NAT Gateway $resource_name has no public IP addresses defined")
 fi

 # Check if NAT Gateway has an idle timeout less than 4 minutes
 local idle_timeout=$(echo "$resource" | grep -oP '"idleTimeoutInMinutes":\s*\K\d+')
 if [[ $idle_timeout -lt 4 ]]; then
   FINDINGS+=("NAT Gateway $resource_name has an idle timeout less than 4 minutes")
 fi
}

function analyzeNetworkIntentPolicy() {
 local resource=$1

 # Check if Network Intent Policy has no resource group defined
 if [[ -z $(echo "$resource" | grep -oP '"resourceGroup":\s*"\K[^"]+"') ]]; then
   FINDINGS+=("Network Intent Policy $resource_name has no resource group defined")
 fi
}

function analyzeVirtualHub() {
 local resource=$1

 # Check if Virtual Hub has no address prefix defined
 if [[ -z $(echo "$resource" | grep -oP '"addressPrefix":\s*"\K[^"]+"') ]]; then
   FINDINGS+=("Virtual Hub $resource_name has no address prefix defined")
 fi
}

function analyzeApplicationSecurityGroup() {
 local resource=$1

 # Check if Application Security Group provisioning state is not 'Succeeded'
 if [[ $(echo "$resource" | grep -oP '"provisioningState":\s*"\K[^"]+"') != "Succeeded" ]]; then
   FINDINGS+=("Application Security Group $resource_name provisioning state is not 'Succeeded'")
 fi
}

function analyzeBastionHost() {
 local resource=$1

 # Check if Bastion Host has no DNS name defined
 if [[ -z $(echo "$resource" | grep -oP '"dnsName":\s*"\K[^"]+"') ]]; then
   FINDINGS+=("Bastion Host $resource_name has no DNS name defined")
 fi
}

function analyzeDdosProtectionPlan() {
 local resource=$1

 # Check if DDOS Protection Plan has no associated virtual networks
 if [[ $(echo "$resource" | grep -oP '"virtualNetworks":\s*\K[^,}]+' | grep -o '{' | wc -l) -eq 0 ]]; then
   FINDINGS+=("DDOS Protection Plan $resource_name has no associated virtual networks")
 fi
}

function analyzeConnection() {
 local resource=$1
 local connection_type=$(echo "$resource" | grep -oP '"connectionType":\s*"\K[^"]+"')

 # Check if connection type is invalid
 if [[ $connection_type != "IPsec" && $connection_type != "ExpressRoute" ]]; then
   FINDINGS+=("Connection $resource_name has an invalid connection type: $connection_type")
 fi

 # Check if connection is missing one or both virtual network gateways
 if [[ -z $(echo "$resource" | grep -oP '"virtualNetworkGateway1":\s*{\s*"id":\s*"\K[^"]+"') || -z $(echo "$resource" | grep -oP '"virtualNetworkGateway2":\s*{\s*"id":\s*"\K[^"]+"') ]]; then
   FINDINGS+=("Connection $resource_name is missing one or both virtual network gateways")
 fi
}

function analyzeDevCenterNetworkConnection() {
 local resource=$1

 # Check if DevCenter Network Connection is not domain joined
 if [[ $(echo "$resource" | grep -oP '"domainJoined":\s*\K[^,}]+') != "true" ]]; then
   FINDINGS+=("DevCenter Network Connection $resource_name is not domain joined")
 fi
}

function analyzeDnsResolverOutboundEndpoint() {
 local resource=$1

 # Check if DNS Resolver Outbound Endpoint has no linked resolver
 if [[ -z $(echo "$resource" | grep -oP '"linkedResolver":\s*{\s*"id":\s*"\K[^"]+"') ]]; then
   FINDINGS+=("DNS Resolver Outbound Endpoint $resource_name has no linked resolver")
 fi
}

function analyzeDnsForwardingRuleset() {
 local resource=$1

 # Check if DNS Forwarding Ruleset has no outbound endpoints defined
 if [[ $(echo "$resource" | grep -oP '"dnsResolverOutboundEndpoints":\s*\K[^,}]+' | grep -o '{' | wc -l) -eq 0 ]]; then
   FINDINGS+=("DNS Forwarding Ruleset $resource_name has no outbound endpoints defined")
 fi
}

function analyzeVirtualWan() {
 local resource=$1

 # Check if Virtual WAN does not allow VNet-to-VNet traffic
 if [[ $(echo "$resource" | grep -oP '"allowVnetToVnetTraffic":\s*\K[^,}]+') != "true" ]]; then
   FINDINGS+=("Virtual WAN $resource_name does not allow VNet-to-VNet traffic")
 fi
}

function analyzeServiceEndpointPolicy() {
 local resource=$1

 # Check if Service Endpoint Policy has no policy definitions
 if [[ $(echo "$resource" | grep -oP '"serviceEndpointPolicyDefinitions":\s*\K[^,}]+' | grep -o '{' | wc -l) -eq 0 ]]; then
   FINDINGS+=("Service Endpoint Policy $resource_name has no policy definitions")
 fi
}

function analyzeExpressRouteGateway() {
 local resource=$1

 # Check if Express Route Gateway is not associated with a virtual hub
 if [[ -z $(echo "$resource" | grep -oP '"virtualHub":\s*{\s*"id":\s*"\K[^"]+"') ]]; then
   FINDINGS+=("Express Route Gateway $resource_name is not associated with a virtual hub")
 fi
}

function analyzeDnsResolver() {
 local resource=$1

 # Check if DNS Resolver has no virtual network ID
 if [[ -z $(echo "$resource" | grep -oP '"virtualNetwork":\s*{\s*"id":\s*"\K[^"]+"') ]]; then
   FINDINGS+=("DNS Resolver $resource_name has no virtual network ID")
 fi
}

function analyzeDnsResolverInboundEndpoint() {
 local resource=$1

 # Check if DNS Resolver Inbound Endpoint has no IP configurations
 if [[ $(echo "$resource" | grep -oP '"ipConfigurations":\s*\K[^,}]+' | grep -o '{' | wc -l) -eq 0 ]]; then
   FINDINGS+=("DNS Resolver Inbound Endpoint $resource_name has no IP configurations")
 fi
}

function analyzePublicIPPrefix() {
 local resource=$1

 # Check if Public IP Prefix has no IP prefix defined
 if [[ -z $(echo "$resource" | grep -oP '"ipPrefix":\s*"\K[^"]+"') ]]; then
   FINDINGS+=("Public IP Prefix $resource_name has no IP prefix defined")
 fi
}

function analyzeIPGroup() {
 local resource=$1

 # Check if IP Group has no IP addresses defined
 if [[ $(echo "$resource" | grep -oP '"ipAddresses":\s*\K[^,}]+' | grep -o '[^[:space:]]' | wc -l) -eq 0 ]]; then
   FINDINGS+=("IP Group $resource_name has no IP addresses defined")
 fi
}

function analyzeNetworkManager() {
 local resource=$1

 # Check if Network Manager has no scope accesses defined
 if [[ $(echo "$resource" | grep -oP '"networkManagerScopeAccesses":\s*\K[^,}]+' | grep -o '{' | wc -l) -eq 0 ]]; then
   FINDINGS+=("Network Manager $resource_name has no scope accesses defined")
 fi
}

# Run analysis
analyzeData "$@"