#!/bin/bash

# Assign the first command line argument to 'command', defaulting to "start" if not provided
command=${1:-"start"}

# Set the ProjectRoot relative to the script location
ProjectRoot="$(dirname "$BASH_SOURCE")/.."

# Export environment variables
export AMBULANCE_API_ENVIRONMENT="Development"
export AMBULANCE_API_PORT="8080"

# Handle different commands
case "$command" in
    "start")
        go run "${ProjectRoot}/cmd/ambulance-api-service"
        ;;
    "openapi")
        docker run --rm -ti -v "${ProjectRoot}:/local" openapitools/openapi-generator-cli generate -c /local/scripts/generator-cfg.yaml
        ;;
    *)
        echo "Unknown command: $command"
        exit 1
        ;;
esac
