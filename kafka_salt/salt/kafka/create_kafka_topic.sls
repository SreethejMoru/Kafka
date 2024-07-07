# create_kafka_topic.sls

create_kafka_topic:
  cmd.run:
    - name: /home/ubuntu/kafka_node/kafka_2.13-3.7.0/bin/kafka-topics.sh --create --topic test-topic --bootstrap-server kf_1_ip:9092,kf_2_ip:9092,kf_3_ip:9092 --replication-factor 3 --partitions 64
    - cwd: /home/ubuntu/kafka_node/kafka_2.13-3.7.0/bin
    - user: admin  # Adjust user as needed
    - group: admin
    - require:
      - cmd: start_kafka_server  # Ensure Kafka server is running
