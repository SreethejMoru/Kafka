create_kafka_data_dir:
  file.directory:
    - name: /opt/kafka_2.12-3.3.1/data
    - user: kafka
    - group: kafka
    - mode: 755
    - makedirs: True


create_kafka_log_dir:
  file.directory:
    - name: /opt/kafka_2.12-3.3.1/logs
    - user: kafka
    - group: kafka
    - mode: 777
    - makedirs: True


create_kafka_conf_dir:
  file.directory:
    - name: /opt/kafka_2.12-3.3.1/config
    - user: kafka
    - group: kafka
    - mode: 755
    - makedirs: True


  