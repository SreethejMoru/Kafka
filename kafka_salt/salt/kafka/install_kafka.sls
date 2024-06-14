install_kafka:
  archive.extracted:
    - name: /opt/kafka_2.12-3.3.1
    - source: /tmp/kafka_2.12-3.3.1.tgz
    - archive_format: tar
    - user: kafka
    - group: kafka
    - enforce_toplevel: False
    - if_missing: /opt/kafka_2.12-3.3.1
