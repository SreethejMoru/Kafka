set_permissions:
  cmd.run:
    - name: chown -R kafka:kafka /opt/kafka_2.12-3.3.1/kafka_2.12-3.3.1/
    - runas: root

