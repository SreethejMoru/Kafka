# describe_kafka_topic.sls

describe_kafka_topic:
  cmd.run:
    - name: /home/ec2-user/kafka_node/kafka_2.13-3.7.0/bin/kafka-topics.sh --topic test-topic --bootstrap-server kf_1_ip:9092,kf_2_ip:9092,kf_3_ip:9092 --describe
    - cwd: /home/ec2-user/kafka_node/kafka_2.13-3.7.0/bin
    - user: kafka  # Adjust user as needed
    - group: kafka

