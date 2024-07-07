# create_zookeeper_dirs.sls

/var/lib/zookeeper/version-2:
  file.directory:
    - user: admin
    - group: admin
    - mode: 755
    - makedirs: True

/home/admin/kafka_node/kafka_2.13-3.7.0/logs:
  file.directory:
    - user: admin
    - group: admin
    - mode: 755
