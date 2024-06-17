# start_kafka_server.sls

start_kafka_server:
  cmd.run:
    - name: |
        cd /home/ec2-user/kafka_node/kafka_2.13-3.7.0/bin && \
        ./kafka-server-start.sh ../config/server.properties
    - user: kafka  # Adjust user as needed
    - group: kafka

