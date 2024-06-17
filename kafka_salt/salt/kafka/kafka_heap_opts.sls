kafka_heap_opts:
  file.replace:
    - name: /home/ec2-user/kafka_node/kafka_2.13-3.7.0/bin/kafka-server-start.sh
    - pattern: 'KAFKA_HEAP_OPTS=.*'
    - repl: 'KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"'