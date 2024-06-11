install_kafka:
  pkg.installed:
    - name: java-1.8.0-openjdk
    - refresh: true

  file.managed:
    - name: /opt/kafka/kafka_2.13-2.8.0.tgz  # Specify the full path including the file name
    - source: salt://kafka/kafka_2.13-2.8.0.tgz
    - user: root
    - group: root
    - mode: 755
extract_and_setup_kafka:
  cmd.run:
    - name: |
        tar -xzf /opt/kafka/kafka_2.13-2.8.0.tgz -C /opt/kafka/  # Extract to the kafka directory
        # Use sudo tee with the <<EOF syntax to write systemd unit files
        echo '
        [Unit]
        Description=Apache Zookeeper server
        Documentation=http://zookeeper.apache.org
        Requires=network.target
        After=network.target

        [Service]
        Type=simple
        ExecStart=/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties
        ExecStop=/opt/kafka/bin/zookeeper-server-stop.sh
        Restart=on-abnormal

        [Install]
        WantedBy=multi-user.target
        ' | sudo tee /etc/systemd/system/zookeeper.service
        echo '
        [Unit]
        Description=Apache Kafka server (broker)
        Documentation=http://kafka.apache.org/documentation.html
        Requires=zookeeper.service
        After=zookeeper.service

        [Service]
        Type=simple
        ExecStart=/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
        ExecStop=/opt/kafka/bin/kafka-server-stop.sh
        Restart=on-abnormal

        [Install]
        WantedBy=multi-user.target
        ' | sudo tee /etc/systemd/system/kafka.service
        sudo systemctl enable zookeeper
        sudo systemctl enable kafka
        sudo systemctl start zookeeper
        sudo systemctl start kafka
    - unless: test -d /opt/kafka  # Only execute if Kafka directory doesn't exist
