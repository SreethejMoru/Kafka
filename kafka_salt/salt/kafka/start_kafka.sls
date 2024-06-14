start_kafka:
  cmd.run:
    - name: "nohup /opt/kafka_2.12-3.3.1/bin/kafka-server-start.sh /opt/kafka_2.12-3.3.1/config/server.properties > /opt/kafka_2.12-3.3.1/logs/kafka.log 2>&1 &"
    - require:
      - file: /opt/kafka_2.12-3.3.1/config/server.properties
      - file: create_kafka_log_dir
