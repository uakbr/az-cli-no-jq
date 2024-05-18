# Azure Resource Security Scanner

## Introduction
The Azure Resource Security Scanner is a comprehensive Bash script suite designed to assess and report on the security configurations of various Azure resources across multiple subscriptions. This tool leverages Azure CLI (`az-cli`) to interact with Azure resources, ensuring compatibility and ease of use within a Windows 10 Virtual Desktop Infrastructure (VDI) environment.

## Architecture and Design
The scanner is structured into several Bash scripts, each serving a distinct role in the scanning process:

- **Authentication (`auth.sh`)**: Handles Azure login and subscription management.
- **Data Collection (`collect.sh`)**: Gathers data from specified Azure resources.
- **Data Analysis (`analyze.sh`)**: Analyzes collected data to identify potential security issues.
- **Reporting (`report.sh`)**: Generates a report based on the findings from the analysis.
- **Main Script (`scanner.sh`)**: Orchestrates the process by calling functions from other scripts.

### Key Features
- **Modular Design**: Each major functionality (authentication, collection, analysis, reporting) is encapsulated in separate scripts.
- **Retry Logic**: Implements retries for data collection to handle intermittent network or API failures.
- **Checkpointing**: Saves progress at configurable intervals, allowing for recovery in case of interruptions.
- **Parallel Processing**: Although not implemented in the current version, the architecture allows for easy integration of parallel processing techniques to handle multiple subscriptions simultaneously.

## Usage
To use the scanner, ensure that Azure CLI is installed and configured on your system. The scanner can be initiated by running the `scanner.sh` script with appropriate flags.

### Command Line Options
- `-s | --subscriptions`: Comma-separated list of subscription IDs to scan.
- `-o | --output`: Path to save the generated report.
- `-a | --auth-method`: Authentication method (`browser`, `service-principal`, `interactive`).

Example:
```bash
./scanner.sh --subscriptions "sub1,sub2" --output "/path/to/report" --auth-method "service-principal"
```

## Compliance with Guidelines
- **No External Dependencies**: Uses only `bash` and `az-cli`.
- **Quote Variables**: All variables are properly quoted to prevent globbing and word splitting.
- **Encapsulate Code**: Functionality is encapsulated in functions across different scripts.
- **Minimize Disk I/O**: Uses in-memory operations where possible and writes to disk only for checkpoints and final reports.
- **Optimize Resource Use**: Efficient use of variables and minimal redundant data processing.
- **Retry Logic**: Implemented in data collection functions to handle API request failures.
- **Parallel Processing**: Designed for easy addition of parallel processing capabilities.

## Improvements and Future Work
- **Parallel Processing**: Implement parallel data collection for different subscriptions to enhance performance.
- **Dynamic Resource Type Handling**: Automate the inclusion of new Azure resource types without modifying the script.
- **Enhanced Error Handling**: Improve error reporting and handling mechanisms to provide clearer diagnostics.

## Conclusion
The Azure Resource Security Scanner is a robust tool designed to perform security assessments on Azure resources efficiently. Its modular architecture and adherence to best practices ensure that it is both maintainable and scalable, suitable for environments requiring stringent security measures.