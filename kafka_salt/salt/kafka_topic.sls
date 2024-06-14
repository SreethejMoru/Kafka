create_kafka_topic:
  cmd.run:
    - name: /opt/kafka_2.12-3.3.1/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic HelloCloudclass --partitions 1 --replication-factor 1
    - runas: kafka
    - require:
      - cmd: start_kafka

list_kafka_topics:
  cmd.run:
    - name: /opt/kafka_2.12-3.3.1/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
    - runas: kafka
    - require:
      - cmd: create_kafka_topic
