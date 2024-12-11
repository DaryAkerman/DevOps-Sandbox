#!/bin/bash
TERRAFORM_DIR="."

# Function to create a cron job
create_cron_job() {
    echo "Creating a cron job to run at 16:30 Israel Time daily..."
    crontab -l | grep -v "remove.sh 2" | crontab -

    (
        crontab -l 2>/dev/null
        echo "30 14 * * * bash $(realpath "$0") 2 >> /var/log/terraform_cleanup.log 2>&1"
    ) | crontab -

    echo "Cron job created. Resources will be destroyed daily at 16:30 Israel Time."
}

# Function to destroy resources immediately
destroy_resources_now() {
    echo "Starting immediate destruction of resources..."

    cd "$TERRAFORM_DIR" || {
        echo "Error: Terraform directory not found at $TERRAFORM_DIR"
        exit 1
    }

    terraform destroy -auto-approve

    if [ $? -eq 0 ]; then
        echo "Resources destroyed successfully!"
    else
        echo "Error occurred during destruction. Please check logs for details."
        exit 1
    fi
}

# Check if the user provided an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 {1|2}"
    echo "1: Schedule resource destruction daily at 16:30 Israel Time."
    echo "2: Destroy resources immediately."
    exit 1
fi

# Handle the user's choice
case $1 in
1)
    create_cron_job
    ;;
2)
    destroy_resources_now
    ;;
*)
    echo "Invalid option. Usage: $0 {1|2}"
    exit 1
    ;;
esac
