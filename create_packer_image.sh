# Create Azure resource group
az group create -n myResourceGroup-vmss -l eastus

# Create Azure credentials - Create a service principal with az ad sp create-for-rbac and output the credentials that Packer needs:

az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"

# To authenticate to Azure, you also need to obtain your Azure subscription ID with az account show:
az account show --query "{ subscription_id: id }"