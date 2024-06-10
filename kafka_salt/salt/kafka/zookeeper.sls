install_zookeeper:
  pkg.installed:
    - name: zookeeper

configure_zookeeper:
  file.managed:
    - name: /etc/zookeeper/conf/zoo.cfg
    - source: salt://kafka/files/zoo.cfg
    - user: root
    - group: root
    - mode: 644

enable_zookeeper_service:
  service.running:
    - name: zookeeper
    - enable: True
