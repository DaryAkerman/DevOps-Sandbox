# Azure DevOps Sandbox Project

## Overview
This project provides a fully automated and isolated environment for students to practice DevOps concepts using Azure. It includes modules for creating resource groups, virtual networks, virtual machines, monitoring, and automatic cleanup using bash(terraform destroy). Students can interact with the system by entering their details, and the infrastructure is dynamically created and managed through Terraform.

## Features
1. **Resource Groups**: Separate resource groups for each student and shared resources.
2. **Virtual Machines**: Each student gets a Linux virtual machine with Docker and Python pre-installed.
3. **Virtual Networks**: Isolated virtual networks for student environments.
4. **Monitoring**: Log Analytics Workspace and monitoring extensions for Azure VMs.
5. **RBAC (Role-Based Access Control)**: Custom roles assigned to students with the least privileges required.
6. **Automated Cleanup**: Schedules automatic deletion of all created resources at 21:00 Israel Time.
7. **Customizable Environment**: Easily update the project configuration via `terraform.tfvars`.

---

## File Structure
- **`modules/`**: Contains reusable Terraform modules.
  - **`resource_groups/`**: Module for creating resource groups.
  - **`virtual_network/`**: Module for setting up virtual networks.
  - **`virtual_machine/`**: Module for provisioning virtual machines.
  - **`shared_resources/`**: Module for shared storage accounts.
  - **`monitoring/`**: Module for monitoring and log analytics.
  - **`rbac/`**: Module for creating Azure AD users and assigning roles.
- **`terraform.tfvars`**: Contains configurable variables (e.g., student names, emails, and passwords).
- **`main.tf`**: Main Terraform configuration file.
- **`update_tfvars.sh`**: Script to update the `terraform.tfvars` file based on user input.
- **`remove.sh`**: Script to schedule or perform immediate resource destruction.
- **`main.sh`**: This is the main script that guides the user through the entire setup process, from updating variables to initializing Terraform and scheduling resource cleanup.

---

## Getting Started

### 1. Clone the Repository
```bash
git clone <repository_url>
cd <repository_name>
```

### 2. Run the main script
Run the `main.sh` script to add or update student details in the `terraform.tfvars` file.

```bash
bash main.sh
```
Follow the prompts to enter student names and emails. 
Automatic cleanup task scheduled at 21:00 Israel Time.

---

## Terraform Modules

### 1. **Resource Groups**
Manages the creation of resource groups for each student.

#### Variables:
- `name`: Name of the resource group.
- `location`: Location of the resource group.

---

### 2. **Shared Resources**
Creates shared resources for all students, including a storage account.

#### Outputs:
- `storage_account_name`
- `storage_account_key`

---

### 3. **Virtual Machines**
Manages the creation of virtual machines for students.

#### Features:
- Automatically installs Docker and Python on VMs.
- Assigns system-managed identity to VMs.

#### Variables:
- `name`: Name of the VM.
- `admin_username`: Admin username for the VM.
- `admin_password`: Admin password for the VM.

---

### 4. **Monitoring**
Sets up monitoring for the virtual machines using Azure Log Analytics.

#### Features:
- Deploys the Log Analytics workspace.
- Installs Log Analytics and Dependency agents on VMs.

---

### 5. **RBAC**
Manages Azure AD users and assigns roles to the created resource groups.

#### Features:
- Creates Azure AD users for students.
- Assigns least-privilege roles to students.

#### Variables:
- `students_info`: Map of student names and emails.
- `role_definition_name`: Role to assign to the resource group.

---

## Automated Cleanup
The cleanup process is managed by `remove.sh` that is used by `main.sh` script, which:
- Uses `terraform destroy` to delete all resources.
- Can be scheduled as a daily task or run immediately.

---

## Prerequisites
1. **Azure Account**: Ensure you have access to an Azure account with sufficient permissions.
2. **Tools Installed**:
   - Terraform
   - Bash (or Git Bash for Windows)
   - Azure CLI

---

## Notes
- **Security**: Ensure sensitive information like passwords is stored securely.
- **Customization**: Modify `terraform.tfvars` for project-specific changes.

