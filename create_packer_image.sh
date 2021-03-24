# Create Azure resource group
az group create -n myResourceGroup-vmss -l eastus

# Create Azure credentials - Create a service principal with az ad sp create-for-rbac and output the credentials that Packer needs:

az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"

# To authenticate to Azure, you also need to obtain your Azure subscription ID with az account show:
az account show --query "{ subscription_id: id }"

# To build images, you create a template as a JSON file. In the template, you define builders and provisioners that carry out the actual build process.
Like I created vmss.json

# Build the image by specifying your Packer template file as follows:
packer build vmss.json

# Create VM from Azure Image. 
az vm create \
    --resource-group myResourceGroup-vmss \
    --name myVM \
    --image myPackerImage \
    --admin-username azureuser \
    --generate-ssh-keys

# To allow web traffic to reach your VM, open port 80 from the Internet with az vm open-port:
az vm open-port \
    --resource-group myResourceGroup \
    --name myVM \
    --port 80

# Test VM and NGINX
Now you can open a web browser and enter http://publicIpAddress in the address bar. Provide your own public IP address from the VM create process.