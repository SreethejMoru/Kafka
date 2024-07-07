# install_kafka.sls

# Step 1: Create directory kafka_node
create_kafka_node_directory:
  file.directory:
    - name: /home/admin/kafka_node
    - mode: 755

# Step 2: Download Kafka
download_kafka:
  cmd.run:
    - name: wget https://dlcdn.apache.org/kafka/3.7.0/kafka_2.13-3.7.0.tgz -O /home/admin/kafka_node/kafka_2.13-3.7.0.tgz
    - cwd: /home/admin/kafka_node
    - creates: /home/admin/kafka_node/kafka_2.13-3.7.0.tgz
    - require:
      - file: create_kafka_node_directory

# Step 3: Extract Kafka
extract_kafka:
  cmd.run:
    - name: tar -xzf /home/admin/kafka_node/kafka_2.13-3.7.0.tgz -C /home/admin/kafka_node
    - cwd: /home/admin/kafka_node
    - creates: /home/admin/kafka_node/kafka_2.13-3.7.0
    - require:
      - cmd: download_kafka
