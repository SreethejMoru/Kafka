#!/bin/bash
sudo yum update -y
sudo yum install -y curl
sudo rpm --import https://repo.saltproject.io/salt/py3/amazon/2/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub
curl -fsSL https://repo.saltproject.io/salt/py3/amazon/2/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt-amzn.repo
echo "===> executing yum clean expire-cache"
sudo yum clean expire-cache
echo "===> executing install salt-minion"
sudo yum -y install salt-minion
echo "===> executing override"
sudo yum install -y aws-cli salt-minion

# Fetch the Salt master instance ID dynamically
MASTER_INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=Salt_Master" --query "Reservations[*].Instances[*].InstanceId" --output text)
echo "Master Instance ID: $MASTER_INSTANCE_ID"

# Fetch the private IP address of the Salt master instance
MASTER_PRIVATE_IP=$(aws ec2 describe-instances --instance-ids $MASTER_INSTANCE_ID --query "Reservations[*].Instances[*].PrivateIpAddress" --output text)
echo "Master Private IP: $MASTER_PRIVATE_IP"

# Write the master IP address to the minion configuration file
cat <<EOF | sudo tee /etc/salt/minion.d/master.conf > /dev/null
# Override the default Salt master setting
master: $MASTER_PRIVATE_IP
EOF
echo "===> executing ddclaration"
cat <<EOF | sudo tee /etc/salt/minion.d/id.conf
# Declare the minion ID
id: rebel_1
EOF

sudo systemctl enable salt-minion 
sudo systemctl start salt-minion

