#!/bin/bash

# Color codes for styling
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Welcome message with ASCII art
clear
echo -e "${CYAN}"
cat << "EOF"
      ___           ___           ___     
     /\__\         /\  \         /\  \    
    /:/  /        /::\  \       /::\  \   
   /:/  /        /:/\:\  \     /:/\:\  \  
  /:/  /  ___   /:/  \:\  \   /:/  \:\  \ 
 /:/__/  /\__\ /:/__/ \:\__\ /:/__/ \:\__\
 \:\  \ /:/  / \:\  \ /:/  / \:\  \ /:/  /
  \:\  /:/  /   \:\  /:/  /   \:\  /:/  / 
   \:\/:/  /     \:\/:/  /     \:\/:/  /  
    \::/  /       \::/  /       \::/  /   
     \/__/         \/__/         \/__/    

EOF
echo -e "${GREEN}Welcome to the Azure DevOps Sandbox Project!${NC}"
echo -e "${YELLOW}This script will guide you through the setup process.${NC}"
echo -e "${BLUE}-----------------------------------------------${NC}"
sleep 2

# Check if update_tfvars.sh exists
if [[ ! -f "update_tfvars.sh" ]]; then
  echo -e "${RED}Error: update_tfvars.sh script not found. Please ensure it is in the same directory.${NC}"
  exit 1
fi

# Step 1: Run update_tfvars.sh
echo -e "${CYAN}Running the update_tfvars.sh script...${NC}"
bash update_tfvars.sh
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Error: update_tfvars.sh script failed. Please check the script.${NC}"
  exit 1
fi
echo -e "${GREEN}update_tfvars.sh completed successfully!${NC}"

# Step 2: Initialize Terraform
echo -e "${CYAN}Initializing Terraform...${NC}"
terraform init
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Error: Terraform initialization failed. Please check your configuration.${NC}"
  exit 1
fi
echo -e "${GREEN}Terraform initialized successfully!${NC}"

# Step 3: Run Terraform plan
echo -e "${CYAN}Generating the Terraform plan...${NC}"
terraform plan
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Error: Terraform plan failed. Please check your configuration.${NC}"
  exit 1
fi
echo -e "${GREEN}Terraform plan generated successfully!${NC}"

# Step 4: Apply Terraform configuration
echo -e "${CYAN}Applying the Terraform configuration...${NC}"
terraform apply -auto-approve
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Error: Terraform apply failed. Please check your configuration.${NC}"
  exit 1
fi
echo -e "${GREEN}Terraform apply completed successfully!${NC}"

# Step 5: Schedule cleanup with remove.sh
if [[ ! -f "remove.sh" ]]; then
  echo -e "${RED}Error: remove.sh script not found. Please ensure it is in the same directory.${NC}"
  exit 1
fi
echo -e "${CYAN}Scheduling cleanup with remove.sh script...${NC}"
bash remove.sh 1
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Error: remove.sh script failed. Please check the script.${NC}"
  exit 1
fi
echo -e "${GREEN}Cleanup scheduled successfully!${NC}"

echo -e "${BLUE}-----------------------------------------------${NC}"
echo -e "${GREEN}Setup complete! Your Azure environment is ready to use.${NC}"
