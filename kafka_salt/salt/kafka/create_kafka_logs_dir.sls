# create_kafka_logs_dir.sls

create_kafka_logs_directory:
  file.directory:
    - name: /tmp/kafka-logs
    - mode: 755
    - user: kafka  # Adjust user and group ownership as needed
    - group: kafka
