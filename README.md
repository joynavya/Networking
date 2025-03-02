# Networking

Network Project

# Server Configuration Automation using Ansible

## Objectives
This playbook automates the configuration of a server by installing Docker and ensuring it starts on boot.

## Requirements
- Ansible installed on the local machine.
- A target server with SSH access.

## Files
1. **docker.yml**: Ansible playbook to install and configure Docker.
2. **inventory.ini**: Inventory file specifying the target server.

## Steps
1. **Install Dependencies**:
   Ensure Ansible is installed on your local machine.

   - On Ubuntu:
     sudo apt update
     sudo apt install ansible -y

2. **Configure the Inventory**:
   Edit the inventory.ini file to specify the target server's IP address and SSH details.

3. **Run the Playbook**:
   Run the playbook using the following command:
  
   ansible-playbook -i inventory.ini docker.yml

