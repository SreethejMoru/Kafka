create_logs_directory:
  file.directory:
    - name: /opt/kafka_2.12-3.3.1/kafka_2.12-3.3.1/logs
    - user: kafka
    - group: kafka
    - mode: 755

