install_zookeeper:
  archive.extracted:
    - name: /opt/zookeeper-3.8.4
    - source: /tmp/apache-zookeeper-3.8.4-bin.tar.gz
    - archive_format: tar
    - user: zookeeper
    - group: zookeeper
    - enforce_toplevel: False
    - if_missing: /opt/zookeeper-3.8.4
