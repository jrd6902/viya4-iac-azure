# !NOTE! - These are only a subset of CONFIG-VARS.md provided as examples.
# Customize this file to add any variables from 'CONFIG-VARS.md' whose default values you
# want to change.

# ****************  REQUIRED VARIABLES  ****************
# These required variables' values MUST be provided by the User
prefix   = "ITC" # this is a prefix that you assign for the resources to be created
location = "<azure-location-value>" # e.g., "eastus2"
# ****************  REQUIRED VARIABLES  ****************
tenant_id = "value"
subscription_id = "value"
client_id = "value"
client_secret = "value"
use_msi = false

# ****************  Admin Access VARIABLES  ****************
cluster_endpoint_public_access_cidrs = ["192.168.25.0/32"]
vm_public_access_cidrs = ["192.168.25.0/32"]
acr_public_access_cidrs = ["192.168.25.0/32"]

# ****************  Networking VARIABLES  ****************
cluster_egress_type = "loadBalancer" # options: "loadBalancer" or "userDefinedRouting"
aks_network_policy = "calico" # options: "calico" or "azure"

# ****************  REQUIRED VARIABLES  ****************

# !NOTE! - Without specifying your CIDR block access rules, ingress traffic
#          to your cluster will be blocked by default. In a SCIM environment,
#          the AzureActiveDirectory service tag must be granted access to port
#          443/HTTPS for the ingress IP address. 

# **************  RECOMMENDED  VARIABLES  ***************
default_public_access_cidrs = ["192.168.25.0/32"] # e.g., ["123.45.6.89/32"]
ssh_public_key              = "~/.ssh/id_rsa.pub"
# **************  RECOMMENDED  VARIABLES  ***************

# Tags can be specified matching your tagging strategy.
tags = {
  "owner|email" = "<you>@<domain>.<com>",
  "costcenter" = "itc",
  "project_name" = "sasviya4",
  "environment" = "dev"
}
# for example: { "owner|email" = "<you>@<domain>.<com>", "key1" = "value1", "key2" = "value2" }
aks_identity = "sp"
# Postgres config - By having this entry a database server is created. If you do not
#                   need an external database server remove the 'postgres_servers'
#                   block below.
#postgres_servers = {
#  default = {},
#}
# SKU Tier 
aks_cluster_sku_tier = "Standard" # options: "Free" or "Standard" and "Premium" 

# Azure Container Registry config
create_container_registry           = true
container_registry_sku              = "Standard"
container_registry_admin_enabled    = true

# AKS config
kubernetes_version         = "1.34"
default_nodepool_min_nodes = 2
default_nodepool_vm_type   = "Standard_E8s_v5"

# AKS Node Pools config
node_pools = {
  cas = {
    "machine_type" = "Standard_E16ds_v5"
    "os_disk_size" = 200
    "min_nodes"    = 1
    "max_nodes"    = 1
    "max_pods"     = 110
    "node_taints"  = ["workload.sas.com/class=cas:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "cas"
    }
  },
  compute = {
    "machine_type" = "Standard_D4ds_v5"
    "os_disk_size" = 200
    "min_nodes"    = 1
    "max_nodes"    = 1
    "max_pods"     = 110
    "node_taints"  = ["workload.sas.com/class=compute:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class"        = "compute"
      "launcher.sas.com/prepullImage" = "sas-programming-environment"
    }
  },
  stateless = {
    "machine_type" = "Standard_D4s_v5"
    "os_disk_size" = 200
    "min_nodes"    = 1
    "max_nodes"    = 4
    "max_pods"     = 110
    "node_taints"  = ["workload.sas.com/class=stateless:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "stateless"
    }
  },
  stateful = {
    "machine_type" = "Standard_D4s_v5"
    "os_disk_size" = 200
    "min_nodes"    = 1
    "max_nodes"    = 2
    "max_pods"     = 110
    "node_taints"  = ["workload.sas.com/class=stateful:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "stateful"
    }
  }
}

# Jump Server
create_jump_public_ip = true
enable_jump_public_static_ip = true
jump_vm_admin        = "jumpuser"
jump_vm_machine_type = "Standard_B2s"
jump_rwx_filestore_path = "/viya-share-rwx"
#Storage for SAS Viya CAS/Compute
storage_type = "standard"
# required ONLY when storage_type is "standard" to create NFS Server VM
create_nfs_public_ip = true
enable_nfs_public_static_ip = true
nfs_vm_admin         = "nfsuser"
nfs_vm_machine_type  = "Standard_D4s_v5"
nfs_raid_disk_size   = 256
nfs_raid_disk_type   = "Standard_LRS"




