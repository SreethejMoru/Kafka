configure_zookeeper:
  file.managed:
    - name: /opt/zookeeper-3.8.4/conf/zoo.cfg
    - source: salt://zookeeper/files/zoo.cfg
    - user: zookeeper
    - group: zookeeper
    - mode: 644

