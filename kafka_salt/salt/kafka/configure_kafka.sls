configure_kafka:
  file.managed:
    - name: /opt/kafka_2.12-3.3.1/config/server.properties
    - source: salt://kafka/files/server.properties
    - user: kafka
    - group: kafka
    - mode: 644
    - require:
      - file: create_kafka_conf_dir
