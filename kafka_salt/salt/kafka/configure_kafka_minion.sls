# kafka.configure_kafka_minion.sls

configure_kafka_rebel_1:
  file.managed:
    - name: /home/ec2-user/kafka_node/kafka_2.13-3.7.0/config/server.properties
    - contents: |
        broker.id=1
        listeners=PLAINTEXT://:9092
        log.dirs=/tmp/kafka-logs
        zookeeper.connect=zk_1_ip:2181,zk_2_ip:2181,zk_3_ip:2181
    - require:
      - cmd: extract_kafka  # Ensure 'extract_kafka' command completes first
    - onlyif: test "$(hostname)" = "rebel_1"  # Apply only on rebel_1 minion
