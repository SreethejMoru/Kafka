download_zookeeper:
  cmd.run:
    - name: 'wget https://dlcdn.apache.org/zookeeper/zookeeper-3.9.2/apache-zookeeper-3.9.2-bin.tar.gz -P /home/ec2-user/Zookeeper_node'
    - creates: /home/ec2-user/Zookeeper_node/apache-zookeeper-3.9.2-bin.tar.gz

extract_zookeeper:
  cmd.run:
    - name: 'tar -xzf /home/ec2-user/Zookeeper_node/apache-zookeeper-3.9.2-bin.tar.gz -C /home/ec2-user/Zookeeper_node'
    - cwd: /home/ec2-user/Zookeeper_node
    - creates: /home/ec2-user/Zookeeper_node/apache-zookeeper-3.9.2-bin
