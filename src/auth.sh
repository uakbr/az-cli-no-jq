#!/bin/bash
# src/auth.sh

# Function to login to Azure using Azure CLI
function azLogin() {
  local auth_method=$1

  case $auth_method in
    browser)
      echo "Opening browser for login..."
      if az login > /dev/null 2>&1; then
        echo "Successfully logged in to Azure."
      else
        echo "Failed to login to Azure. Please try again."
        exit 1
      fi
      ;;
    service-principal)
      echo "Logging in using service principal..."
      if az login --service-principal -u "$AZURE_CLIENT_ID" -p "$AZURE_CLIENT_SECRET" --tenant "$AZURE_TENANT_ID" > /dev/null 2>&1; then
        echo "Successfully logged in to Azure."
      else
        echo "Failed to login to Azure using service principal. Please check your credentials."
        exit 1
      fi
      ;;
    interactive)
      echo "Logging in interactively..."
      if ! az account show > /dev/null 2>&1; then
        echo "Not logged in to Azure. Please provide your Azure credentials."
        read -p "Azure username: " username
        read -s -p "Azure password: " password
        echo
        if az login -u "$username" -p "$password" > /dev/null 2>&1; then
          echo "Successfully logged in to Azure."
        else
          echo "Failed to login to Azure. Please check your credentials and try again."
          exit 1
        fi
      else
        echo "Already logged in to Azure."
      fi
      ;;
    *)
      echo "Unknown authentication method: $auth_method"
      echo "Please use one of the following methods: browser, service-principal, interactive"
      exit 1
      ;;
  esac
}

# Function to get the list of accessible subscriptions
function getSubscriptions() {
  # Get list of all subscriptions accessible by the user
  local subscriptions=$(az account list --query "[].{id:id, name:name}" -o tsv 2>/dev/null)

  # Check if any subscriptions were found
  if [[ -z $subscriptions ]]; then
    echo "No accessible subscriptions found for the logged in user."
    exit 1
  fi

  # Display list of subscriptions and prompt user to select which ones to scan
  echo "Available subscriptions:"
  echo "$subscriptions" | awk '{print NR") "$0}'
  read -p "Enter the subscription numbers to scan (comma-separated): " selected_subs

  # Convert selected subscriptions to array
  IFS=',' read -r -a sub_numbers <<< "$selected_subs"

  # Initialize array to store selected subscription IDs and names
  local selected_sub_ids=()
  local selected_sub_names=()

  # Loop through selected subscription numbers and get corresponding IDs and names
  for sub_num in "${sub_numbers[@]}"; do
    sub_info=$(echo "$subscriptions" | awk -v n="$sub_num" 'NR==n {print $0}')
    sub_id=$(echo "$sub_info" | cut -f1)
    sub_name=$(echo "$sub_info" | cut -f2)
    selected_sub_ids+=("$sub_id")
    selected_sub_names+=("$sub_name")
  done

  # Return the arrays of selected subscription IDs and names
  echo "${selected_sub_ids[@]}"
  echo "${selected_sub_names[@]}"
}

# Function to set the active subscription
function setActiveSubscription() {
  local subscription_id=$1
  local subscription_name=$2

  # Set the active subscription
  if az account set --subscription "$subscription_id" > /dev/null 2>&1; then
    echo "Active subscription set to: $subscription_name (ID: $subscription_id)"
  else
    echo "Failed to set active subscription to: $subscription_name (ID: $subscription_id)"
    exit 1
  fi
}