create_zookeeper_directories:
  file.directory:
    - name: /home/ec2-user/Zookeeper_node
    - makedirs: True
    - user: root
    - group: root
