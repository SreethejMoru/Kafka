{% set kafka_service_content = '''
[Unit]
Description=Apache Kafka Server
After=network.target

[Service]
User=kafka
Group=kafka
ExecStart=/opt/kafka_2.12-3.3.1/kafka_2.12-3.3.1/bin/kafka-server-start.sh /opt/kafka_2.12-3.3.1/config/server.properties
ExecStop=/opt/kafka_2.12-3.3.1/kafka_2.12-3.3.1/bin/kafka-server-stop.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
''' %}

create_kafka_service_file:
  file.managed:
    - name: /etc/systemd/system/kafka.service
    - contents: |
        {{ kafka_service_content | indent(8) }}

reload_systemd_daemon_kafka:
  cmd.run:
    - name: systemctl daemon-reload
    - watch:
      - file: create_kafka_service_file

enable_kafka_service:
  service.running:
    - name: kafka
    - enable: True
    - watch:
      - file: create_kafka_service_file
      - cmd: reload_systemd_daemon_kafka
