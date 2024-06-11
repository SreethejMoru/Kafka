install_kafka:
  pkg.installed:
    - name: kafka

configure_kafka:
  file.managed:
    - name: /etc/kafka/server.properties
    - source: salt://kafka/files/server.properties
    - user: root
    - group: root
    - mode: 644

enable_kafka_service:
  service.running:
    - name: kafka
    - enable: True
    - require:
      - pkg: install_kafka
      - file: configure_kafka
