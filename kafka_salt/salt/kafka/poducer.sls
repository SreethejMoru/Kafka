create_producer_script:
  file.managed:
    - name: /usr/local/bin/kafka-producer.sh
    - source: salt://kafka/files/kafka-producer.sh
    - user: root
    - group: root
    - mode: 755
