download_zookeeper:
  cmd.run:
    - name: "wget -O /tmp/apache-zookeeper-3.8.4-bin.tar.gz https://dlcdn.apache.org/zookeeper/zookeeper-3.8.4/apache-zookeeper-3.8.4-bin.tar.gz"
    - creates: /tmp/apache-zookeeper-3.8.4-bin.tar.gz
