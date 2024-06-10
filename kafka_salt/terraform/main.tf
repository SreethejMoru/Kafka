# Define security groups for Salt master and minions
resource "aws_security_group" "salt_master_sg" {
  name_prefix = "salt-master-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider using your IP range for better security
  }
  ingress {
    from_port   = 4505
    to_port     = 4506
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Define ingress and egress rules as needed
}

resource "aws_security_group" "salt_minion_sg" {
  name_prefix = "salt-minion-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider using your IP range for better security
  }
  ingress {
    from_port   = 4505
    to_port     = 4506
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define Salt master instance
resource "aws_instance" "salt_master" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.salt_master_sg.name]
  user_data       = file("user_data_salt_master.sh")


  provisioner "file" {
    source = "${path.module}/../salt/"
    # source      = "/srv/salt/"
    destination = "/tmp/salt/"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
      timeout     = "10m"  # Increase timeout for slow connections
      agent       = true # Use if you are not using SSH agent
    }
  }

  provisioner "remote-exec" {
    inline = [
      # "sudo mkdir -p /srv/salt/",
      # "sudo mv /tmp/salt/* /srv/salt/",
      # "sudo chown -R root:root /srv/salt/",  
      #   "echo 'Creating /srv/salt directory' > /tmp/provision.log",
      # "sudo mkdir -p /srv/salt >> /tmp/provision.log 2>&1",
      # "sudo chown -R root:root /srv/salt >> /tmp/provision.log 2>&1",
      # "echo 'Copying files from /tmp/salt to /srv/salt' >> /tmp/provision.log",
      # "sudo cp -r /tmp/salt/* /srv/salt/ >> /tmp/provision.log 2>&1",
      # "echo 'Setting permissions for /srv/salt' >> /tmp/provision.log",
      # "sudo chmod -R 755 /srv/salt >> /tmp/provision.log 2>&1",
      "sudo systemctl restart salt-master",
      "sudo salt '*' state.apply"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
      timeout     = "5m" # Increase timeout for slow connections
      agent       = false
    }
  }
  tags = {
    Name = "Salt_Master"
  }
}

# Define Salt minion instances
resource "aws_instance" "salt_minion" {
  count           = var.minion_count
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.salt_minion_sg.name]
  user_data = templatefile("user_data_salt_minion.sh", {
    master_private_ip = aws_instance.salt_master.private_ip
  })

  tags = {
    Name = "Salt_Minion${count.index + 1}"
  }
}

# Output Salt master public IP and Salt minion public IPs
output "salt_master_public_ip" {
  value = aws_instance.salt_master.public_ip
}

output "salt_minion_public_ips" {
  value = [for instance in aws_instance.salt_minion : instance.public_ip]
}
