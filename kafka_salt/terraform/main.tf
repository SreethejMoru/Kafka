
resource "aws_security_group" "salt_master_sg" {
  name_prefix = "salt-master-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider using your IP range for better security
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3888
    to_port     = 3888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2888
    to_port     = 2888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 3888
    to_port     = 3888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 2888
    to_port     = 2888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
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
    source      = "${path.module}/../salt"
    destination = "/tmp/salt/"
    connection {
      type        = "ssh"
      user        = "admin"
      port        = "22"
      private_key = file(var.private_key_path)
      host        = self.public_ip
      agent       = false # Use if you are not using SSH agent
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p ${var.salt_root_dir}",
      "sudo chown -R root:root ${var.salt_root_dir}",
      "sudo chmod -R ${var.salt_permissions} ${var.salt_root_dir}",
      "sudo cp -r ${var.salt_config_dir}/* ${var.salt_root_dir}/"
    ]
    connection {
      type        = "ssh"
      user        = "admin"
      password    = ""
      port        = "22"
      private_key = file(var.private_key_path)
      host        = self.public_ip
      timeout     = "5m" # Increase timeout for slow connections
      agent       = false
    }
  }
  tags = {
    Name = "Kafka_salt_master"
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
  provisioner "file" {
    source = "${path.module}/../salt"
    # source      = "/srv/salt/"
    destination = "/tmp/salt/"
    connection {
      type = "ssh"
      user = "admin"
      #password = ""
      port        = "22"
      private_key = file(var.private_key_path)
      host        = self.public_ip
      # timeout     = "10m"  # Increase timeout for slow connections
      agent = false # Use if you are not using SSH agent
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p ${var.salt_root_dir}",
      "sudo chown -R root:root ${var.salt_root_dir}",
      "sudo chmod -R ${var.salt_permissions} ${var.salt_root_dir}",
      "sudo cp -r ${var.salt_config_dir}/* ${var.salt_root_dir}/"
    ]
    connection {
      type        = "ssh"
      user        = "admin"
      password    = ""
      port        = "22"
      private_key = file(var.private_key_path)
      host        = self.public_ip
      timeout     = "5m" # Increase timeout for slow connections
      agent       = false
    }
  }

  tags = {
    Name = "Kafka_salt_minion${count.index + 1}"
  }
}
output "salt_master_public_ip" {
  value = aws_instance.salt_master.public_ip
}

output "salt_minion_public_ips" {
  value = [for instance in aws_instance.salt_minion : instance.public_ip]
}