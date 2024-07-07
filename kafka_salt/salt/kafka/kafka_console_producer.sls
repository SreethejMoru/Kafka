# kafka_console_consumer.sls

kafka_console_producer:
  cmd.run:
    - name: /home/admin/kafka_node/kafka_2.13-3.7.0/bin/kafka-console-producer.sh --topic test-topic --bootstrap-server kf_1_ip:9092,kf_2_ip:9092,kf_3_ip:9092
    - cwd: /home/admin/kafka_node/kafka_2.13-3.7.0/bin
    - user: admin  # Adjust user as needed
    - group: admin
    - require:
      - cmd: start_kafka_server  # Ensure Kafka server is running
