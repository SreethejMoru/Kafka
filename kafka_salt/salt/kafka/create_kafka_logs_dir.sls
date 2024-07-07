create_kafka_logs_directory:
  file.directory:
    - name: /tmp/kafka-logs
    - mode: 755
    - user: admin
    - group: admin
