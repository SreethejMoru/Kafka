kafka_heap_opts:
  file.replace:
    - name: /opt/kafka_2.12-3.3.1/bin/kafka-server-start.sh
    - pattern: 'KAFKA_HEAP_OPTS=.*'
    - repl: 'KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"'
