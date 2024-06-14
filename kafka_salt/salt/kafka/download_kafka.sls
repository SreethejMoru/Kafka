download_kafka:
  cmd.run:
    - name: "wget -O /tmp/kafka_2.12-3.3.1.tgz https://archive.apache.org/dist/kafka/3.3.1/kafka_2.12-3.3.1.tgz"
    - creates: /tmp/kafka_2.12-3.3.1.tgz
