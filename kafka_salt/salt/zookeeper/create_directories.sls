create_zookeeper_directories:
  file.directory:
    - name: /home/admin/Zookeeper_node
    - makedirs: True
    - user: admin
    - group: admin