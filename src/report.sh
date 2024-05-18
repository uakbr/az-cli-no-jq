#!/bin/bash
# src/report.sh

CHECKPOINT_DIR="checkpoints"

# Function to generate the final report
function generateReport() {
  local findings=("$@")
  local report_file="azure_security_report_$(date +%Y%m%d_%H%M%S).json"
  local report_path="/app/output/$report_file"

  # Create the output directory if it doesn't exist
  mkdir -p /app/output

  # Generate the report JSON
  local report=$(cat <<EOF
{
  "timestamp": "$(date +%Y-%m-%d_%H:%M:%S)",
  "findings": [
    $(printf '%s\n' "${findings[@]}" | sed 's/$/,/' | sed '$ s/,$//')
  ]
}
EOF
)

  # Write the report to a file
  echo "$report" > "$report_path"

  echo "$report_path"
}

# Function to save checkpoint data
function saveCheckpoint() {
  local data=("${DATA[@]}")
  local findings=("${FINDINGS[@]}")
  local sub_index=$1

  # Create the checkpoint directory if it doesn't exist
  mkdir -p "$CHECKPOINT_DIR"

  # Save data and findings to checkpoint files
  echo "${data[@]}" > "$CHECKPOINT_DIR/data_checkpoint_$sub_index.json"
  echo "${findings[@]}" > "$CHECKPOINT_DIR/findings_checkpoint_$sub_index.json"

  echo "Checkpoint saved for subscription index $sub_index."
}

# Function to load checkpoint data
function loadCheckpoint() {
  local sub_index=$1
  local data_file="$CHECKPOINT_DIR/data_checkpoint_$sub_index.json"
  local findings_file="$CHECKPOINT_DIR/findings_checkpoint_$sub_index.json"

  # Check if checkpoint files exist
  if [[ -f "$data_file" && -f "$findings_file" ]]; then
    # Load data and findings from checkpoint files
    mapfile -t DATA < "$data_file"
    mapfile -t FINDINGS < "$findings_file"

    echo "Checkpoint loaded for subscription index $sub_index."
    return 0
  else
    echo "No checkpoint found for subscription index $sub_index."
    return 1
  fi
}

# Function to remove checkpoint data
function removeCheckpoint() {
  local sub_index=$1
  local data_file="$CHECKPOINT_DIR/data_checkpoint_$sub_index.json"
  local findings_file="$CHECKPOINT_DIR/findings_checkpoint_$sub_index.json"

  # Remove checkpoint files
  rm -f "$data_file" "$findings_file"

  echo "Checkpoint removed for subscription index $sub_index."
}