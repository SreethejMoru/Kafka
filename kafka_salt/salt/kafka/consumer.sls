create_consumer_script:
  file.managed:
    - name: /usr/local/bin/kafka-consumer.sh
    - source: salt://kafka/files/kafka-consumer.sh
    - user: root
    - group: root
    - mode: 755
