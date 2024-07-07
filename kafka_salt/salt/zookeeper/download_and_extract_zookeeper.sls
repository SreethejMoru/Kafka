download_zookeeper:
  cmd.run:
    - name: 'wget https://dlcdn.apache.org/zookeeper/zookeeper-3.9.2/apache-zookeeper-3.9.2-bin.tar.gz -P /home/admin/Zookeeper_node'
    - creates: /home/admin/Zookeeper_node/apache-zookeeper-3.9.2-bin.tar.gz

extract_zookeeper:
  cmd.run:
    - name: 'tar -xzf /home/admin/Zookeeper_node/apache-zookeeper-3.9.2-bin.tar.gz -C /home/admin/Zookeeper_node'
    - cwd: /home/admin/Zookeeper_node
    - creates: /home/admin/Zookeeper_node/apache-zookeeper-3.9.2-bin
