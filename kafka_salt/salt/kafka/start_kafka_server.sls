# start_kafka_server.sls

start_kafka_server:
  cmd.run:
    - name: |
        cd /home/admin/kafka_node/kafka_2.13-3.7.0/bin &&
        ./kafka-server-start.sh ../config/server.properties
    - user: admin  # Adjust user as needed
    - group: admin
    - cwd: /home/admin/kafka_node/kafka_2.13-3.7.0/bin
