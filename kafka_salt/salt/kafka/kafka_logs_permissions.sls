# kafka_logs_permissions.sls

/home/admin/kafka_node/kafka_2.13-3.7.0/logs:
  file.directory:
    - user: admin
    - group: admin
    - mode: 755
    - recurse:
      - user
      - group
      - mode

# zookeeper_data_permissions.sls

/var/lib/zookeeper:
  file.directory:
    - user: admin
    - group: admin
    - mode: 755
    - recurse:
      - user
      - group
      - mode