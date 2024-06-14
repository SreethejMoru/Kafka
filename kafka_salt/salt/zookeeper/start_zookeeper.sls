start_zookeeper:
  cmd.run:
    - name: nohup /opt/kafka_2.12-3.3.1/bin/zookeeper-server-start.sh /opt/kafka_2.12-3.3.1/config/zoo.cfg > /opt/kafka_2.12-3.3.1/zookeeper.log 2>&1 &
    - user: zookeeper